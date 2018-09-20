//
//  dataModel.swift
//  JCSwift
//
//  Created by MiNi on 2018/4/25.
//  Copyright © 2018年 wdada0620@gmail.com. All rights reserved.
//

import Foundation
import ObjectMapper

//class Statuses: Mappable {
//    var created_at: String?
//    //字符串写成可选的
//    var id: Int = 0
//    //基本数据类型要赋个初值
//    var text: String?
//    var source: String?
//    required init?(map: Map) {
//
//    }
//    func mapping(map: Map) {
//        created_at    <- map["created_at"]
//        id         <- map["id"]
//        text      <- map["text"]
//        source       <- map["source"]
//    }
//
//}

class appIdModel: Mappable {
    var appId: String?
    var appSecret: String?
    required init?(map: Map) {
        
    }
    init(appId:String ,appSecret:String) {
        self.appId = appId
        self.appSecret = appSecret
    }
    func mapping(map: Map) {
        appId    <- map["appId"]
        appSecret         <- map["appSecret"] 
    }
}


class CheckAppModel: Mappable {
    var appName: String?
    var verCode: String?
    var verName: String?
    var packName: String?
    var downloadUrl: String?
    var updateInfoUrl: String?
    var updateType: String?
    required init?(map: Map) {
        
    }

    func mapping(map: Map) {
        appName    <- map["appName"]
        verCode         <- map["verCode"]
        verName    <- map["verName"]
        packName         <- map["packName"]
        downloadUrl    <- map["downloadUrl"]
        updateInfoUrl         <- map["updateInfoUrl"]
        updateType         <- map["updateType"]
    }
}

class appSecretModel: Mappable {
    var accessToken: String?
    var expireTime: TimeInterval?
    var sessionKey: String?
    var sessionSecret: String?
    required init?(map: Map) {
        
    }
    init(accessToken:String ,expireTime:TimeInterval,sessionKey:String ,sessionSecret:String) {
        self.accessToken = accessToken
        self.expireTime = expireTime
        self.sessionKey = sessionKey
        self.sessionSecret = sessionSecret
    }
    func mapping(map: Map) {
        accessToken    <- map["accessToken"]
        expireTime         <- map["expireTime"]
        sessionKey    <- map["sessionKey"]
        sessionSecret         <- map["sessionSecret"]
    }
}

class UserInfoModel: Mappable {
    var userId: String?
    var surname: String?
    var enName: String?
    var mobile: String?
    var certType: String?
    var certNo: String?
    var avatar: String?
    var authenTicket: String?
    var authenUserId: String?
    var zone: String?
    var sex: String?
    var birthday: String?
    var nationlityName: String?
    var nationality: String?
    required init?(map: Map) {
        
    }
 init(userId:String ,surname:String,enName:String ,mobile:String,certType:String,certNo:String ,avatar:String,authenTicket:String,authenUserId:String ,zone:String,sex:String,birthday:String ,nationality:String) {
        self.userId = userId
        self.surname = surname
        self.enName = enName
        self.mobile = mobile
        self.certType = certType
        self.certNo = certNo
        self.avatar = avatar
        self.authenTicket = authenTicket
        self.authenUserId = authenUserId
        self.zone = zone
        self.sex = sex
        self.birthday = birthday
        self.nationality = nationality
    }
    
    func mapping(map: Map) {
        userId    <- map["userId"]
        surname         <- map["surname"]
        enName    <- map["enName"]
        mobile         <- (map["mobile"],StrTransform())
        certType    <- (map["certType"],StrTransform())
        certNo         <- (map["certNo"],StrTransform())
        avatar    <- (map["avatar"],StrTransform())
        authenTicket         <- (map["authenTicket"],StrTransform())
        authenUserId    <- (map["authenUserId"],StrTransform())
        zone         <- (map["zone"],StrTransform())
        sex    <- (map["sex"],StrTransform())
        birthday         <- (map["birthday"],StrTransform())
        nationality         <- (map["nationality"],StrTransform())
        nationlityName         <- (map["nationlityName"],StrTransform())
    }
}

open class StrTransform: TransformType {
    
    public typealias Object = String
    public typealias JSON = String
    public func transformToJSON(_ value: String?) -> String? {
        if let date = value {
            return date
        }
        return nil
    }
    
