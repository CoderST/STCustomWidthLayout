//
//  ViewController.swift
//  STCustomWidthLayoutExample
//
//  Created by xiudou on 2016/12/2.
//  Copyright © 2016年 CoderST. All rights reserved.
//

import UIKit
import STCustomWidthLayout
class ViewController: UIViewController {

    // MARK:- 懒加载
    fileprivate lazy var array : [TestModel] = [TestModel]()
    fileprivate lazy var collectionView : UICollectionView = {[weak self] in
        let layout = STCustomWidthLayout()
        layout.delegate = self
        let collectionView = UICollectionView(frame: (self?.view.bounds)!, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.orange
        collectionView.dataSource = self
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        
        return collectionView
        }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
        let button = UIButton(type: UIButtonType.contactAdd)
        button.center = CGPoint(x: 300, y: 100)
        button.addTarget(self, action: #selector(ViewController.buttonClick), for: .touchUpInside)
        view.addSubview(button)

        
    }
    
    // MARK:- 点击事件
    func buttonClick(){
        let model = TestModel(width : CGFloat(arc4random_uniform(50) + 30),height : 50)
        
        array.append(model)
        
        collectionView.reloadData()
    }
    


}
// MARK:- UICollectionViewDataSource
extension ViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        print(array.count)
        return array.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        
        cell.backgroundColor = UIColor.red
        
        return cell
    }
    
}

// MARK:- STRowFollowLayoutDelegate
extension ViewController : STCustomWidthLayoutDelegate {
    func stLayoutWidthtForRowAtIndexPath(_ stLayout: STCustomWidthLayout, indexPath: IndexPath) -> CGFloat {
        let model = array[indexPath.item]
        return model.width
    }
    
    func heightForRowAtIndexPath(_ stLayout: STCustomWidthLayout) -> CGFloat {
        
        return 40
    }
    
}
