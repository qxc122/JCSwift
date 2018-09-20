//
//  RandomString.swift
//  JCSwift
//
//  Created by MiNi on 2018/4/28.
//  Copyright © 2018年 wdada0620@gmail.com. All rights reserved.
//

import Foundation
import KeychainAccess
class RandomString {
    /** 生成随机字符串, - parameter length: 生成的字符串的长度 - returns: 随机生成的字符串 */
    private func getRandomStringOfLength(length: Int) -> String {
        let keychain = Keychain(service: "com.tempus.github-UUID")
        let uuid = keychain["UUID"]
        if uuid == nil {
            let all = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
            var ranStr = ""
            for _ in 0..<length {
                let index = Int(arc4random_uniform(UInt32(all.count)))
                ranStr.append(all[all.index(all.startIndex, offsetBy: index)])
            }
            keychain["UUID"] = ranStr
            return ranStr
        } else {
            return uuid!
        }
    }
    private init() {

    }
    var uuid : String{
        get{
            return getRandomStringOfLength(length: 40)
        }
    }
    static let sharedInstance = RandomString()
}

