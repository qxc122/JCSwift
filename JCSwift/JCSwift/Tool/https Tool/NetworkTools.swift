//
//  NetworkTools.swift
//  JCSwift
//
//  Created by MiNi on 2018/4/25.
//  Copyright © 2018年 wdada0620@gmail.com. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import ObjectMapper
import CryptoSwift

enum MyHttpErrorCode : Int {
    case invalid = 12301
    case resultempty = 12302
    case parametersempty = 12303
    case encryptionfailure = 12304
}
enum MethodType {
    case get
    case post
}
class NetworkTools {
    
    let method = HTTPMethod.post
    
    /// 使用全局变量创建单例
    static let shareInstance = NetworkTools()
    
    private  init(){
        
    }
    
    func requestData(_ URLString : String, parameters : [String : Any]?, successCallback : @escaping (_ result : String) -> (),failCallback : @escaping (_ result : Error) -> ()) {
        
        let appToken = DBappSecretModel.shareInstance.getdata()
        if (appToken != nil || URLString == MyHttpurl.URLBASIC_tpurseappappIdApply.rawValue || URLString == MyHttpurl.URLBASIC_apptokenApply.rawValue) {
            if (URLString == MyHttpurl.URLBASIC_tpurseappappIdApply.rawValue || URLString == MyHttpurl.URLBASIC_apptokenApply.rawValue || Date.init(timeIntervalSinceNow: (appToken?.expireTime!)!).timeIntervalSinceNow > 0.0) {
                let currentDate = Date()
                let dateFormatter = DateFormatter()
                dateFormatter.locale = Locale.current // 设置时区
                dateFormatter.dateFormat = "yyyyMMddHHmmss"
                let localDateTime = dateFormatter.string(from: currentDate)
                
                let globalparameters = [
                    "channel":MyHttpurl.PORTALCHANNEL.rawValue,
                    "accessSource" : MyHttpurl.PORTALACCESSSOURCE.rawValue,
                    "version":MyHttpurl.PORTALVERSION.rawValue,
                    "stepCode":MyHttpurl.stepCode.rawValue,
                    "accessSourceType":UIDevice.current.systemVersion,
                    "localDateTime" : localDateTime,
                    "internation":"0",
                    "accessToken":appToken?.accessToken as Any,
                    ]as [String : Any]
                
                var allparameters:Dictionary = parameters!
                allparameters["sessionContext"] = globalparameters
                
                let headers: HTTPHeaders = [ "Content-Type":"application/json;charset=UTF-8"]
                Alamofire.request(MyHttpurl.basicUrl.rawValue+URLString, method: method, parameters: allparameters,encoding:JSONEncoding.default, headers:headers).responseString { (response) in
                    switch response.result{
                    case .success:
                        if (response.error != nil){
                            failCallback(response.error!)
                        }else{
                            if let value = response.result.value{
                                let json = JSON(parseJSON: value)
                                let host:String? = json["transactionStatus"]["errorCode"].string
                                if host == "0" {
                                    successCallback(value)
                                } else {
                                    if host == "1" {
                                        let error = NSError.init(domain: URLString, code:Int(json["transactionStatus"]["replyCode"].string!)!, userInfo: [NSLocalizedDescriptionKey : json["transactionStatus"]["replyText"].string!])
                                        failCallback(error)
                                    } else {
                                        let error = NSError.init(domain: URLString, code: MyHttpErrorCode.invalid.rawValue, userInfo: [NSLocalizedDescriptionKey : "返回码code无效"])
                                        failCallback(error)
                                    }
                                }
                            }else{
                                let error = NSError.init(domain: URLString, code: MyHttpErrorCode.resultempty.rawValue, userInfo: [NSLocalizedDescriptionKey : "服务器返回数据为空"])
                                failCallback(error)
                            }
                        }
                    case .failure(let error):
                        failCallback(error)
                    }
                }
            }else{
                getToken({ (data) in
                    let data = Mapper<appSecretModel>().map(JSONString: data)
                    DBappSecretModel.shareInstance.setdata(data: data!)
                    if DBUserInfoModel.shareInstance.getdata() != nil{
                        self.URLBASIC_userrefreshLogin({ (data) in
                            let data = Mapper<appSecretModel>().map(JSONString: data)
                            DBappSecretModel.shareInstance.setdata(data: data!)
                            self.requestData(URLString, parameters: parameters, successCallback: successCallback, failCallback: failCallback)
                        }, failCallback: failCallback)
                    }else{
                        self.requestData(URLString, parameters: parameters, successCallback: successCallback, failCallback: failCallback)
                    }
                }) { (error) in
                    failCallback(error)
                }
            }
        }else{
            getToken({ (data) in
                let data = Mapper<appSecretModel>().map(JSONString: data)
                DBappSecretModel.shareInstance.setdata(data: data!)
                self.requestData(URLString, parameters: parameters, successCallback: successCallback, failCallback: failCallback)
            }) { (error) in
                failCallback(error)
            }
        }
    }
}

