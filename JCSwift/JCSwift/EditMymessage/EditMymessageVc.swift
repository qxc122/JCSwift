//
//  EditMymessageVc.swift
//  JCSwift
//
//  Created by MiNi on 2018/5/24.
//  Copyright © 2018年 wdada0620@gmail.com. All rights reserved.
//

import UIKit

class EditMymessageVc: BasicVc , UITextFieldDelegate {
    //定义block
    typealias saveOk = (_ sex :String, _ suName :String,_ EnName:String,_ birthday :String, _ nationality :String,_ zone:String,_ phone:String) ->()
    //创建block变量
    var saveDoneOk:saveOk!
    
    var userInfo:UserInfoModel?
    
    var sex:String?
    var nationality:countryItem?
    var zone:countryItem?
    
    lazy var sexMan = UIButton()
    lazy var sexWoman = UIButton()
    
    lazy var TwoIn = UITextField()
    lazy var threeIn = UITextField()
    lazy var fourIn = UITextField()
    lazy var fiveIn = UITextField()
    lazy var SixBtn = UIButton()
    lazy var SixIn = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SetEditMymessageVcUI()
        // Do any additional setup after loading the view.
    }
    func SetEditMymessageVcUI()  {
        title = "我的资料"
        let back = UIView()
        view.addSubview(back)
        back.layer.cornerRadius = 4.0
        back.backgroundColor = UIColor.white
        back.snp.makeConstraints { (make) in
            make.left.equalTo(view).offset(20)
            make.right.equalTo(view).offset(-20)
            make.top.equalTo(view).offset(20)
        }
        let one = UIView()
        one.backgroundColor = UIColor(hex: "#DFDFDF")
        view.addSubview(one)
        one.snp.makeConstraints { (make) in
            make.left.equalTo(back)
            make.right.equalTo(back)
            make.height.equalTo(0.5)
            make.top.equalTo(back).offset(60)
        }
        let oneTitle = UILabel()
        oneTitle.font = UIFont.init(name: "PingFangSC-Regular", size: 14)
        oneTitle.textColor = UIColor(hex: "#ACABAB")
        view.addSubview(oneTitle)
        oneTitle.snp.makeConstraints { (make) in
            make.left.equalTo(back).offset(20)
            make.top.equalTo(back)
            make.bottom.equalTo(one.snp.top)
        }
        view.addSubview(sexMan)
        view.addSubview(sexWoman)
        sexMan.snp.makeConstraints { (make) in
            make.left.equalTo(back).offset(96)
            make.centerY.equalTo(oneTitle)
            make.height.equalTo(44)
        }
        sexWoman.snp.makeConstraints { (make) in
            make.left.equalTo(sexMan.snp.right).offset(30)
            make.centerY.equalTo(sexMan)
            make.height.equalTo(44)
        }
        
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
        
        
        let Two = UIView()
        Two.backgroundColor = UIColor(hex: "#DFDFDF")
        view.addSubview(Two)
        Two.snp.makeConstraints { (make) in
            make.left.equalTo(back)
            make.right.equalTo(back)
            make.height.equalTo(0.5)
            make.top.equalTo(one.snp.bottom).offset(60)
        }
        let TwoTitle = UILabel()
        TwoTitle.font = UIFont.init(name: "PingFangSC-Regular", size: 14)
        TwoTitle.textColor = UIColor(hex: "#ACABAB")
        view.addSubview(TwoTitle)
        TwoTitle.snp.makeConstraints { (make) in
            make.left.equalTo(back).offset(20)
            make.top.equalTo(one)
            make.bottom.equalTo(Two.snp.top)
        }
        TwoIn.font = UIFont.init(name: "PingFangSC-Regular", size: 14)
        TwoIn.textColor = UIColor(hex: "#000000")
        view.addSubview(TwoIn)
        TwoIn.snp.makeConstraints { (make) in
            make.left.equalTo(back).offset(96)
            make.right.equalTo(back).offset(-20)
            make.centerY.equalTo(TwoTitle)
        }
        
        
        let three = UIView()
        three.backgroundColor = UIColor(hex: "#DFDFDF")
        view.addSubview(three)
        three.snp.makeConstraints { (make) in
            make.left.equalTo(back)
            make.right.equalTo(back)
            make.height.equalTo(0.5)
            make.top.equalTo(Two.snp.bottom).offset(60)
        }
        let threeTitle = UILabel()
        threeTitle.font = UIFont.init(name: "PingFangSC-Regular", size: 14)
        threeTitle.textColor = UIColor(hex: "#ACABAB")
        view.addSubview(threeTitle)
        threeTitle.snp.makeConstraints { (make) in
            make.left.equalTo(back).offset(20)
            make.top.equalTo(Two)
            make.bottom.equalTo(three.snp.top)
        }

        threeIn.font = UIFont.init(name: "PingFangSC-Regular", size: 14)
        threeIn.textColor = UIColor(hex: "#000000")
        view.addSubview(threeIn)
        threeIn.snp.makeConstraints { (make) in
            make.left.equalTo(back).offset(96)
            make.right.equalTo(back).offset(-20)
            make.centerY.equalTo(threeTitle)
        }
        
        let four = UIView()
        four.backgroundColor = UIColor(hex: "#DFDFDF")
        view.addSubview(four)
        four.snp.makeConstraints { (make) in
            make.left.equalTo(back)
            make.right.equalTo(back)
            make.height.equalTo(0.5)
            make.top.equalTo(three.snp.bottom).offset(60)
        }
        let fourTitle = UILabel()
        fourTitle.font = UIFont.init(name: "PingFangSC-Regular", size: 14)
        fourTitle.textColor = UIColor(hex: "#ACABAB")
        view.addSubview(fourTitle)
        fourTitle.snp.makeConstraints { (make) in
            make.left.equalTo(back).offset(20)
            make.top.equalTo(three)
            make.bottom.equalTo(four.snp.top)
        }
        fourIn.font = UIFont.init(name: "PingFangSC-Regular", size: 14)
        fourIn.textColor = UIColor(hex: "#000000")
        view.addSubview(fourIn)
        fourIn.snp.makeConstraints { (make) in
            make.left.equalTo(back).offset(96)
            make.right.equalTo(back).offset(-20)
            make.centerY.equalTo(fourTitle)
        }
        let fourPng = UIImageView()
        fourPng.image = UIImage.init(named: "更多")
        view.addSubview(fourPng)
        fourPng.snp.makeConstraints { (make) in
            make.width.equalTo(6)
            make.height.equalTo(11)
            make.right.equalTo(back).offset(-20)
            make.centerY.equalTo(fourTitle)
        }
        let fourBtn = UIButton()
        view.addSubview(fourBtn)
        fourBtn.addTarget(self, action: #selector(fourBtnClick), for: .touchUpInside)
        fourBtn.snp.makeConstraints { (make) in
            make.top.equalTo(fourTitle)
            make.bottom.equalTo(fourTitle)
            make.left.equalTo(fourTitle)
            make.right.equalTo(fourPng)
        }
        
        
        let five = UIView()
        five.backgroundColor = UIColor(hex: "#DFDFDF")
        view.addSubview(five)
        five.snp.makeConstraints { (make) in
            make.left.equalTo(back)
            make.right.equalTo(back)
            make.height.equalTo(0.5)
            make.top.equalTo(four.snp.bottom).offset(60)
            make.bottom.equalTo(back.snp.bottom).offset(-60)
        }
        let fiveTitle = UILabel()
        fiveTitle.font = UIFont.init(name: "PingFangSC-Regular", size: 14)
        fiveTitle.textColor = UIColor(hex: "#ACABAB")
        view.addSubview(fiveTitle)
        fiveTitle.snp.makeConstraints { (make) in
            make.left.equalTo(back).offset(20)
            make.top.equalTo(four)
            make.bottom.equalTo(five.snp.top)
        }

        fiveIn.font = UIFont.init(name: "PingFangSC-Regular", size: 14)
        fiveIn.textColor = UIColor(hex: "#000000")
        view.addSubview(fiveIn)
        fiveIn.snp.makeConstraints { (make) in
            make.left.equalTo(back).offset(96)
            make.right.equalTo(back).offset(-20)
            make.centerY.equalTo(fiveTitle)
        }
        let fivePng = UIImageView()
        fivePng.image = UIImage.init(named: "更多")
        view.addSubview(fivePng)
        fivePng.snp.makeConstraints { (make) in
            make.width.equalTo(6)
            make.height.equalTo(11)
            make.right.equalTo(back).offset(-20)
            make.centerY.equalTo(fiveTitle)
        }
        let fiveBtn = UIButton()
        view.addSubview(fiveBtn)
        fiveBtn.addTarget(self, action: #selector(fiveBtnClick), for: .touchUpInside)
        fiveBtn.snp.makeConstraints { (make) in
            make.top.equalTo(fiveTitle)
            make.bottom.equalTo(fiveTitle)
            make.left.equalTo(fiveTitle)
            make.right.equalTo(fivePng)
        }
        
        let SixTitle = UILabel()
        SixTitle.font = UIFont.init(name: "PingFangSC-Regular", size: 14)
        SixTitle.textColor = UIColor(hex: "#ACABAB")
        view.addSubview(SixTitle)
        SixTitle.snp.makeConstraints { (make) in
            make.left.equalTo(back).offset(20)
            make.top.equalTo(five.snp.bottom)
            make.bottom.equalTo(back.snp.bottom)
        }

        view.addSubview(SixBtn)
        SixBtn.addTarget(self, action: #selector(SixBtnClick), for: .touchUpInside)
        SixBtn.snp.makeConstraints { (make) in
            make.centerY.equalTo(SixTitle)
            make.height.equalTo(44)
            make.left.equalTo(back).offset(96)
        }
        SixBtn.setTitleColor(UIColor(hex: "#000000"), for: .normal)
        SixBtn.titleLabel?.font = UIFont(name: "PingFangSC-Regular", size: 14)
        let sixLine = UIView()
        sixLine.backgroundColor = UIColor(hex: "#DFDFDF")
        view.addSubview(sixLine)
        sixLine.snp.makeConstraints { (make) in
            make.left.equalTo(SixBtn.snp.right).offset(17.7)
            make.centerY.equalTo(SixTitle)
            make.height.equalTo(30)
            make.width.equalTo(0.5)
        }

        SixIn.font = UIFont.init(name: "PingFangSC-Regular", size: 14)
        SixIn.textColor = UIColor(hex: "#000000")
        view.addSubview(SixIn)
        SixIn.snp.makeConstraints { (make) in
            make.left.equalTo(sixLine.snp.right).offset(20)
            make.right.equalTo(back).offset(-20).priority(.low)
            make.centerY.equalTo(SixTitle)
        }
        
        
        oneTitle.text = "称呼"
        TwoTitle.text = "英文名"
        threeTitle.text = "英文性"
        fourTitle.text = "出生日期"
        fiveTitle.text = "国籍"
        SixTitle.text = "手机号码"
        
        TwoIn.placeholder = "证件上的英文名"
        threeIn.placeholder = "证件上的英文性"
        fourIn.placeholder = "请选择出生日期"
        fiveIn.placeholder = "请选择国籍"
        SixIn.placeholder = "请输入手机号码"
        
        sexMan.addTarget(self, action: #selector(sexBtnClick), for: .touchUpInside)
        sexWoman.addTarget(self, action: #selector(sexBtnClick), for: .touchUpInside)
    
        TwoIn.delegate = self
        threeIn.delegate = self
        SixIn.delegate = self
        TwoIn.tag = viewtag.firstName.rawValue
        threeIn.tag = viewtag.lastName.rawValue
        SixIn.tag = viewtag.phone.rawValue
        TwoIn.returnKeyType = .next
        threeIn.returnKeyType = .next
        SixIn.returnKeyType = .done
        

        
        if userInfo != nil {
            SixBtn.set(image: UIImage(named: "下拉"), title: String(format: "+%@", (userInfo?.zone)!) as NSString, titlePosition: .left,
                       additionalSpacing: 5.0, state: .normal)
            sex = userInfo?.sex
            if userInfo?.sex == "F" {
                sexMan.isSelected = true
                sexWoman.isSelected = false
            }else if userInfo?.sex == "M" {
                sexMan.isSelected = false
                sexWoman.isSelected = true
            }
            TwoIn.text = userInfo?.surname
            threeIn.text = userInfo?.enName
            fourIn.text = userInfo?.birthday
            fiveIn.text = userInfo?.nationlityName
            SixIn.text = userInfo?.mobile
            
            zone = countryItem.init(countryCode: "1", countryName: "1", areaCode: (userInfo?.zone)!)
            nationality = countryItem.init(countryCode: (userInfo?.nationality)!, countryName: (userInfo?.nationlityName)!, areaCode: "1")
        }else{
            SixBtn.set(image: UIImage(named: "下拉"), title: "+86", titlePosition: .left,
                       additionalSpacing: 5.0, state: .normal)
        }
        
        let submit  = UIButton()
        submit.setBackgroundImage(UIColor(hex: "#ED1C24").creatImageWithColor(), for: .normal)
        submit.setTitle("保存", for: .normal)
        submit.setTitleColor(UIColor(hex: "#FFFFFF"), for: .selected)
        submit.titleLabel?.font = UIFont(name: "PingFangSC-Regular", size: 17)
        view.addSubview(submit)
        submit.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(50)
        }
        submit.addTarget(self, action: #selector(changeInfo), for: .touchUpInside)
    }
    @objc func sexBtnClick(btn:UIButton) {
        if  btn == sexMan {
            sex = "F"
            sexMan.isSelected = true
            sexWoman.isSelected = false
        }else if  btn == sexWoman {
            sexMan.isSelected = false
            sexWoman.isSelected = true
            sex = "M"
        }
    }
    @objc func fourBtnClick() {
        let datapicker = UIAlertDateController(title: "\n\n\n\n\n\n\n", message: nil,preferredStyle: .actionSheet)
        datapicker.doneblock = { (date) in
            if let _ = date{
                self.fourIn.text = date
            }
        }
        if let popoverPresentationController = datapicker.popoverPresentationController {
            popoverPresentationController.sourceView = self.view
            popoverPresentationController.sourceRect = CGRect.init(x: UIScreen.main.bounds.width-46, y: 230.5, width: 100, height: 0)
        }
        self.present(datapicker, animated: true, completion: nil)
    }
    @objc func fiveBtnClick() {
        choosecityVcFunc(choosecityVctype(rawValue: choosecityVctype.county.rawValue)!)
    }
    @objc func SixBtnClick() {
        choosecityVcFunc(choosecityVctype(rawValue: choosecityVctype.zone.rawValue)!)
    }
    
    func choosecityVcFunc(_ type:choosecityVctype) {
        let vc = choosecityVc()
        vc.type = type.rawValue
        vc.blockproerty = { (backMsg) in
            switch type {
            case choosecityVctype.county:
                self.nationality = backMsg
                self.fiveIn.text = self.nationality!.countryName
                break
            case choosecityVctype.zone:
                self.zone = backMsg
                self.SixBtn.set(image: UIImage(named: "下拉"), title: "+"+self.zone!.areaCode! as NSString, titlePosition: .left,
                           additionalSpacing: 5.0, state: .normal)
                break
            }
        }
        self.navigationController?.pushViewController(vc, animated: true)
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
            case viewtag.phone.rawValue:
                res = string.validateNumeralsinput()
            default:
                break
            }
        }
        return res
    }
    
    @objc func changeInfo()  {
        guard sex != nil && !(sex?.isEmpty)! else{
            view.showMessage(message: "请选择性别")
            return
        }
        guard TwoIn.text != nil && !(TwoIn.text?.isEmpty)! else{
            view.showMessage(message: "请输入名")
            return
        }
        guard threeIn.text != nil && !(threeIn.text?.isEmpty)! else{
            view.showMessage(message: "请输入姓")
            return
        }
        guard fourIn.text != nil && !(fourIn.text?.isEmpty)! else{
            view.showMessage(message: "请选择出生日期")
            return
        }
        guard nationality != nil else{
            view.showMessage(message: "请选择国籍")
            return
        }
        guard zone != nil else{
            view.showMessage(message: "请选择区号")
            return
        }
        guard SixIn.text != nil && !(SixIn.text?.isEmpty)! && (SixIn.text?.validateType(.phone))! else{
            view.showMessage(message: "请输入正确的手机号")
            return
        }
        
        view.showLoadingTilteActivity(message: "修改中...")
        NetworkTools.shareInstance.URLBASIC_jcModifyMyInfo(SixIn.text!, zone: (zone?.areaCode)!, surname: TwoIn.text!, enName: threeIn.text!, sex: sex!, birthday: fourIn.text!, nationality: (nationality?.countryCode)!, successCallback: { (res) in
            self.view.hideActivity()
            self.view.showMessage(message: "修改成功")
            if self.saveDoneOk != nil {
                self.saveDoneOk(self.sex!,self.TwoIn.text!,self.threeIn.text!,self.fourIn.text!,self.fiveIn.text!,(self.zone?.areaCode)!,self.SixIn.text!)
            }
            
            let tmp = DBUserInfoModel.shareInstance.getdata()
            tmp?.surname = self.TwoIn.text!
            tmp?.enName = self.threeIn.text!
            DBUserInfoModel.shareInstance.setdata(data: tmp!)
            
            self.navigationController?.popViewController(animated: true)
        }) { (error) in
            self.view.hideActivity()
            self.view.showMessage(message: error.localizedDescription)
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField.tag {
        case viewtag.firstName.rawValue,viewtag.lastName.rawValue:
            textField.text = textField.text?.uppercased()
        default:
            break
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if(textField == TwoIn)
        {
            guard TwoIn.text != nil  && !(TwoIn.text?.isEmpty)! else{
                view.showMessage(message: "请输入名")
                return false
            }
            textField.text = textField.text?.uppercased()
            threeIn.becomeFirstResponder()
        }else if(textField == threeIn){
            guard threeIn.text != nil  && !(threeIn.text?.isEmpty)! else{
                view.showMessage(message: "请输入姓")
                return false
            }
            textField.text = textField.text?.uppercased()
            threeIn.resignFirstResponder()
            fourBtnClick()
        }else if(textField == SixIn){
            guard SixIn.text != nil && !(SixIn.text?.isEmpty)! && (SixIn.text?.validateType(.phone))! else{
                view.showMessage(message: "请输入正确的手机号")
                return false
            }
            SixIn.resignFirstResponder()
            changeInfo()
        }
        return true
    }
}
