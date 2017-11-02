//
//  TableViewCellModel.swift
//  SwiftLearn
//
//  Created by zoulin on 2017/6/30.
//  Copyright © 2017年 zoulin. All rights reserved.
//

import Foundation
import UIKit


struct TableViewCellModel {
    var reuseIdentifier : String
    var dataModel: AnyObject
    var rowHeight : CGFloat
    
    init(identifier:String, height:CGFloat, model:AnyObject) {
        self.reuseIdentifier = identifier
        self.dataModel = model
        self.rowHeight = height
    }
}
