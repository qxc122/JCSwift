//
//  RegisterTwoCell.swift
//  JCSwift
//
//  Created by MiNi on 2018/4/25.
//  Copyright © 2018年 wdada0620@gmail.com. All rights reserved.
//

import UIKit

class RegisterTwoCell: UICollectionViewCell ,UITextFieldDelegate {
    var mydelegate: celldelegate?
    lazy var backview: UIView = UIView()
    lazy var sexMan: UIButton = UIButton()
    lazy var sexWoman: UIButton = UIButton()
    lazy var lineOne: UIView = UIView()
    
    lazy var firstName: UITextField = UITextField()
    lazy var lineTwo: UIView = UIView()
    
    lazy var lastName: UITextField = UITextField()
    lazy var lineThree: UIView = UIView()
    
    lazy var birstday: UITextField = UITextField()
    lazy var lineFour: UIView = UIView()
    
    lazy var nationality: UITextField = UITextField()
    lazy var btnbirstday: UIButton = UIButton()
    lazy var btnnationality: UIButton = UIButton()
    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    func initView(){
        firstName.returnKeyType = .next
        lastName.returnKeyType = .next

        self.contentView.addSubview(backview)
        self.contentView.addSubview(sexMan)
        self.contentView.addSubview(sexWoman)
        self.contentView.addSubview(lineOne)
        self.contentView.addSubview(firstName)
        self.contentView.addSubview(lineTwo)
        self.contentView.addSubview(lastName)
        self.contentView.addSubview(lineThree)
        self.contentView.addSubview(birstday)
        self.contentView.addSubview(lineFour)
        self.contentView.addSubview(nationality)
        self.contentView.addSubview(btnbirstday)
        self.contentView.addSubview(btnnationality)
        
        firstName.delegate = self
        lastName.delegate = self
        birstday.delegate = self
        nationality.delegate = self
        
        firstName.keyboardType = .asciiCapable
        lastName.keyboardType = .asciiCapable
        
        sexMan.tag = viewtag.sex.rawValue
        sexWoman.tag = viewtag.sex.rawValue
        firstName.tag = viewtag.firstName.rawValue
        lastName.tag = viewtag.lastName.rawValue
        btnbirstday.tag = viewtag.birstday.rawValue
        btnnationality.tag = viewtag.nationality.rawValue
        
        lineOne.backgroundColor = UIColor(hex: "#F3F3F3")
        lineTwo.backgroundColor = UIColor(hex: "#F3F3F3")
        lineThree.backgroundColor = UIColor(hex: "#F3F3F3")
        lineFour.backgroundColor = UIColor(hex: "#F3F3F3")
        birstday.isUserInteractionEnabled = false
        nationality.isUserInteractionEnabled = false
        firstName.clearButtonMode = .whileEditing
        lastName.clearButtonMode = .whileEditing

        firstName.font = UIFont(name: "PingFangSC-Regular", size: 15)
        firstName.placeholder = "请输入证件上的英文名"
        
        lastName.font = UIFont(name: "PingFangSC-Regular", size: 15)
        lastName.placeholder = "请输入证件上的英文姓"
        
        birstday.font = UIFont(name: "PingFangSC-Regular", size: 15)
        birstday.placeholder = "出生日期"
        nationality.font = UIFont(name: "PingFangSC-Regular", size: 15)
        nationality.placeholder = "国籍"
        
        backview.backgroundColor = UIColor.white
        backview.layer.cornerRadius = 4.0
        btnbirstday.setImage(UIImage(named: "更多"), for: .normal)
        btnnationality.setImage(UIImage(named: "更多"), for: .normal)
        
        sexMan.setImage(UIImage(named: "男未选"), for: .normal)
        sexMan.setImage(UIImage(named: "男选中"), for: .selected)
        sexMan.setImage(UIImage(named: "男选中"), for: .highlighted)
        sexMan.setTitle("  男", for: .normal)
        sexMan.setTitleColor(UIColor(hex: "#ED1C24"), for: .selected)
        sexMan.setTitleColor(UIColor(hex: "#ED1C24"), for: .highlighted)
        sexMan.setTitleColor(UIColor(hex: "#ACABAB"), for: .normal)
        sexMan.titleLabel?.font = UIFont(name: "PingFangSC-Regular", size: 15)
        
        sexWoman.setImage(UIImage(named: "女未选"), for: .normal)
        sexWoman.setImage(UIImage(named: "女选中"), for: .selected)
        sexWoman.setImage(UIImage(named: "女选中"), for: .highlighted)
        sexWoman.setTitle("  女", for: .normal)
        sexWoman.setTitleColor(UIColor(hex: "#ED1C24"), for: .selected)
        sexWoman.setTitleColor(UIColor(hex: "#ED1C24"), for: .highlighted)
        sexWoman.setTitleColor(UIColor(hex: "#ACABAB"), for: .normal)
        sexWoman.titleLabel?.font = UIFont(name: "PingFangSC-Regular", size: 15)
        
        backview.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.top.equalToSuperview()
        }
        lineOne.snp.makeConstraints { (make) in
            make.left.equalTo(backview)
            make.right.equalTo(backview)
            make.top.equalTo(backview).offset(63)
            make.height.equalTo(0.5)
        }
        lineTwo.snp.makeConstraints { (make) in
            make.left.equalTo(backview)
            make.right.equalTo(backview)
            make.top.equalTo(lineOne.snp.bottom).offset(63)
            make.height.equalTo(0.5)
        }
        lineThree.snp.makeConstraints { (make) in
            make.left.equalTo(backview)
            make.right.equalTo(backview)
            make.top.equalTo(lineTwo.snp.bottom).offset(63)
            make.height.equalTo(0.5)
        }
        lineFour.snp.makeConstraints { (make) in
            make.left.equalTo(backview)
            make.right.equalTo(backview)
            make.top.equalTo(lineThree.snp.bottom).offset(63)
            make.height.equalTo(0.5)
            make.bottom.equalTo(backview.snp.bottom).offset(-63)
        }
        sexMan.snp.makeConstraints { (make) in
            make.left.equalTo(backview).offset(20)
            make.top.equalTo(backview)
            make.bottom.equalTo(lineOne.snp.top)
        }
        sexWoman.snp.makeConstraints { (make) in
            make.left.equalTo(sexMan.snp.right).offset(30)
            make.top.equalTo(backview)
            make.bottom.equalTo(lineOne.snp.top)
        }
        firstName.snp.makeConstraints { (make) in
            make.left.equalTo(backview).offset(20)
            make.right.equalTo(backview).offset(-20)
            make.top.equalTo(lineOne.snp.bottom)
            make.bottom.equalTo(lineTwo.snp.top)
        }
        lastName.snp.makeConstraints { (make) in
            make.left.equalTo(firstName)
            make.right.equalTo(firstName)
            make.top.equalTo(lineTwo.snp.bottom)
            make.bottom.equalTo(lineThree.snp.top)
        }
        birstday.snp.makeConstraints { (make) in
            make.left.equalTo(firstName)
            make.right.equalTo(firstName)
            make.top.equalTo(lineThree.snp.bottom)
            make.bottom.equalTo(lineFour.snp.top)
        }
        nationality.snp.makeConstraints { (make) in
            make.left.equalTo(firstName)
            make.right.equalTo(firstName)
            make.top.equalTo(lineFour.snp.bottom)
            make.bottom.equalTo(backview)
        }
        btnbirstday.snp.makeConstraints { (make) in
            make.centerY.equalTo(birstday)
            make.right.equalTo(backview).offset(-3.5)
            make.width.height.equalTo(44)
        }
        btnnationality.snp.makeConstraints { (make) in
            make.centerY.equalTo(nationality)
            make.right.equalTo(backview).offset(-3.5)
            make.width.height.equalTo(44)
        }
        