extension NetworkTools{
    private func encryptUseDES(_ plainText:String) -> String? {
        let sessionKey = DBappSecretModel.shareInstance.getdata()?.sessionKey
        let sessionSecret = DBappSecretModel.shareInstance.getdata()?.sessionSecret
        guard (sessionKey?.count)! >= 16 && (sessionSecret?.count)! >= 24 else {
            return nil
        }
        let keystart = sessionKey!.index((sessionKey?.startIndex)!, offsetBy: 8)
        let keyend = sessionKey!.index((sessionKey?.startIndex)!, offsetBy: 16)
        let key = String(sessionKey![keystart..<keyend])

        let ivstart = sessionSecret!.index((sessionSecret?.startIndex)!, offsetBy: 16)
        let ivend = sessionSecret!.index((sessionSecret?.startIndex)!, offsetBy: 24)
        let iv = String(sessionSecret![ivstart..<ivend])
        
        return Cryptor.encryptUseDES(plainText, key: key, iv: iv)
    }
    public func URLBASIC_appappUpdate(_ successCallback : @escaping (_ result :String) -> (),failCallback : @escaping (_ result : Error) -> ()) {
        //应用程序信息
        let infoDictionary = Bundle.main.infoDictionary!
        let minorVersion = infoDictionary["CFBundleVersion"]//版本号（内部标示）
        let parameters = [
            "verCode":minorVersion as Any,
            ]as [String : Any]
        requestData(MyHttpurl.URLBASIC_appappUpdate.rawValue, parameters:parameters, successCallback: successCallback, failCallback: failCallback)
    }
    
    public func URLBASIC_appjcEmailValid(_ email:String, successCallback : @escaping (_ result :String) -> (),failCallback : @escaping (_ result : Error) -> ()) {
        let parameters = [
            "email":email,
            ]as [String : Any]
        requestData(MyHttpurl.URLBASIC_appjcEmailValid.rawValue, parameters:parameters, successCallback: successCallback, failCallback: failCallback)
    }
    
    public func URLBASIC_jcRegistered(_ email:String,password:String,sex:String,surname:String,enName:String,birthday:String,nationality:String,zone:String,mobile:String, successCallback : @escaping (_ result :String) -> (),failCallback : @escaping (_ result : Error) -> ()) {
        let enpassword = self.encryptUseDES(password)
        if (enpassword?.isEmpty)! {
            let error = NSError.init(domain: MyHttpurl.URLBASIC_jcRegistered.rawValue, code: MyHttpErrorCode.encryptionfailure.rawValue, userInfo: [NSLocalizedDescriptionKey : "密码加密失败"])
            failCallback(error)
        } else {
            let parameters = [
                "email":email,
                "password":enpassword as Any,
                
                "sex":sex,
                "surname":surname,
                "enName":enName,
                "birthday":birthday,
                "nationality":nationality,
                
                "zone":zone,
                "mobile":mobile,
                
                ]as [String : Any]
            requestData(MyHttpurl.URLBASIC_jcRegistered.rawValue, parameters:parameters, successCallback: successCallback, failCallback: failCallback)
        }
    }
    
