//
//  MBProgressHUD.swift
//  JCSwift
//
//  Created by MiNi on 2018/5/7.
//  Copyright © 2018年 wdada0620@gmail.com. All rights reserved.
//

import Foundation
import NVActivityIndicatorView

class MBProgressHUD{
    /// 使用全局变量创建单例
    static let shareInstance = MBProgressHUD()
    private  init(){

    }
    func startAnimating(message: String? = nil,displayTimeThreshold: Int? = nil) {
        let  activityData = ActivityData.init(size: nil, message: message, messageFont: nil, messageSpacing: nil, type: NVActivityIndicatorType.blank, color: nil, padding: nil, displayTimeThreshold: nil, minimumDisplayTime: nil, backgroundColor: UIColor.clear, textColor: nil)
        DispatchQueue.main.async {
//            NVActivityIndicatorPresenter.sharedInstance
            NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
        }
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.0) {
            NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
        }
    }
}


