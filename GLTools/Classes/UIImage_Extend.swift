//
//  UIImage_Extend.swift
//  GLTDemo
//
//  Created by zoulin on 2017/10/20.
//  Copyright © 2017年 zoulin. All rights reserved.
//

import Foundation
import UIKit

public
extension UIImage {
    public class func image(color : UIColor, size : CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
        
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(CGRect(origin: CGPoint.zero, size: size))
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image ?? UIImage()
    }
    
    
}