    public func URLBASIC_jcLogin(_ email:String,password:String, successCallback : @escaping (_ result :String) -> (),failCallback : @escaping (_ result : Error) -> ()) {
        let parameters = [
            "email":email,
            "password": self.encryptUseDES(password) as Any,
            ]as [String : Any]
        requestData(MyHttpurl.URLBASIC_jcLogin.rawValue, parameters:parameters, successCallback: successCallback, failCallback: failCallback)
    }
    
    
    public func URLBASIC_jcMyInfo(_ successCallback : @escaping (_ result :String) -> (),failCallback : @escaping (_ result : Error) -> ()) {
        let parameters = [:]as [String : Any]
        requestData(MyHttpurl.URLBASIC_jcMyInfo.rawValue, parameters:parameters, successCallback: successCallback, failCallback: failCallback)
    }
    
    public func URLBASIC_tpurseuserlogout(_ successCallback : @escaping (_ result :String) -> (),failCallback : @escaping (_ result : Error) -> ()) {
        let parameters = [:]as [String : Any]
        requestData(MyHttpurl.URLBASIC_tpurseuserlogout.rawValue, parameters:parameters, successCallback: successCallback, failCallback: failCallback)
    }
    
    public func URLBASIC_appgetGlobalParams(_ successCallback : @escaping (_ result :String) -> (),failCallback : @escaping (_ result : Error) -> ()) {
        let parameters = [:]as [String : Any]
        requestData(MyHttpurl.URLBASIC_appgetGlobalParams.rawValue, parameters:parameters, successCallback: successCallback, failCallback: failCallback)
    }
    
    public func URLBASIC_jcModifyMyInfo(_ mobile:String,zone:String,surname:String,enName:String,sex:String,birthday:String,nationality:String, successCallback : @escaping (_ result :String) -> (),failCallback : @escaping (_ result : Error) -> ()) {
        let parameters = [
            "mobile":mobile,
            "zone": zone,
            "surname":surname,
            "enName": enName,
            "sex":sex,
            "birthday": birthday,
            "nationality":nationality,
            ]as [String : Any]
        requestData(MyHttpurl.URLBASIC_jcModifyMyInfo.rawValue, parameters:parameters, successCallback: successCallback, failCallback: failCallback)
    }
}

extension NetworkTools{
    private func getToken(_ successCallback : @escaping (_ result :String) -> (),failCallback : @escaping (_ result : Error) -> ()) {
        if DBappIdModel.shareInstance.getdata() != nil {
            self.URLBASIC_apptokenApply(successCallback, failCallback: failCallback)
        }else{
            URLBASIC_tpurseappappIdApply({ (data) in
                let user = Mapper<appIdModel>().map(JSONString: data)
                DBappIdModel.shareInstance.setdata(data: user!)
                self.URLBASIC_apptokenApply(successCallback, failCallback: failCallback)
            }, failCallback: failCallback)
        }
    }
    
    
    private func URLBASIC_tpurseappappIdApply(_ successCallback : @escaping (_ result :String) -> (),failCallback : @escaping (_ result : Error) -> ()) {
        let parameters = [
            "deviceId":RandomString.sharedInstance.uuid,
            ]as [String : Any]
        requestData(MyHttpurl.URLBASIC_tpurseappappIdApply.rawValue, parameters:parameters, successCallback: successCallback, failCallback: failCallback)
    }
    
    private func URLBASIC_apptokenApply(_ successCallback : @escaping (_ result :String) -> (),failCallback : @escaping (_ result : Error) -> ()) {
        let parameters = [
            "appId":DBappIdModel.shareInstance.getdata()?.appId! as Any,
            "deviceId":RandomString.sharedInstance.uuid,
            "timestamp":String(Date().timeIntervalSince1970),
            "sign":"000",
            ]as [String : Any]
        requestData(MyHttpurl.URLBASIC_apptokenApply.rawValue, parameters:parameters, successCallback: successCallback, failCallback: failCallback)
    }
    
    private func URLBASIC_userrefreshLogin(_ successCallback : @escaping (_ result :String) -> (),failCallback : @escaping (_ result : Error) -> ()) {
        let parameters = [
            "ticket":DBUserInfoModel.shareInstance.getdata()?.authenTicket as Any,
            "timestamp":String(Date().timeIntervalSince1970),
            ]as [String : Any]
        requestData(MyHttpurl.URLBASIC_userrefreshLogin.rawValue, parameters:parameters, successCallback: successCallback, failCallback: failCallback)
    }
}
