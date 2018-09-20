//
//  mycountHead.swift
//  JCSwift
//
//  Created by MiNi on 2018/5/21.
//  Copyright © 2018年 wdada0620@gmail.com. All rights reserved.
//

import UIKit
import Kingfisher
class mycountHead: UIView {
    var userInfo:UserInfoModel?{
        didSet
        {
            name.text = "嗨，" + String((userInfo?.surname)! + " " + (userInfo?.enName)!)
            if userInfo?.avatar != nil {
                let url = URL(string: (userInfo?.avatar)!)
                avtor.kf.setImage(with: url, placeholder: UIImage.init(named: "系统头像"))
            }else{
               avtor.image = UIImage.init(named: "系统头像")
            }
        }
    }
    lazy private var avtor = UIImageView()
    lazy private var name = UILabel()

    override init(frame:CGRect){
        super.init(frame: frame)
        self.addSubview(avtor)
        self.addSubview(name)

        avtor.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(20)
            make.bottom.equalToSuperview().offset(-35)
            make.height.equalTo(37)
            make.width.equalTo(37)
        }
        name.snp.makeConstraints { (make) in
            make.left.equalTo(avtor.snp.right).offset(20)
            make.right.equalToSuperview().offset(-20)
            make.centerY.equalTo(avtor)
        }
        name.textColor =  UIColor(hex: "#ED1C24")
        name.font = UIFont.init(name: "PingFangSC-Medium", size: 15)
        avtor.layer.cornerRadius = 37/2.0
        avtor.layer.masksToBounds = true
        avtor.contentMode = .scaleAspectFill
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
