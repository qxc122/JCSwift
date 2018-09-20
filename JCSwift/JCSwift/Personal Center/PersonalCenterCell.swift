//
//  PersonalCenterCell.swift
//  JCSwift
//
//  Created by MiNi on 2018/4/24.
//  Copyright © 2018年 wdada0620@gmail.com. All rights reserved.
//

import UIKit



class pcitem {
    var name :String?
    var icon :String?
    var idd  :String?
    init(name:String,icon:String,idd:String){
        self.name = name
        self.icon = icon
        self.idd = idd
    }
}

class PersonalCenterCell: UITableViewCell {

    lazy var icon:UIImageView = UIImageView()
    lazy var name:UILabel = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(icon)
        self.contentView.addSubview(name)
        icon.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-38)
            make.centerY.equalToSuperview()
            make.height.width.equalTo(18)
        }
        icon.contentMode = .center
        name.snp.makeConstraints { (make) in
            make.right.equalTo(icon.snp.left).offset(-34)
            make.centerY.equalToSuperview()
        }
        name.textColor = UIColor.init(white: 255.0, alpha: 1.0)
        name.font = UIFont.init(name: "PingFangSC-Regular", size: 15)
        self.backgroundColor = UIColor.clear
        self.selectionStyle = .none
    }
    //重写init方法，必须调用下面这个方法？
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setdata(item data : pcitem) {
        icon.image = UIImage.init(named: data.icon!)
        name.text = data.name
    }
    
}
