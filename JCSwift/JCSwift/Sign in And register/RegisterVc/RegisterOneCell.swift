//
//  RegisterOneCell.swift
//  JCSwift
//
//  Created by MiNi on 2018/4/25.
//  Copyright © 2018年 wdada0620@gmail.com. All rights reserved.
//

import UIKit

protocol celldelegate {
    func textFieldDidEndEditingBlcok(content:String,tag:viewtag)  -> Void
    func SexbtnDoSomethingBlcok(content:String)  -> Void
    func btnDoSomethingBlcok(tag:viewtag,funDone:@escaping ((String) -> Void))  -> Void
    
    func showMessage(msg:String)  -> Void
    func submissionBtnClick()  -> Void
    
    func AgreementStaue(Staue:Bool)  -> Void
    func agreementUrl(_ Staue:URL)  -> Void
//    func lastNameEditOk()  -> Void
}

class RegisterOneCell: UICollectionViewCell ,UITextFieldDelegate{
    var mydelegate: celldelegate?
    
    lazy var backview: UIView = UIView()
    lazy var email: UITextField = UITextField()
    lazy var lineOne: UIView = UIView()
    
    lazy var passWord: UITextField = UITextField()
    lazy var lineTwo: UIView = UIView()
    
    lazy var passWordTwo: UITextField = UITextField()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func initView(){
        email.returnKeyType = .next
        passWord.returnKeyType = .next
        passWordTwo.returnKeyType = .next
        
        self.contentView.addSubview(backview)
        self.contentView.addSubview(email)
        self.contentView.addSubview(lineOne)
        self.contentView.addSubview(passWord)
        self.contentView.addSubview(lineTwo)
        self.contentView.addSubview(passWordTwo)
        email.delegate = self
        passWord.delegate = self
        passWordTwo.delegate = self
        lineOne.backgroundColor = UIColor(hex: "#F3F3F3")
        lineTwo.backgroundColor = UIColor(hex: "#F3F3F3")
        email.clearButtonMode = .whileEditing
        passWord.clearButtonMode = .whileEditing
        passWordTwo.clearButtonMode = .whileEditing
        email.font = UIFont(name: "PingFangSC-Regular", size: 15)
        email.placeholder = "请输入邮箱地址"
        email.tag = viewtag.email.rawValue
        passWord.tag = viewtag.password.rawValue
        passWordTwo.tag = viewtag.passwordTwo.rawValue
        email.keyboardType = .emailAddress
        passWord.keyboardType = .asciiCapable
        passWordTwo.keyboardType = .asciiCapable
        
        passWord.font = UIFont(name: "PingFangSC-Regular", size: 15)
        passWord.placeholder = "请输入密码"
        
        passWordTwo.font = UIFont(name: "PingFangSC-Regular", size: 15)
        passWordTwo.placeholder = "请再次输入密码"
        backview.backgroundColor = UIColor.white
        backview.layer.cornerRadius = 4.0
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
            make.bottom.equalTo(backview.snp.bottom).offset(-63)
        }
        email.snp.makeConstraints { (make) in
            make.left.equalTo(backview).offset(20)
            make.right.equalTo(backview).offset(-20)
            make.top.equalTo(backview)
            make.bottom.equalTo(lineOne.snp.top)
        }
        passWord.snp.makeConstraints { (make) in
            make.left.equalTo(email)
            make.right.equalTo(email)
            make.top.equalTo(lineOne.snp.bottom)
            make.bottom.equalTo(lineTwo.snp.top)
        }
        passWordTwo.snp.makeConstraints { (make) in
            make.left.equalTo(email)
            make.right.equalTo(email)
            make.top.equalTo(lineTwo.snp.bottom)
            make.bottom.equalTo(backview)
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
            case viewtag.email.rawValue:
                res = string.validateMailboxinput()
            case viewtag.password.rawValue , viewtag.passwordTwo.rawValue:
                res = string.validatePassWordinput()
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
        if(textField == email)
        {
            guard email.text != nil  && !(email.text?.isEmpty)! && (email.text?.validateType())! else{
                myselfShowMessage("请输入正确的邮箱")
                return false
            }
            passWord.becomeFirstResponder()
        }
        if(textField == passWord || textField == passWordTwo)
        {
            var passWordText:String?
            if textField == passWord{
                passWordText = passWord.text
            }else{
                passWordText = passWordTwo.text
            }
            guard passWordText != nil  && !(passWordText?.isEmpty)! && (passWordText?.count)! >= 6 else{
                myselfShowMessage("至少输入6位密码")
                return false
            }
            guard (passWordText?.validateHasNumeralsAndNumerals())! else{
                myselfShowMessage("密码必须包含数字和字母")
                return false
            }
            if textField == passWord{
                passWordTwo.becomeFirstResponder()
            }else{
                if((mydelegate) != nil){
                    mydelegate?.submissionBtnClick()
                }
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
