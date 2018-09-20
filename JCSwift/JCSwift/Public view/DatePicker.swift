//
//  DatePicker.swift
//  JCSwift
//
//  Created by MiNi on 2018/5/4.
//  Copyright © 2018年 wdada0620@gmail.com. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
class DatePicker: UIView {
    //定义block
    typealias doneBlock = (_ backMsg :String?) ->()
    //创建block变量
    var doneblock:doneBlock!
    
    lazy var datapicker = UIDatePicker.init()
    lazy private var btnCancel = UIButton()
    lazy private var btnOk = UIButton()
    override init(frame:CGRect){
        super.init(frame: frame)
        setupSubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupSubViews() {
//        datapicker.layer.borderWidth = 1
//        datapicker.layer.borderColor = UIColor.gray.cgColor
        datapicker.datePickerMode = .date
        datapicker.locale = Locale.init(identifier: "zh_CN")
        datapicker.calendar = Calendar.current
        datapicker.timeZone = TimeZone.current
        datapicker.minimumDate = NSDate.init(timeIntervalSince1970: -100000) as Date
        datapicker.maximumDate = NSDate.init(timeIntervalSinceNow: 0) as Date
//        datapicker.addTarget(self, action: #selector(chooseDate( _:)), for:UIControlEvents.valueChanged)
        self.addSubview(datapicker)
        btnCancel.setTitle("取消", for: .normal)
        btnOk.setTitle("确定", for: .normal)
        btnCancel.setTitleColor(UIColor.gray, for: .normal)
        btnOk.setTitleColor(UIColor.gray, for: .normal)
        btnCancel.titleLabel?.font = UIFont.init(name: "SFUIText-Regular", size: 14)
        btnOk.titleLabel?.font = UIFont.init(name: "SFUIText-Regular", size: 14)
        btnCancel.addTarget(self, action: #selector(btnclick( _:)), for:.touchUpInside)
        btnOk.addTarget(self, action: #selector(btnclick( _:)), for:.touchUpInside)
        self.addSubview(btnCancel)
        self.addSubview(btnOk)
        btnOk.isHidden = true
        btnCancel.isHidden = true
    }
    
    @objc func btnclick(_ btn:UIButton) {
        if btn.isEqual(btnOk) {
            getTimeString(datapicker)
        } else {
            if let _ = doneblock{
                doneblock(nil)
            }
        }
    }
    
//    @objc func chooseDate(_ datePicker:UIDatePicker) {
//        getTimeString(datePicker)
//    }

    private func getTimeString(_ datePicker:UIDatePicker){
        let chooseDate = datePicker.date
        let dateFormater = DateFormatter.init()
        dateFormater.dateFormat = "YYYY-MM-dd"
        if let _ = doneblock{
            doneblock(dateFormater.string(from: chooseDate))
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        datapicker.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        btnCancel.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.top.equalToSuperview()
            make.width.height.equalTo(44)
        }
        btnOk.snp.makeConstraints { (make) in
            make.right.equalToSuperview()
            make.top.equalToSuperview()
            make.width.height.equalTo(44)
        }
    }
}
