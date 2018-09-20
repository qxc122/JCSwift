//
//  RegisterThreeCell.swift
//  JCSwift
//
//  Created by MiNi on 2018/4/25.
//  Copyright © 2018年 wdada0620@gmail.com. All rights reserved.
//

import UIKit

class RegisterThreeCell: UICollectionViewCell ,UITextFieldDelegate {
    var mydelegate: celldelegate?
    
    lazy var backview: UIView = UIView()
    lazy var zone: UITextField = UITextField()
    lazy var lineOne: UIView = UIView()
    
    lazy var phone: UITextField = UITextField()
    lazy var btnzone: UIButton = UIButton()
    lazy var Agreement: UIButton = UIButton()
    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    func initView(){
        phone.returnKeyType = .done
        
        self.contentView.addSubview(backview)
        self.contentView.addSubview(zone)
        self.contentView.addSubview(lineOne)
        self.contentView.addSubview(phone)
        self.contentView.addSubview(btnzone)
        self.contentView.addSubview(Agreement)
        
        zone.delegate = self
        phone.delegate = self
        
        phone.tag = viewtag.phone.rawValue
        btnzone.tag = viewtag.zone.rawValue
        
        lineOne.backgroundColor = UIColor(hex: "#F3F3F3")
        zone.clearButtonMode = .whileEditing
        phone.clearButtonMode = .whileEditing
        phone.keyboardType = .phonePad
        zone.font = UIFont(name: "PingFangSC-Regular", size: 15)
        zone.placeholder = "国家／地区"
        zone.isUserInteractionEnabled = false
        phone.font = UIFont(name: "PingFangSC-Regular", size: 15)
        phone.placeholder = "手机号码"
        btnzone.setImage(UIImage(named: "更多"), for: .normal)

        backview.backgroundColor = UIColor.white
        backview.layer.cornerRadius = 4.0
        backview.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.top.equalToSuperview()
        }
        
        Agreement.snp.makeConstraints { (make) in
            make.left.equalTo(backview)
            make.top.equalTo(backview.snp.bottom).offset(10.5)
            make.height.equalTo(44)
        }
        
        lineOne.snp.makeConstraints { (make) in
            make.left.equalTo(backview)
            make.right.equalTo(backview)
            make.top.equalTo(backview).offset(63)
            make.height.equalTo(0.5)
            make.bottom.equalTo(backview.snp.bottom).offset(-63)
        }
        zone.snp.makeConstraints { (make) in
            make.left.equalTo(backview).offset(20)
            make.right.equalTo(backview).offset(-20)
            make.top.equalTo(backview)
            make.bottom.equalTo(lineOne.snp.top)
        }
        btnzone.snp.makeConstraints { (make) in
            make.centerY.equalTo(zone)
            make.right.equalTo(backview).offset(-3.5)
            make.width.height.equalTo(44)
        }
        phone.snp.makeConstraints { (make) in
            make.left.equalTo(zone)
            make.right.equalTo(zone)
            make.top.equalTo(lineOne.snp.bottom)
            make.bottom.equalTo(backview)
        }
        
        btnzone.addTarget(self, action:#selector(BtnClick) , for: .touchUpInside)

        Agreement.addTarget(self, action:#selector(AgreementClick) , for: .touchUpInside)
        Agreement.setImage(UIImage(named: "未选"), for: .normal)
        Agreement.setImage(UIImage(named: "选择"), for: .selected)
        Agreement.setImage(UIImage(named: "选择"), for: .highlighted)
        Agreement.setTitle("我已阅读并同意", for: .normal)
        Agreement.setTitleColor(UIColor(hex: "#ACABAB"), for: .normal)
        Agreement.titleLabel?.font = UIFont(name: "PingFangSC-Regular", size: 14)
        
        let btn1 = UIButton()
        btn1.tag = 11
        self.contentView.addSubview(btn1)
        btn1.snp.makeConstraints { (make) in
            make.left.equalTo(Agreement.snp.right)
            make.centerY.equalTo(Agreement)
            make.height.equalTo(Agreement)
        }
        btn1.setTitle("《隐私条约》", for: .normal)
        btn1.setTitleColor(UIColor(hex: "#ACABAB"), for: .normal)
        btn1.titleLabel?.font = UIFont(name: "PingFangSC-Regular", size: 14)
        btn1.addTarget(self, action:#selector(agreementUrl) , for: .touchUpInside)
        
        let btn2 = UIButton()
        self.contentView.addSubview(btn2)
        btn2.snp.makeConstraints { (make) in
            make.left.equalTo(btn1.snp.right)
            make.centerY.equalTo(Agreement)
            make.height.equalTo(Agreement)
        }
        btn2.setTitle(" 、《服务条约》。", for: .normal)
        btn2.setTitleColor(UIColor(hex: "#ACABAB"), for: .normal)
        btn2.titleLabel?.font = UIFont(name: "PingFangSC-Regular", size: 14)
        btn2.addTarget(self, action:#selector(agreementUrl) , for: .touchUpInside)
    }
    @objc func BtnClick(btn:UIButton){
        if((mydelegate) != nil){
            mydelegate?.btnDoSomethingBlcok(tag: viewtag(rawValue: btn.tag)!, funDone: { (zone) in
                NSLog(zone)
                self.zone.text = zone
            })
        }
    }
    @objc func AgreementClick(btn:UIButton){
        if !btn.isSelected {
            btn.isSelected = true
            if((mydelegate) != nil){
                mydelegate?.AgreementStaue(Staue: btn.isSelected)
            }
        }
    }
    @objc func agreementUrl(btn:UIButton){
        if((mydelegate) != nil){
            if btn.tag == 11{
                mydelegate?.agreementUrl((DBGlobalParameter.shareInstance.getdata()?.jcPrivacyPolicyUrl)!)
            }else{
                mydelegate?.agreementUrl((DBGlobalParameter.shareInstance.getdata()?.jcGccUrl)!)
            }
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if((mydelegate) != nil){
            mydelegate?.textFieldDidEndEditingBlcok(content: textField.text!,tag: viewtag(rawValue: textField.tag)!)
        }
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        NSLog(string + "\(range.location) \(range.length) ")
        var res = false
        if string.isEmpty {
            res = true
        }else{
            switch textField.tag {
            case viewtag.phone.rawValue:
                res = string.validateNumeralsinput()
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
        if(textField == phone)
        {
            guard textField.text != nil && !(textField.text?.isEmpty)! && (textField.text?.validateType(.phone))! else{
                myselfShowMessage("请输入正确的手机号")
                return false
            }
            textField.resignFirstResponder()
            if((mydelegate) != nil){
                mydelegate?.submissionBtnClick()
            }
        }
        return true
    }
    func myselfShowMessage(_ msg:String) -> Void {
        if((mydelegate) != nil){
            mydelegate?.showMessage(msg: msg)
        }
    }
}
