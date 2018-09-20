//
//  SignInVc.swift
//  JCSwift
//
//  Created by MiNi on 2018/4/24.
//  Copyright © 2018年 wdada0620@gmail.com. All rights reserved.
//

import UIKit
import ObjectMapper
import TKSubmitTransition
import NVActivityIndicatorView
class SignInVc: BasicVc,UITextFieldDelegate {
    lazy var topview: UIView = UIView()
    lazy var lineH: UIView = UIView()
    var email: UITextField = UITextField()
    var passWord: UITextField = UITextField()
    
    lazy var login: TKTransitionSubmitButton = TKTransitionSubmitButton()
    
    lazy var register: UIButton = UIButton()
    lazy var lineV: UIView = UIView()
    lazy var Visitors: UIButton = UIButton()
    var load:Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        setSignInVcUI()
    }
    
    func setSignInVcUI()  {
        email.keyboardType = .emailAddress
        
        email.returnKeyType = .next
        passWord.returnKeyType = .done
        passWord.isSecureTextEntry = true
        passWord.keyboardType = .asciiCapable
        email.clearButtonMode = .whileEditing
        passWord.clearButtonMode = .whileEditing
        email.tag = viewtag.email.rawValue
        passWord.tag = viewtag.password.rawValue
        email.delegate = self
        passWord.delegate = self
        self.view.addSubview(topview)
        self.view.addSubview(lineH)
        self.view.addSubview(email)
        self.view.addSubview(passWord)
        
        self.view.addSubview(lineV)
        self.view.addSubview(Visitors)
        self.view.addSubview(register)
        self.view.addSubview(login)
        self.title = "登录"
        let loginHeight:CGFloat = 50.0
        login.backgroundColor = UIColor.red
        login.center = self.view.center
        login.layer.cornerRadius = loginHeight/2
        login.setTitle("登录", for: UIControlState())
        login.titleLabel?.font = UIFont(name: "PingFangSC-Medium", size: 17)
        login.addTarget(self, action: #selector(loginload), for: .touchUpInside)
        
        register.setTitle("注册", for: UIControlState())
        register.titleLabel?.font = UIFont(name: "PingFangSC-Regular", size: 14)
        register.setTitleColor(UIColor(hex: "#ACABAB"), for: .normal)
        register.addTarget(self, action: #selector(btnRegister), for: .touchUpInside)

        Visitors.setTitle("以游客身份访问", for: UIControlState())
        Visitors.titleLabel?.font = UIFont(name: "PingFangSC-Regular", size: 14)
        Visitors.setTitleColor(UIColor(hex: "#ACABAB"), for: .normal)
        Visitors.addTarget(self, action: #selector(btnVisitors), for: .touchUpInside)
        
        lineV.backgroundColor = UIColor(hex: "#ACABAB")
        topview.backgroundColor = UIColor.white
        topview.layer.cornerRadius = 4.0
        
        lineH.backgroundColor = self.view.backgroundColor
        email.font = UIFont(name: "PingFangSC-Regular", size: 15)
        passWord.font = UIFont(name: "PingFangSC-Regular", size: 15)
        email.placeholder = "请输入注册的邮箱地址"
        passWord.placeholder = "请输入登陆密码"
        topview.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.top.equalToSuperview().offset(20)
            make.height.equalTo(120)
        }
        lineH.snp.makeConstraints { (make) in
            make.left.equalTo(topview)
            make.right.equalTo(topview)
            make.centerY.equalTo(topview)
            make.height.equalTo(0.5)
        }
        email.snp.makeConstraints { (make) in
            make.left.equalTo(topview).offset(20)
            make.right.equalTo(topview)
            make.top.equalTo(topview)
            make.bottom.equalTo(lineH.snp.top)
        }
        passWord.snp.makeConstraints { (make) in
            make.left.equalTo(topview).offset(20)
            make.right.equalTo(topview)
            make.top.equalTo(lineH.snp.bottom)
            make.bottom.equalTo(topview)
        }
        lineH.snp.makeConstraints { (make) in
            make.left.equalTo(topview)
            make.right.equalTo(topview)
            make.centerY.equalTo(topview)
            make.height.equalTo(0.5)
        }
        email.snp.makeConstraints { (make) in
            make.left.equalTo(topview).offset(20)
            make.right.equalTo(topview)
            make.top.equalTo(topview)
            make.bottom.equalTo(lineH.snp.top)
        }
        passWord.snp.makeConstraints { (make) in
            make.left.equalTo(topview).offset(20)
            make.right.equalTo(topview)
            make.top.equalTo(lineH.snp.bottom)
            make.bottom.equalTo(topview)
        }
        
        login.snp.makeConstraints { (make) in
            make.left.equalTo(topview)
            make.right.equalTo(topview)
            make.top.equalTo(topview.snp.bottom).offset(20)
            make.height.equalTo(loginHeight)
        }
        lineV.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(login.snp.bottom).offset(40)
            make.height.equalTo(24)
            make.width.equalTo(0.5)
        }
        register.snp.makeConstraints { (make) in
            make.left.equalTo(login)
            make.right.equalTo(lineV.snp.left)
            make.centerY.equalTo(lineV)
            make.height.equalTo(44)
        }
        Visitors.snp.makeConstraints { (make) in
            make.right.equalTo(login)
            make.left.equalTo(lineV.snp.right)
            make.centerY.equalTo(lineV)
            make.height.equalTo(44)
        }

        
        

    }

    @objc func loginload() {
        self.view.endEditing(true)
        guard email.text != nil  && !(email.text?.isEmpty)! && (email.text?.validateType())! else{
            view.showMessage(message: "请输入正确的邮箱")
            return
        }
        guard passWord.text != nil  && !(passWord.text?.isEmpty)! && (passWord.text?.count)! >= 6 else{
            view.showMessage(message: "请输入正确的密码")
            return
        }
        guard (passWord.text?.validateHasNumeralsAndNumerals())! else{
            view.showMessage(message: "请输入正确的密码")
            return
        }

        login.startLoadingAnimation()
        // 实例化
        let activityIndicatorView = NVActivityIndicatorView(frame: CGRect.init(x: 0, y: 0, width: 50, height: 50),
                                                            type: .ballClipRotateMultiple)
        activityIndicatorView.tag = 1250
        activityIndicatorView.padding = 5
        
        login.addSubview(activityIndicatorView)
        activityIndicatorView.startAnimating()
        setUserInteractionEnabled(false)
        NetworkTools.shareInstance.URLBASIC_jcLogin(email.text!, password: passWord.text!,  successCallback: { (res) in
            self.view.hideActivity()
            let data = Mapper<UserInfoModel>().map(JSONString: res)
            DBUserInfoModel.shareInstance.setdata(data: data!)

//            self.login.startFinishAnimation(0.5) {
                //Your Transition
                for view in self.login.subviews{
                    if view.tag == 1250 {
                        view.removeFromSuperview()
                        self.navigationController?.popViewController(animated: true)
                        break
                    }
                }
                self.setUserInteractionEnabled(true)
//            }
        }) { (error) in
            activityIndicatorView.removeFromSuperview()
            self.login.returnToOriginalState()
            self.setUserInteractionEnabled(true)
            self.view.hideActivity()
            self.view.showMessage(message: error.localizedDescription)
        }
    }
    func setUserInteractionEnabled(_ en:Bool) {
        if en {
            self.email.isUserInteractionEnabled = true
            self.passWord.isUserInteractionEnabled = true
            self.register.isUserInteractionEnabled = true
            self.Visitors.isUserInteractionEnabled = true
        }else{
            self.email.isUserInteractionEnabled = false
            self.passWord.isUserInteractionEnabled = false
            self.register.isUserInteractionEnabled = false
            self.Visitors.isUserInteractionEnabled = false
        }
    }
    
    @objc func btnRegister() {
        let vc = RegisterVc()
        vc.blockregistersuccess = {(email,passWord) in
            self.email.text = email
            self.passWord.text = passWord
            self.loginload()
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @objc func btnVisitors() {
        self.navigationController?.popViewController(animated: true)
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
            case viewtag.password.rawValue:
                res = string.validatePassWordinput()
            default:
                break
            }
        }
        return res
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if(textField.returnKeyType == UIReturnKeyType.done)
        {
            guard passWord.text != nil  && !(passWord.text?.isEmpty)! && (passWord.text?.count)! >= 6 else{
                view.showMessage(message: "请输入正确的密码")
                return false
            }
            guard (passWord.text?.validateHasNumeralsAndNumerals())! else{
                view.showMessage(message: "请输入正确的密码")
                return false
            }
            textField.resignFirstResponder()//键盘收起
            loginload()
            return false
        }
        if(textField == email)
        {
            guard email.text != nil  && !(email.text?.isEmpty)! && (email.text?.validateType())! else{
                view.showMessage(message: "请输入正确的邮箱")
                return false
            }
            passWord.becomeFirstResponder()
        }
        return true
    }
}
