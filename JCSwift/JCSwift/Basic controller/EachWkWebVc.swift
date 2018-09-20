//
//  EachWkWebVc.swift
//  JCSwift
//
//  Created by MiNi on 2018/5/22.
//  Copyright © 2018年 wdada0620@gmail.com. All rights reserved.
//

import UIKit
import WebKit
class EachWkWebVc: WkWebVc ,WKScriptMessageHandler {

    override func viewDidLoad() {
       
        
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current // 设置时区
        dateFormatter.dateFormat = "yyyyMMddHHmmss"
        let localDateTime = dateFormatter.string(from: currentDate)
        
        let appToken = DBappSecretModel.shareInstance.getdata()
        let userinfo = DBUserInfoModel.shareInstance.getdata()
        var sessionContext = [
            "channel":MyHttpurl.PORTALCHANNEL.rawValue,
            "accessSource" : MyHttpurl.PORTALACCESSSOURCE.rawValue,
            "version":MyHttpurl.PORTALVERSION.rawValue,
            "stepCode":MyHttpurl.stepCode.rawValue,
            "accessSourceType":UIDevice.current.systemVersion,
            "localDateTime" : localDateTime,
            "internation":"0",
            ] as [String : Any]
        
        if appToken?.accessToken != nil {
            sessionContext["accessToken"] = appToken?.accessToken
        }
        if userinfo?.authenUserId != nil {
            sessionContext["authenUserId"] = userinfo?.authenUserId
        }
        if userinfo?.userId != nil {
            sessionContext["userId"] = userinfo?.userId
        }
        let sessionContextStr = sessionContext.transformToJSONString()
        let cookieStr = String.init(format: "document.cookie = 'sessionContext=%@'", sessionContextStr)
        let cookieScript = WKUserScript.init(source: cookieStr, injectionTime: .atDocumentStart, forMainFrameOnly: true)

        let userContentController = WKUserContentController()
        userContentController.add(self as WKScriptMessageHandler, name: "paySuccess")
        userContentController.add(self as WKScriptMessageHandler, name: "JcSignIn")
        userContentController.add(self as WKScriptMessageHandler, name: "login")
        userContentController.add(self as WKScriptMessageHandler, name: "callPhone")
        userContentController.add(self as WKScriptMessageHandler, name: "weixinPay")
        
        userContentController.addUserScript(cookieScript)
        
        config = WKWebViewConfiguration()
        config?.userContentController = userContentController
        
        super.viewDidLoad()
    }

    public func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        switch message.name {
        case "paySuccess","weixinPay":
            weixinPayFunc(message.body)
            break
        case "JcSignIn","login":
            loginFunc(message.body)
            break
        case "callPhone":
            callPhoneFunc(message.body)
            break
        default :
            break
        }
    }
    
    func weixinPayFunc(_ dic:Any?) -> Void {
        guard !WXApi.isWXAppInstalled() else {
            view.showMessage(message: "您没有安装微信")
            return
        }
        var tmp:Dictionary<String, Any>?
        if dic is String  {
            let dictionary_temp = dic as! String
            tmp = dictionary_temp.getDictionaryFromJSONString() as? Dictionary<String, Any>
        }else  if dic is Dictionary<String, Any>  {
            tmp = (dic as! Dictionary<String, Any>)
        }
        if tmp != nil{
            var package,time_stamp,nonce_str:NSString
            var now:time_t = 0
            time(&now)
            time_stamp = NSString(format: "%ld", now)
            nonce_str = WXUtil.md5(time_stamp as String?)! as NSString
            package = "Sign=WXPay";
            let handler:payRequsestHandler = payRequsestHandler()
            let appid = tmp!["appId"];
            let MCH_IDStr = "1496863012";
            handler.init("wx213a2c40841f4cdd", mch_id:"1496863012" )
            handler.setKey("af106ctucq216Lfckg216ckg100xgxfx")
            
            let signParams = [
                "appid":appid,
                "noncestr":nonce_str,
                "package":package,
                "partnerid":MCH_IDStr,
                "timestamp":time_stamp,
                "prepayid":tmp!["prepayId"],
                ]
            let localSign = handler.createMd5Sign(signParams as Any as! [AnyHashable : Any] )
            
            let req = PayReq()
            req.openID =  appid as! String
            req.partnerId = "1496863012"
            req.prepayId = tmp!["prepayId"] as! String
            req.nonceStr = nonce_str as String?
            req.timeStamp = UInt32(time_stamp.intValue)
            req.package = package as String?
            req.sign = localSign
            let staue = WXApi.send(req)
            NSLog("\(staue)")
        }

    }
    func loginFunc(_ dic:Any?) -> Void {
        
    }
    func callPhoneFunc(_ dic:Any?) -> Void {
        if dic is String  {
            let phoneNumber:String = dic as! String
            let tel = String(format: "telprompt//%@", phoneNumber)
            if UIApplication.shared.canOpenURL(URL(string: tel)!) {
                UIApplication.shared.openURL(URL(string: tel)!)
            }
        }
    }
    

}


