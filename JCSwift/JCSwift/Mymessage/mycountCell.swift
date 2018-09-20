//
//  mycountCell.swift
//  JCSwift
//
//  Created by MiNi on 2018/5/21.
//  Copyright © 2018年 wdada0620@gmail.com. All rights reserved.
//

import UIKit

class mycountCell: UITableViewCell {

    lazy var icon:UIImageView = UIImageView()
    lazy var more:UIImageView = UIImageView()
    lazy var name:UILabel = UILabel()
    lazy var line:UIView = UIView()
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(icon)
        self.contentView.addSubview(name)
        self.contentView.addSubview(line)
        self.contentView.addSubview(more)

        icon.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(20)
            make.centerY.equalToSuperview()
            make.height.equalTo(17)
            make.width.equalTo(20)
        }

        name.snp.makeConstraints { (make) in
            make.left.equalTo(icon.snp.right).offset(16)
            make.right.equalToSuperview().offset(-20)
            make.centerY.equalToSuperview()
        }
        line.snp.makeConstraints { (make) in
            make.left.equalTo(icon.snp.left)
            make.right.equalTo(name.snp.right)
            make.bottom.equalToSuperview()
            make.height.equalTo(0.5)
        }
        more.snp.makeConstraints { (make) in
            make.right.equalTo(name.snp.right)
            make.centerY.equalToSuperview()
            make.height.equalTo(11)
            make.width.equalTo(6)
        }
        more.image = UIImage.init(named: "更多")
        line.backgroundColor = UIColor(hex: "#DFDFDF")
        name.textColor =  UIColor(hex: "#6D6868")
        name.font = UIFont.init(name: "PingFangSC-Regular", size: 15)
        self.backgroundColor = UIColor.white
        self.selectionStyle = .none
    }

    //重写init方法，必须调用下面这个方法？
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
