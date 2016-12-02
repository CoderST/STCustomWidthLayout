//
//  ViewController.swift
//  STCustomWidthLayoutExample
//
//  Created by xiudou on 2016/12/2.
//  Copyright © 2016年 CoderST. All rights reserved.
//

import UIKit
class ViewController: UIViewController {

    // MARK:- 懒加载
    private lazy var array : [TestModel] = [TestModel]()
//    private lazy var collectionView : UICollectionView = {[weak self] in
//        let layout = STCustomWidthLayout()
////        layout.delegate = self
//        let collectionView = UICollectionView(frame: (self?.view.bounds)!, collectionViewLayout: layout)
//        collectionView.backgroundColor = UIColor.orangeColor()
//        collectionView.dataSource = self
//        
//        
//        collectionView.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
//        
//        return collectionView
//        }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
//        view.addSubview(collectionView)
//        let button = UIButton(type: UIButtonType.ContactAdd)
//        button.center = CGPoint(x: 300, y: 100)
//        button.addTarget(self, action: "buttonClick", forControlEvents: .TouchUpInside)
//        view.addSubview(button)

        
    }
    
    // MARK:- 点击事件
//    func buttonClick(){
//        let model = TestModel(width : CGFloat(arc4random_uniform(50) + 30),height : 50)
//        
//        array.append(model)
//        
//        collectionView.reloadData()
//    }
    


}
// MARK:- UICollectionViewDataSource
//extension ViewController : UICollectionViewDataSource {
//    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
//        
//        return array.count
//    }
//    
//    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell{
//        
//        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath)
//        
//        cell.backgroundColor = UIColor.redColor()
//        
//        return cell
//    }
//    
//}
//
// MARK:- STRowFollowLayoutDelegate
//extension ViewController : STCustomWidthLayoutDelegate {
//    func stLayoutWidthtForRowAtIndexPath(stLayout: STCustomWidthLayout, indexPath: NSIndexPath) -> CGFloat {
//        let model = array[indexPath.item]
//        return model.width
//    }
//    
//    func heightForRowAtIndexPath(stLayout: STCustomWidthLayout) -> CGFloat {
//        
//        return 40
//    }
//    
//}
