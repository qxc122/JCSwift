//
//  UIAlertDateController.swift
//  JCSwift
//
//  Created by MiNi on 2018/5/4.
//  Copyright © 2018年 wdada0620@gmail.com. All rights reserved.
//

import UIKit
import SnapKit
class UIAlertDateController: UIAlertController {
    //定义block
    typealias doneBlock = (_ backMsg :String?) ->()
    //创建block变量
    var doneblock:doneBlock!
    lazy private var datapicker = DatePicker()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(datapicker)
        
        datapicker.snp.makeConstraints { (make) in
            make.right.equalToSuperview()
            make.left.equalToSuperview()
            make.top.equalToSuperview()
            make.height.equalTo(158)
//            make.bottom.equalToSuperview()
        }
        datapicker.doneblock =  { (date) in
            if let _ = date {
                if let _ = self.doneblock{
                    self.doneblock(date!)
                }
            }
            self.dismiss(animated: true, completion: nil)
        }
//        self.view.backgroundColor = UIColor.red
        self.view.frame = CGRect.init(x: 0, y: 300, width: 300, height: 300)
        
        self.addAction(UIAlertAction.init(title: "确定", style: .destructive, handler: { (res) in
            let chooseDate = self.datapicker.datapicker.date
            let dateFormater = DateFormatter.init()
            dateFormater.dateFormat = "YYYY-MM-dd"
            if let _ = self.doneblock{
                self.doneblock(dateFormater.string(from: chooseDate))
            }
        }))
        
        self.addAction(UIAlertAction.init(title: "取消", style: .cancel, handler: { (res) in
            self.doneblock(nil)
        }))
    }
}
