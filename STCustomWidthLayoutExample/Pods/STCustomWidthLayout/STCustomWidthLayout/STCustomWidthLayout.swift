//
//  STCustomWidthLayout.swift
//  STCustomWidthLayout
//
//  Created by xiudou on 2016/12/1.
//  Copyright © 2016年 CoderST. All rights reserved.
//

import UIKit
// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}


 @objc public protocol STCustomWidthLayoutDelegate : class {
    // Variable height support
     func stLayoutWidthtForRowAtIndexPath(_ stLayout : STCustomWidthLayout, indexPath : IndexPath)->CGFloat
    // Height of Item
    @objc optional func heightForRowAtIndexPath(_ stLayout : STCustomWidthLayout)->CGFloat
    // Space of Colums
    @objc optional func layoutcolumnSpacingStLayout(_ stLayout : STCustomWidthLayout)->CGFloat
    // Space of Row
    @objc optional func layoutRowSpacingStLayout(_ stLayout : STCustomWidthLayout)->CGFloat
    // TOP DOWN LEFT RIGHT
    @objc optional func layoutEdgeInsetsStLayout(_ stLayout : STCustomWidthLayout)->UIEdgeInsets
}

// UIScreen Width
let WINDOW_WIDTH = UIScreen.main.bounds.size.width
// UIScreen Height
let WINDOW_HEIGHT = UIScreen.main.bounds.size.height

// MARK:- 默认尺寸
/** item高度 */
private let stItemHeight : CGFloat = 100
/** 列间距 */
private let stColumSpacing : CGFloat = 10
/** 行间距 */
private let stRowSpacing : CGFloat = 10
/** 边缘间距 */
private let stEdgeInsets : UIEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)

open class STCustomWidthLayout: UICollectionViewFlowLayout {
    
    // MARK:- 变量
    
    /** 记录当前是第几行 */
    fileprivate var stCurrentRow : Int = 0
    /** 每一个item左边的的位置 */
    fileprivate var stItemLeft : CGFloat = 0
    /** 代理 */
    weak open var delegate : STCustomWidthLayoutDelegate?
    
    /** 边缘间距 */
    fileprivate var stEdgeInsets_c : UIEdgeInsets?{
        
        return delegate?.layoutEdgeInsetsStLayout?(self) ?? stEdgeInsets
    }
    /** item高度 */
    fileprivate var stItemHeight_c : CGFloat?{
        
        return delegate?.heightForRowAtIndexPath?(self) ?? stItemHeight
    }
    /** 列间距 */
    fileprivate var stColumSpacing_c : CGFloat?{
            return delegate?.layoutcolumnSpacingStLayout?(self) ?? stColumSpacing
    }
    /** 行间距 */
    fileprivate var stRowSpacing_c : CGFloat?{
        return delegate?.layoutRowSpacingStLayout?(self) ?? stRowSpacing
    }
    
    
    // MARK:- 懒加载
    /** atttibutesArray */
    fileprivate lazy var atttibutesArray : [UICollectionViewLayoutAttributes] = [UICollectionViewLayoutAttributes]()
    
}

extension STCustomWidthLayout {
    
    // MARK:- 准备工作
    override open func prepare() {
        super.prepare()
        stItemLeft = 0
        stCurrentRow = 0
        // 0 清除数据
        atttibutesArray.removeAll()
        // 1 获取总共有多少item(一般情况下是一部分)
        guard let count = collectionView?.numberOfItems(inSection: 0) else { return }
//        for (var index = 0; index < count; index += 1){
            for index in 0..<count {
            
            // 2 获取对象的indexPath
            let indexPath = IndexPath(row: index, section: 0)
            // 3 去除对应indexPath的LayoutAttributes对象
            if let attributes = layoutAttributesForItem(at: indexPath){
                // 4 添加到数组
                atttibutesArray.append(attributes)
            }
        }
        
    }
    
    // return an array layout attributes instances for all the views in the given rect
    override open func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return atttibutesArray
    }
    
    
    override open func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
        print(indexPath.item,stItemHeight_c,stColumSpacing_c)
        if let width = delegate?.stLayoutWidthtForRowAtIndexPath(self, indexPath: indexPath){
            
            if (stEdgeInsets_c!.left + stItemLeft + stColumSpacing_c! + width + stEdgeInsets_c!.right > WINDOW_WIDTH){
                stItemLeft = stEdgeInsets_c!.left
                stCurrentRow += 1
            }else{
                stItemLeft = stItemLeft + stEdgeInsets_c!.left + ( stColumSpacing_c!)
            }
            
            let top = stEdgeInsets_c!.top + CGFloat(stCurrentRow) * (stItemHeight_c! + stRowSpacing_c!)
            // 处理第一行第一个item X的位置
            if (top == stEdgeInsets_c!.top && stItemLeft == stEdgeInsets_c!.left + stColumSpacing_c!) {
                stItemLeft = stEdgeInsets_c!.left
            }
            attributes.frame = CGRect(x: stItemLeft, y: top, width: width, height: stItemHeight_c!);
            // 记录itemLeft位置
            stItemLeft = stItemLeft + width
        }
        return attributes
    }
    
    // Subclasses must override this method and use it to return the width and height of the collection view’s content. These values represent the width and height of all the content, not just the content that is currently visible. The collection view uses this information to configure its own content size to facilitate scrolling
    override open var collectionViewContentSize : CGSize {
        return CGSize(width: 0, height: stEdgeInsets_c!.top + CGFloat(stCurrentRow + 1 ) * (stItemHeight_c! + stRowSpacing_c!) - stRowSpacing_c! + stEdgeInsets_c!.bottom);
        
    }
}
