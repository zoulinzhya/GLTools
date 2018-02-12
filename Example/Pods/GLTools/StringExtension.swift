//
//  StringExtension.swift
//  FBSnapshotTestCase
//
//  Created by zoulin on 2018/2/12.
//

import Foundation
import UIKit


public
extension String {
    
    //数字和字母
    var isBarCode: Bool {
        let emailRegex = "^[A-Za-z0-9]+$"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: self)
    }
    
    //数字
    var isNumber: Bool {
        let emailRegex = "^[0-9]*$"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: self)
    }
    
    // Email validation
    var isEmail: Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: self)
    }
    
    //验证密码是否符合规则 8-20位字符，必须包含字母和数字，字母区分大小写
    var isPwdConformRule: Bool
    {
        let match = "(^(?=.*[0-9])(?=.*[a-zA-Z])(.{8,20})$)"
        return NSPredicate(format: "SELF MATCHES %@", match).evaluate(with: self)
    }
    
    // Email validation
    var isPhoneNumber: Bool {
        let phoneRegex = "^((1[34578][0-9]{9})|((0\\d{2}-\\d{8})|(0\\d{3}-\\d{7,8})|(0\\d{10,11}))|(((400)-(\\d{3})-(\\d{4}))|((400)-(\\d{4})-(\\d{3}))|((400)-(\\d{5})-(\\d{2}))|(400\\d{7}))|(((800)-(\\d{3})-(\\d{4}))|((800)-(\\d{4})-(\\d{3}))|((800)-(\\d{5})-(\\d{2}))|(800\\d{7})))$"
        return NSPredicate(format: "SELF MATCHES %@", phoneRegex).evaluate(with: self)
    }
    
    var isTelPhoneNumber:Bool {
        let phoneRegex = "^(((0\\d{2}-\\d{8})|(0\\d{3}-\\d{7,8})|(0\\d{10,11}))|(((400)-(\\d{3})-(\\d{4}))|((400)-(\\d{4})-(\\d{3}))|((400)-(\\d{5})-(\\d{2}))|(400\\d{7}))|(((800)-(\\d{3})-(\\d{4}))|((800)-(\\d{4})-(\\d{3}))|((800)-(\\d{5})-(\\d{2}))|(800\\d{7})))$"
        return NSPredicate(format: "SELF MATCHES %@", phoneRegex).evaluate(with: self)
    }
    
    var isMobilePhone: Bool {
        let mobilePhone = "^(1[34578][0-9]{9})|((0\\d{2}-\\d{8})|(0\\d{3}-\\d{7,8})|(0\\d{10,11}))$"
        return NSPredicate(format: "SELF MATCHES %@", mobilePhone).evaluate(with: self)
    }
    
    var isEnglishCharater: Bool {
        let englishCharater = "^([A-Za-z])$"
        return NSPredicate(format: "SELF MATCHES %@", englishCharater).evaluate(with: self)
    }
    
    var isCarlisence: Bool {
        let carlisence = "^([\\u4e00-\\u9fa5]{1}[a-zA-Z]{1}[a-zA-Z_0-9]{5})$"
        return NSPredicate(format: "SELF MATCHES %@", carlisence).evaluate(with: self)
    }
    
    //中文判断
    var isNickName: Bool {
        let nickNameReg = "^([\\u4E00-\\u9FA5]{2,30}$)"
        return NSPredicate(format: "SELF MATCHES %@",nickNameReg).evaluate(with: self)
    }
    
    //判断字符串中是否包含汉字
    var isChiness: Bool {
        let chinessReg = "^(.*[\\u4e00-\\u9fa5].*$)"
        return NSPredicate(format: "SELF MATCHES %@",chinessReg).evaluate(with: self)
    }
    
    var isName: Bool {
        let nameReg = "^([\\u4E00-\\u9FA5A-Za-z0-9_]{2,10}$)"
        return NSPredicate(format: "SELF MATCHES %@",nameReg).evaluate(with: self)
    }
    
    // postCode validation
    var isPostCode: Bool {
        let phoneRegex = "^[0-8]\\d{5}(?!\\d)$"
        return NSPredicate(format: "SELF MATCHES %@", phoneRegex).evaluate(with: self)
    }
    
    //验证是否有非字母和数字之外的字符
    var isTaxNumber: Bool{
        let taxNumber = "^[A-Za-z0-9]+$"
        return NSPredicate(format: "SELF MATCHES %@", taxNumber).evaluate(with: self)
    }
    
    //验证是否有非字母数字下划线@之外的字符
    var isEmailCharacter:Bool{
        let taxNumber = "^[a-zA-Z0-9_@.]*$"
        return NSPredicate(format: "SELF MATCHES %@", taxNumber).evaluate(with: self)
    }
    
    //验证是否有非字母数字半角符号-之外的字符
    var isOECharacter:Bool{
        let taxNumber = "^[a-zA-Z0-9-.]*$"
        return NSPredicate(format: "SELF MATCHES %@", taxNumber).evaluate(with: self)
    }
    
    //验证是否有非字母数字下划线之外的字符
    var isUserNameCharacter:Bool{
        let taxNumber = "^[a-zA-Z0-9_]*$"
        return NSPredicate(format: "SELF MATCHES %@", taxNumber).evaluate(with: self)
    }
    
    //是否是用户名格式
    var isUserName:Bool{
        let taxNumber = "^[a-zA-Z][a-zA-Z0-9_]{4,19}$"
        return NSPredicate(format: "SELF MATCHES %@", taxNumber).evaluate(with: self)
    }
    
    //价格
    func isPrice() -> Bool{
        let price = "^(([0-9]+\\.[0-9]*[1-9][0-9]*)|([0-9]*[1-9][0-9]*\\.[0-9]+)|([0-9]*[1-9][0-9]*))|(\\.[0-9]+)|[0-9]*[1-9][0-9]*\\.$"
        return NSPredicate(format: "SELF MATCHES %@", price).evaluate(with: self)
    }
    
    //字符串 替换
    /*
     let a = "17600007218"
     let b = a.replacingOccurrences(of: "0000", with: "xxxx")
     */
    func replaceSubContent(content:String, with:String) -> String {
        let replaced:String = self.replacingOccurrences(of: content, with: with)
        return replaced
    }
}
