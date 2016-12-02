//
//  TestModel.swift
//  STRowFollowLayout
//
//  Created by xiudou on 2016/12/1.
//  Copyright © 2016年 CoderST. All rights reserved.
//

import UIKit

class TestModel: NSObject {

    var width : CGFloat = 0
    var height : CGFloat = 0
    
    init(width : CGFloat, height : CGFloat) {
        super.init()
        
        self.width = width
        self.height = height
    }
}
