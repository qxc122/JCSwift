//
//  Global.swift
//  JCSwift
//
//  Created by MiNi on 2018/4/26.
//  Copyright © 2018年 wdada0620gmail.com. All rights reserved.
//

import Foundation

enum viewtag : Int {
    case email = 0
    case password
    case passwordTwo
    
    case sex
    case firstName
    case lastName
    case birstday
    case nationality
    
    case phone
    case zone
}

enum sex : String {
    case man = "M"
    case women = "F"
}

enum MyHttpurl : String {
    
    case    PORTALCHANNEL    =   "7"
    case    PORTALACCESSSOURCE    =   "2"
    case    PORTALVERSION    =   "1.0"
    case    stepCode    =   "1"
    
#if DEBUG
    case basicUrl = "https://zeji.tempus.cn/zeji-front"
//    case basicUrl = "https://zeji.tempus.cn/zeji-front/test"
#else
    case basicUrl = "https://zeji.tempus.cn/zeji-front"
#endif
    
    case     URLBASIC_tpurseappappIdApply        =   "/app/appIdApply"
    case     URLBASIC_apptokenApply        =   "/app/tokenApply"
    case     URLBASIC_userrefreshLogin       =   "/user/refreshLogin"
    case     URLBASIC_appgetGlobalParams       =   "/app/getGlobalParams"
    case     URLBASIC_jcRegistered       =   "/app/jcRegistered"
    case     URLBASIC_jcLogin       =   "/app/jcLogin"
    case     URLBASIC_jcMyInfo       =   "/user/jcMyInfo"
    case     URLBASIC_tpurseuserlogout       =   "/user/logout"
    case     URLBASIC_jcModifyMyInfo         =   "/app/jcModifyMyInfo"
    case     URLBASIC_appjcEmailValid         =   "/app/jcEmailValid"
    
    case     URLBASIC_appappUpdate         =  "/app/appUpdate"
    case     URLBASIC_userlogin       =   "/tpurse/user/login"
    case     URLBASIC_useraddPayPassword       =   "/user/addPayPassword"
    case     URLBASIC_tpursesystemgetGraphicVerifyCode       =   "/tpurse/system/getGraphicVerifyCode"
    
    case     URLBASIC_tpurseusermyCardInfo       =   "/tpurse/user/myCardInfo"
    case     URLBASIC_tpurseusermodifyNickname       =   "/tpurse/user/modifyNickname"
    
    case     URLBASIC_userheadUpload       =   "/tpurse/user/headUpload"
    
    case     URLBASIC_userqueryBank       =   "/user/queryBank"
    case     URLBASIC_userbindBankCard       =   "/user/bindBankCard"
    
    
    case     URLBASIC_tpursesystemcheckVerifyCode      =   "/tpurse/system/checkVerifyCode"
    
    /////
    case     URLBASIC_tpurseusersubmitFeedback       =   "/tpurse/user/submitFeedback"
    case     URLBASIC_flightqueryGssFlightDynamic       =   "/flight/queryGssFlightDynamic"
    case     URLBASIC_userwithdraw       =   "/user/withdraw"
    case     URLBASIC_userrecharge       =   "/user/recharge"
    case     URLBASIC_qrCodegenerateQRCode      =   "/qrCode/generateQRCode"
    case     URLBASIC_qrCodescanQRCode      =   "/qrCode/scanQRCode"
    case     URLBASIC_qrCodeunifiedPay      =   "/qrCode/unifiedPay"
    case     URLBASIC_tpurseuserqueryPayMethod       =   "/tpurse/user/queryPayMethod"
    case     URLBASIC_orderpayThirdOrder       =   "/order/payThirdOrder"
    case     URLBASIC_systemsendVerifyCode       =   "/system/sendVerifyCode"
    
    case     URLBASIC_usercheckVerifyCode       =   "/user/checkVerifyCode"
    case     URLBASIC_usercheckPayPassword       =   "/tpurse/user/checkPayPassword"
    case     URLBASIC_qrCodecancelUnifiedPay       =   "/qrCode/cancelUnifiedPay"
    case     URLBASIC_regularFinmyRegularFin       =   "/regularFin/myRegularFin"
    case     URLBASIC_regularFintpurseRecharge       =   "/regularFin/tpurseRecharge"
    
    case     URLBASIC_regularFinrecharge       =   "/regularFin/recharge"
    case     URLBASIC_regularFinwithdraw       =   "/regularFin/withdraw"
    
    case     URLBASIC_userthirdUserLogin       =   "/tpurse/user/thirdUserLogin"
    
    case     URLBASIC_usermyInfo       =   "/user/myInfo"
    case     URLBASIC_portalusermyNews       =   "/portal/user/myNews"
    
    
    
    case     URLBASIC_portalcommonInfoaddContactInfo       =   "/portal/commonInfo/addContactInfo"
    case     URLBASIC_portalcommonInfodeleteContactInfo       =   "/portal/commonInfo/deleteContactInfo"
    case     URLBASIC_portalcommonInfoeditContactInfo       =   "/portal/commonInfo/editContactInfo"
    case     URLBASIC_portalcommonInfoqueryContactInfos       =   "/portal/commonInfo/queryContactInfos"
    
    case     URLBASIC_portalcommonInfoaddAddressInfo       =   "/portal/commonInfo/addAddressInfo"
    case     URLBASIC_portalcommonInfodeleteAddressInfo       =   "/portal/commonInfo/deleteAddressInfo"
    case     URLBASIC_portalcommonInfoeditAddressInfo       =   "/portal/commonInfo/editAddressInfo"
    case     URLBASIC_portalcommonInfoqueryAddressInfos       =   "/portal/commonInfo/queryAddressInfos"
    
    case     URLBASIC_commonInfoaddPassengerInfo       =   "/portal/commonInfo/addPassengerInfo"
    case     URLBASIC_commonInfodeletePassengerInfo       =   "/portal/commonInfo/deletePassengerInfo"
    case     URLBASIC_commonInfoeditPassengerInfo       =   "/portal/commonInfo/editPassengerInfo"
    case     URLBASIC_portalcommonInfoqueryPassengerInfos       =   "/portal/commonInfo/queryPassengerInfos"
    
    
    case     URLBASIC_portalqueryOrderInfo       =   "/portal/order/queryOrderInfo"
    
    
    
    case     URLBASIC_userthirdUserBind       =   "/user/thirdUserBind"
    case     URLBASIC_appsubmitFeedback       =   "/portal/app/submitFeedback"
    
    case     URLBASIC_portalqueryFinaProducts       =   "/portal/queryFinaProducts"
    case     URLBASIC_usermodifyNickname       =   "/user/modifyNickname"
    
    
    case     URLBASIC_portaladdFavorite       =   "/portal/addFavorite"
    case     URLBASIC_portalqueryFavorites       =   "/portal/queryFavorites"
    case     URLBASIC_portalcancelFavorite       =   "/portal/cancelFavorite"

}