        sexMan.set(image: UIImage(named: "男未选"), title: "男  ", titlePosition: .left,
                           additionalSpacing: 10.0, state: .normal)
        sexMan.set(image: UIImage(named: "男选中"), title: "男  ", titlePosition: .left,
                   additionalSpacing: 10.0, state: .selected)
        sexMan.set(image: UIImage(named: "男选中"), title: "男  ", titlePosition: .left,
                   additionalSpacing: 10.0, state: .highlighted)
        
        sexWoman.set(image: UIImage(named: "女未选"), title: "女  ", titlePosition: .left,
                   additionalSpacing: 10.0, state: .normal)
        sexWoman.set(image: UIImage(named: "女选中"), title: "女  ", titlePosition: .left,
                   additionalSpacing: 10.0, state: .selected)
        sexWoman.set(image: UIImage(named: "女选中"), title: "女  ", titlePosition: .left,
                   additionalSpacing: 10.0, state: .highlighted)
        
        sexMan.addTarget(self, action:#selector(sexBtnClick) , for: .touchUpInside)
        sexWoman.addTarget(self, action:#selector(sexBtnClick) , for: .touchUpInside)
        btnbirstday.addTarget(self, action:#selector(BtnClick) , for: .touchUpInside)
        btnnationality.addTarget(self, action:#selector(BtnClick) , for: .touchUpInside)
    }
    @objc func sexBtnClick(btn:UIButton){
        if((mydelegate) != nil){
            if btn.isEqual(sexMan){
                sexMan.isSelected = true
                sexWoman.isSelected = false
                mydelegate?.SexbtnDoSomethingBlcok(content: sex.man.rawValue)
            }else{
                sexMan.isSelected = false
                sexWoman.isSelected = true
                mydelegate?.SexbtnDoSomethingBlcok(content: sex.women.rawValue)
            }
        }
    }
    @objc func BtnClick(btn:UIButton){
        print("\(btn.tag)")
        if((mydelegate) != nil){
            switch btn.tag{
            case viewtag.birstday.rawValue:
                mydelegate?.btnDoSomethingBlcok(tag: viewtag(rawValue: btn.tag)!, funDone: { (birstday) in
                    NSLog(birstday)
                    self.birstday.text = birstday
                })
                break
            case viewtag.nationality.rawValue:
                mydelegate?.btnDoSomethingBlcok(tag: viewtag(rawValue: btn.tag)!, funDone: { (nationality) in
                    NSLog(nationality)
                    self.nationality.text = nationality
                })
                break
            default:
                break
            }
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField.tag {
        case viewtag.firstName.rawValue,viewtag.lastName.rawValue:
            textField.text = textField.text?.uppercased()
        default:
            break
        }
        if((mydelegate) != nil){
            mydelegate?.textFieldDidEndEditingBlcok(content: textField.text!,tag: viewtag(rawValue: textField.tag)!)
        }
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        NSLog(string + "\(range.location) \(range.length) ")
        var res = true
        if string.isEmpty {
            res = true
        }else{
            switch textField.tag {
            case viewtag.firstName.rawValue,viewtag.lastName.rawValue:
                res = string.validateNameinput()
            default:
                break
            }
        }
        return res
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if((mydelegate) != nil){
            mydelegate?.textFieldDidEndEditingBlcok(content: textField.text!,tag: viewtag(rawValue: textField.tag)!)
        }
        if(textField == firstName)
        {
            guard firstName.text != nil  && !(firstName.text?.isEmpty)! else{
                myselfShowMessage("请输入名")
                return false
            }
            lastName.becomeFirstResponder()
        }
        if(textField == lastName)
        {
            guard firstName.text != nil  && !(firstName.text?.isEmpty)! else{
                myselfShowMessage("请输入姓")
                return false
            }
            lastName.resignFirstResponder()
            BtnClick(btn: btnbirstday)
        }
        return true
    }
    
    func myselfShowMessage(_ msg:String) -> Void {
        if((mydelegate) != nil){
            mydelegate?.showMessage(msg: msg)
        }
    }
    
}
