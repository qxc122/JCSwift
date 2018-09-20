//
//  PositionChange.swift
//  JCSwift
//
//  Created by MiNi on 2018/4/23.
//  Copyright © 2018年 wdada0620@gmail.com. All rights reserved.
//

import Foundation
import UIKit

//import CommonCrypto
//import crypto

extension UIButton {
    
    func set(image anImage: UIImage?, title: NSString,
                   titlePosition: UIViewContentMode, additionalSpacing: CGFloat, state: UIControlState){
        self.imageView?.contentMode = .center
        self.setImage(anImage, for: state)
        
        positionLabelRespectToImage(title: title as NSString, position: titlePosition, spacing: additionalSpacing)
        
        self.titleLabel?.contentMode = .center
        self.setTitle(title as String, for: state)
    }
    
    private func positionLabelRespectToImage(title: NSString, position: UIViewContentMode,
                                             spacing: CGFloat) {
        let imageSize = self.imageRect(forContentRect: self.frame)
        let titleFont = self.titleLabel?.font!
        let titleSize = title.size(withAttributes: [kCTFontAttributeName as NSAttributedStringKey : titleFont!])
        
        var titleInsets: UIEdgeInsets
        var imageInsets: UIEdgeInsets
        
        switch (position){
        case .top:
            titleInsets = UIEdgeInsets(top: -(imageSize.height + titleSize.height + spacing),
                                       left: -(imageSize.width), bottom: 0, right: 0)
            imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -titleSize.width)
        case .bottom:
            titleInsets = UIEdgeInsets(top: (imageSize.height + titleSize.height + spacing),
                                       left: -(imageSize.width), bottom: 0, right: 0)
            imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -titleSize.width)
        case .left:
            titleInsets = UIEdgeInsets(top: 0, left: -(imageSize.width * 2), bottom: 0, right: 0)
            imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0,
                                       right: -(titleSize.width * 2 + spacing))
        case .right:
            titleInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -spacing)
            imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        default:
            titleInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
        
        self.titleEdgeInsets = titleInsets
        self.imageEdgeInsets = imageInsets
    }
}

extension UIColor {
    func creatImageWithColor()->UIImage{
        let rect = CGRect.init(x: 0, y: 0, width: 1.0, height: 1.0)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(self.cgColor)
        context!.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}

enum strType:Int {
    case email
    case phone
    case card
}

extension String{
    //检查结果是否合法
    func validateType(_ type:strType? = .email) -> Bool {
        var emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        if type == strType.phone {
            emailRegex = "^((1[0-9][0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$"
        } else if type == strType.card {
            emailRegex = "^(\\d{14}|\\d{17})(\\d|[xX])$"
        }
        let emailTest:NSPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailTest.evaluate(with: self)
    }
    
    private func validateHasAbcxyz() -> Bool {
        for char in self.utf8  {
            if (char > 64 && char < 91) || (char > 96 && char < 123) {
                return true
            }
        }
        return false
    }
    private func validateHasNumerals() -> Bool {
        for char in self.utf8  {
            if (char >= 48 && char <= 57) {
                return true
            }
        }
        return false
    }
    func validateHasNumeralsAndNumerals() -> Bool {
        return self.validateHasAbcxyz() && self.validateHasNumerals()
    }
    
    //检查输入是否合法
    func validateMailboxinput() -> Bool {
        var res = false
        for char in self.utf8  {
            if (char > 64 && char < 91) || (char > 96 && char < 123) || char == 64 || char == 46 || (char >= 48 && char <= 57) {
                res = true
            }else{
               return false
            }
        }
        return res
    }
    
    func validatePassWordinput() -> Bool {
        var res = false
        for char in self.utf8  {
            if (char > 64 && char < 91) || (char > 96 && char < 123) || (char >= 48 && char <= 57) {
                res = true
            }else{
                return false
            }
        }
        return res
    }
    
    func validateNameinput() -> Bool {
        var res = false
        for char in self.utf8  {
            if (char > 64 && char < 91) || (char > 96 && char < 123) {
                res = true
            }else{
                return false
            }
        }
        return res
    }
    func validateNumeralsinput() -> Bool {
        var res = false
        for char in self.utf8  {
            if (char >= 48 && char <= 57) {
                res = true
            }else{
                return false
            }
        }
        return res
    }
}

extension String{
    func getDictionaryFromJSONString() ->NSDictionary{
        let jsonData:Data = self.data(using: .utf8)!
        let dict = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers)
        if dict != nil {
            return dict as! NSDictionary
        }
        return NSDictionary()
    }
}




extension Dictionary{
    func transformToJSONString() -> String {
        if (!JSONSerialization.isValidJSONObject(self)) {
            print("无法解析出JSONString")
            return ""
        }
        let data : NSData! = try! JSONSerialization.data(withJSONObject: self, options: []) as NSData?
        let JSONString = NSString(data:data as Data,encoding: String.Encoding.utf8.rawValue)
        return JSONString! as String
    }
}