    public func transformFromJSON(_ value: Any?) -> String? {
        if let timeInt = value as? String {
            return String(timeInt)
        }
        return ""
    }
    public init() {}
}

class countryAll: Mappable {
    var Hot = [countryItem]()
    
    var A = [countryItem]()
    var B = [countryItem]()
    var C = [countryItem]()
    var D = [countryItem]()
    var E = [countryItem]()
    var F = [countryItem]()
    var G = [countryItem]()
    var H = [countryItem]()
    var I = [countryItem]()
    var J = [countryItem]()
    var K = [countryItem]()
    var L = [countryItem]()
    var M = [countryItem]()
    var N = [countryItem]()
    var O = [countryItem]()
    var P = [countryItem]()
    var Q = [countryItem]()
    var R = [countryItem]()
    var S = [countryItem]()
    var T = [countryItem]()
    var U = [countryItem]()
    var V = [countryItem]()
    var W = [countryItem]()
    
    var Y = [countryItem]()
    var Z = [countryItem]()
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        Hot    <- map["Hot"]
        A         <- map["A"]
        B    <- map["B"]
        C    <- map["C"]
        D         <- map["D"]
        E    <- map["E"]
        F         <- map["F"]
        G    <- map["G"]
        H    <- map["H"]
        I         <- map["I"]
        J    <- map["J"]
        K    <- map["K"]
        L         <- map["L"]
        M    <- map["M"]
        N    <- map["N"]
        O         <- map["O"]
        P    <- map["P"]
        Q    <- map["Q"]
        R         <- map["R"]
        S    <- map["S"]
        T    <- map["T"]
        U         <- map["U"]
        V    <- map["V"]
        W    <- map["W"]
        Y    <- map["Y"]
        Z    <- map["Z"]
    }
}

class countryItem : Mappable {
    var countryCode :String?
    var countryName :String?
    var areaCode  :String?
    init(countryCode:String,countryName:String,areaCode:String){
        self.countryCode = countryCode
        self.countryName = countryName
        self.areaCode = areaCode
    }
    required init?(map: Map) {
        
    }

    func mapping(map: Map) {
        countryCode    <- map["countryCode"]
        countryName         <- map["countryName"]
        areaCode    <- map["areaCode"]
    }
}

class GlobalParameter: Mappable {
    var jcPassengerUrl: URL?
    var jcFilghtUrl: URL?
    var jcMyTripUrl: URL?
    var jcContactUrl: URL?
    var jcAboutUrl: URL?
    var jcGccUrl: URL?
    var jcPrivacyPolicyUrl: URL?
    required init?(map: Map) {
        
    }
 init(jcPassengerUrl:String ,jcFilghtUrl:String,jcMyTripUrl:String ,jcContactUrl:String,jcAboutUrl:String,jcGccUrl:String ,jcPrivacyPolicyUrl:String) {

        self.jcPassengerUrl = URL(string: jcPassengerUrl)
        self.jcFilghtUrl = URL(string:jcFilghtUrl)
        self.jcMyTripUrl = URL(string:jcMyTripUrl)
        self.jcContactUrl = URL(string:jcContactUrl)
        self.jcAboutUrl = URL(string:jcAboutUrl)
        self.jcGccUrl = URL(string:jcGccUrl)
        self.jcPrivacyPolicyUrl = URL(string:jcPrivacyPolicyUrl)
    }
    
    func mapping(map: Map) {
        jcPassengerUrl         <- (map["jcPassengerUrl"],urlTransform())
        jcFilghtUrl    <- (map["jcFilghtUrl"],urlTransform())
        jcMyTripUrl         <- (map["jcMyTripUrl"],urlTransform())
        jcContactUrl    <- (map["jcContactUrl"],urlTransform())
        jcAboutUrl         <- (map["jcAboutUrl"],urlTransform())
        jcGccUrl    <- (map["jcGccUrl"],urlTransform())
        jcPrivacyPolicyUrl         <- (map["jcPrivacyPolicyUrl"],urlTransform())
    }
}


open class urlTransform: TransformType {
    
    public typealias Object = URL
    public typealias JSON = String
    public func transformToJSON(_ value: URL?) -> String? {
        if let date = value {
            return date.absoluteString
        }
        return nil
    }
    
    public func transformFromJSON(_ value: Any?) -> URL? {
        if let url = value as? String {
            return URL(string:url)
        }
        return nil
    }
    public init() {}
}
