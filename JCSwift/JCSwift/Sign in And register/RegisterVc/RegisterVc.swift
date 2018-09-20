//
//  RegisterVc.swift
//  JCSwift
//
//  Created by MiNi on 2018/4/25.
//  Copyright © 2018年 wdada0620@gmail.com. All rights reserved.
//

import UIKit

class RegisterVc: BasicVc,UICollectionViewDelegate,UICollectionViewDataSource,celldelegate {

    
    //定义block
    typealias registersuccess = (_ email :String,_ passWord:String) ->()
    //创建block变量
    var blockregistersuccess:registersuccess!

    var emailOk:String?
    var email:String?
    var password:String?
    var passwordTwo:String?
    
    var sex:String?
    var firstName:String?
    var lastName:String?
    var birstday:String?
    var nationality:countryItem?
    
    var zone:countryItem?
    var phone:String?
    var agreement:Bool? = false
    
    var page = 0
    
    lazy var progressView = UIProgressView()
    lazy var onepng = UIImageView()
    lazy var onetext = UILabel()
    lazy var twopng = UIImageView()
    lazy var twotext = UILabel()
    lazy var threepng = UIImageView()
    lazy var threetext = UILabel()
    var collectionView:UICollectionView?
    lazy var submissionBtn = UIButton()
    override func viewDidLoad() {
        super.viewDidLoad()
        setRegisterVcUI()
    }
    func showMessage(msg: String) {
        view.showMessage(message: msg)
    }
    func agreementUrl(_ Staue: URL) {
        let vc = EachWkWebVc()
        vc.Uurl = Staue
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func SexbtnDoSomethingBlcok(content:String)  -> Void{
        self.sex = content
        Completejudgment()
        NSLog(content)
    }
    func AgreementStaue(Staue: Bool) {
        agreement = Staue
        Completejudgment()
    }
    func btnDoSomethingBlcok(tag: viewtag, funDone: @escaping ((String) -> Void)) {
        switch tag {
        case viewtag.birstday:
            let datapicker = UIAlertDateController(title: "\n\n\n\n\n\n\n", message: nil,preferredStyle: .actionSheet)
            datapicker.doneblock = { (date) in
                if let _ = date{
                    self.birstday = date
                    funDone(date!)
                    self.Completejudgment()
                }
            }
            if let popoverPresentationController = datapicker.popoverPresentationController {
                popoverPresentationController.sourceView = self.view
                popoverPresentationController.sourceRect = CGRect.init(x: UIScreen.main.bounds.width-46, y: 351.5, width: 100, height: 0)
            }
            self.present(datapicker, animated: true, completion: nil)
            break
        case viewtag.nationality:
            let vc = choosecityVc()
            vc.blockproerty = { (backMsg) in
                self.nationality = backMsg
                funDone(backMsg.countryName!)
                self.Completejudgment()
            }
            self.navigationController?.pushViewController(vc, animated: true)
            break
        case viewtag.zone:
            let vc = choosecityVc()
            vc.type = choosecityVctype.zone.rawValue
            vc.blockproerty = { (backMsg) in
                self.zone = backMsg
                funDone(backMsg.areaCode!)
                self.Completejudgment()
            }
            self.navigationController?.pushViewController(vc, animated: true)
            break
        default:
            break
        }
    }
    func textFieldDidEndEditingBlcok(content:String,tag:viewtag) -> Void {
        switch tag {
        case viewtag.email:
            self.email = content
            if content != emailOk {
                emailOk = nil
            }
        case viewtag.password:
            self.password = content
        case viewtag.passwordTwo:
            self.passwordTwo = content
        case viewtag.firstName:
            self.firstName = content
        case viewtag.lastName:
            self.lastName = content
        case viewtag.phone:
            self.phone = content
        default:
            break
        }
        Completejudgment()
    }
    @objc func submissionBtnClick (){
        if page < 2 {
            if page == 0{
                guard email != nil  && !(email?.isEmpty)! && (email?.validateType())! else{
                    view.showMessage(message: "请输入正确的邮箱")
                    return
                }
                guard password == passwordTwo else{
                    view.showMessage(message: "两次密码输入不一致")
                    return
                }
                guard password != nil  && !(password?.isEmpty)! && (password?.count)! >= 6 else{
                    view.showMessage(message: "至少输入6位密码")
                    return
                }
                guard (password?.validateHasNumeralsAndNumerals())! else{
                    view.showMessage(message: "密码必须包含数字和字母")
                    return
                }
                
                if emailOk != nil && !(emailOk?.isEmpty)!{
                    nextPage()
                } else{
                    view.showLoadingTilteActivity(message: "校验邮箱中...")
                    NetworkTools.shareInstance.URLBASIC_appjcEmailValid(email!, successCallback: { (res) in
                        self.emailOk = self.email
                        self.view.hideActivity()
                        self.nextPage()
                        NSLog("\(Thread.current)")
                    }) { (error) in
                        self.view.hideActivity()
                        self.view.showMessage(message: error.localizedDescription)
                    }
                }
            }else if page == 1{
                guard sex != nil && !(sex?.isEmpty)! else{
                    view.showMessage(message: "请选择性别")
                    return
                }
                guard firstName != nil && !(firstName?.isEmpty)! else{
                    view.showMessage(message: "请输入名")
                    return
                }
                guard lastName != nil && !(lastName?.isEmpty)! else{
                    view.showMessage(message: "请输入姓")
                    return
                }
                guard birstday != nil && !(birstday?.isEmpty)! else{
                    view.showMessage(message: "请选择出生日期")
                    return
                }
                guard nationality != nil else{
                    view.showMessage(message: "请选择国籍")
                    return
                }
                guard email != nil  && !(email?.isEmpty)! && (email?.validateType())! else{
                    view.showMessage(message: "请输入正确的邮箱")
                    backOne()
                    return
                }
                guard password == passwordTwo else{
                    view.showMessage(message: "两次密码输入不一致")
                    backOne()
                    return
                }
                guard password != nil  && !(password?.isEmpty)! && (password?.count)! >= 6 else{
                    view.showMessage(message: "至少输入6位密码")
                    backOne()
                    return
                }
                guard (password?.validateHasNumeralsAndNumerals())! else{
                    view.showMessage(message: "密码必须包含数字和字母")
                    backOne()
                    return
                }
                nextPage()
            }

        } else {
            guard zone != nil else{
                view.showMessage(message: "请选择区号")
                return
            }
            guard phone != nil && !(phone?.isEmpty)! && (phone?.validateType(.phone))! else{
                view.showMessage(message: "请输入正确的手机号")
                return
            }
            guard agreement == true  else {
                view.showMessage(message: "请阅读协议")
                return
            }
            guard email != nil  && !(email?.isEmpty)! && (email?.validateType())! else{
                view.showMessage(message: "请输入正确的邮箱")
                backOne()
                return
            }
            guard password == passwordTwo else{
                view.showMessage(message: "两次密码输入不一致")
                backOne()
                return
            }
            guard password != nil  && !(password?.isEmpty)! && (password?.count)! >= 6 else{
                view.showMessage(message: "至少输入6位密码")
                backOne()
                return
            }
            guard (password?.validateHasNumeralsAndNumerals())! else{
                view.showMessage(message: "密码必须包含数字和字母")
                backOne()
                return
            }
            guard sex != nil && !(sex?.isEmpty)! else{
                view.showMessage(message: "请选择性别")
                return
            }
            guard firstName != nil && !(firstName?.isEmpty)! else{
                view.showMessage(message: "请输入名")
                return
            }
            guard lastName != nil && !(lastName?.isEmpty)! else{
                view.showMessage(message: "请输入姓")
                return
            }
            guard birstday != nil && !(birstday?.isEmpty)! else{
                view.showMessage(message: "请选择出生日期")
                return
            }
            guard nationality != nil else{
                view.showMessage(message: "请选择国籍")
                return
            }

            view.showLoadingTilteActivity(message: "注册中...")
            NetworkTools.shareInstance.URLBASIC_jcRegistered(email!, password: password!, sex: sex!, surname: firstName!, enName: lastName!, birthday: birstday!, nationality: (nationality?.countryCode)!, zone: (zone?.areaCode)!, mobile: phone!, successCallback: { (res) in
                self.view.hideActivity()
                self.view.showMessage(message: "注册成功")
                if let  _ = self.blockregistersuccess {
                    self.blockregistersuccess(self.email!,self.password!)
                }
                self.navigationController?.popViewController(animated: false)
            }) { (error) in
                self.view.hideActivity()
                self.view.showMessage(message: error.localizedDescription)
            }
        }
        progressWithPage(page)
    }
    func nextPage() -> Void {
        page += 1
        print(page)
        collectionView?.scrollToItem(at: IndexPath.init(row: page, section: 0), at: .left, animated: true)
        Completejudgment()
        print(page)
        collectionView?.reloadData()
    }
    func backOne() -> Void {
        page = 0
        collectionView?.scrollToItem(at: IndexPath.init(row: page, section: 0), at: .left, animated: true)
        Completejudgment()
        collectionView?.reloadData()
    }
    func Completejudgment ()  {
        if page == 0 {
            if (email == nil) || (password == nil) || (passwordTwo == nil) || (email?.isEmpty)! || (password?.isEmpty)!  || (passwordTwo?.isEmpty)! {
                submissionBtn.isEnabled = false
            } else{
                submissionBtn.isEnabled = true
            }
        } else if page == 1 {
            if (sex == nil) || (firstName == nil) || (lastName == nil) || (nationality == nil) || (birstday == nil) || (sex?.isEmpty)! || (firstName?.isEmpty)!  || (lastName?.isEmpty)! || (birstday?.isEmpty)!{
                submissionBtn.isEnabled = false
            }else{
                submissionBtn.isEnabled = true
            }
        } else {
            if (zone == nil) || (phone == nil) || (phone?.isEmpty)! || !agreement!{
                submissionBtn.isEnabled = false
            }else{
                submissionBtn.isEnabled = true
            }
        }
    }
    func progressWithPage(_ index:Int) {
        progressView.progress = Float(Double(index+1) * 0.25)
        if index == 0 {
            twopng.isHighlighted = false
            threepng.isHighlighted = false
        } else if index == 1 {
            twopng.isHighlighted = true
            threepng.isHighlighted = false
        } else if index == 2 {
            twopng.isHighlighted = true
            threepng.isHighlighted = true
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        page = Int(scrollView.contentOffset.x/self.view.frame.size.width)
        Completejudgment()
        print(page)
        progressWithPage(page)
    }
    //返回多少个cell
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(RegisterOneCell.self), for: indexPath as IndexPath) as! RegisterOneCell
            cell.mydelegate = self as celldelegate
            return cell
        } else if indexPath.row == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(RegisterTwoCell.self), for: indexPath as IndexPath) as! RegisterTwoCell
            cell.mydelegate = self as celldelegate
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(RegisterThreeCell.self), for: indexPath as IndexPath) as! RegisterThreeCell
            cell.mydelegate = self as celldelegate
            return cell
        }
    }

    func setRegisterVcUI() {
        self.title = "注册"
        self.view.addSubview(progressView)
        progressView.tintColor = UIColor.red
        progressView.backgroundColor = UIColor(hex: "#F3F3F3")
        progressView.progress = 0.25
        
        self.view.addSubview(onepng)
        self.view.addSubview(onetext)
        self.view.addSubview(twopng)
        self.view.addSubview(twotext)
        self.view.addSubview(threepng)
        self.view.addSubview(threetext)
        self.view.addSubview(submissionBtn)
        
        onetext.font = UIFont(name: "PingFangSC-Regular", size: 14)
        twotext.font = UIFont(name: "PingFangSC-Regular", size: 14)
        threetext.font = UIFont(name: "PingFangSC-Regular", size: 14)
        onepng.image = UIImage(named: "红1")
        
        twopng.highlightedImage = UIImage(named: "红2")
        twopng.image = UIImage(named: "灰2")
        threepng.highlightedImage = UIImage(named: "红3")
        threepng.image = UIImage(named: "灰3")
        
        submissionBtn.setBackgroundImage(UIColor.red.creatImageWithColor(), for: .normal)
        submissionBtn.setTitle("下一步", for: .normal)
        submissionBtn.setTitleColor(UIColor.white, for: .normal)
        submissionBtn.titleLabel?.font = UIFont(name: "PingFangSC-Medium", size: 17)
        submissionBtn.addTarget(self, action:#selector(submissionBtnClick) , for: .touchUpInside)
        submissionBtn.isEnabled = false
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.scrollDirection = UICollectionViewScrollDirection.horizontal
        flowLayout.itemSize = CGSize.init(width: self.view.frame.size.width, height: self.view.frame.size.height-138-64-50)
        
        collectionView = UICollectionView(frame: CGRect.zero,collectionViewLayout:flowLayout)
        collectionView!.backgroundColor = UIColor.clear
        collectionView!.delegate = self
        collectionView!.dataSource = self
  
        collectionView?.isPagingEnabled = true
        collectionView?.showsHorizontalScrollIndicator = false
        collectionView?.bounces = false
        self.view.addSubview(collectionView!)
        
        collectionView!.register(RegisterOneCell.self, forCellWithReuseIdentifier: NSStringFromClass(RegisterOneCell.self))
        
        collectionView!.register(RegisterTwoCell.self, forCellWithReuseIdentifier: NSStringFromClass(RegisterTwoCell.self))
        
        collectionView!.register(RegisterThreeCell.self, forCellWithReuseIdentifier: NSStringFromClass(RegisterThreeCell.self))
        
        progressView.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalToSuperview().offset(64)
            make.height.equalTo(2)
        }
        twopng.snp.makeConstraints { (make) in
            make.centerY.equalTo(progressView)
            make.centerX.equalTo(progressView)
            make.width.equalTo(30)
            make.height.equalTo(30)
        }
        
        let pading = UIScreen.main.bounds.width/4
        onepng.snp.makeConstraints { (make) in
            make.centerY.equalTo(progressView)
            make.centerX.equalTo(progressView).offset(-pading)
            make.width.equalTo(30)
            make.height.equalTo(30)
        }
        threepng.snp.makeConstraints { (make) in
            make.centerY.equalTo(progressView)
            make.centerX.equalTo(progressView).offset(pading)
            make.width.equalTo(30)
            make.height.equalTo(30)
        }
        collectionView!.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalTo(progressView.snp.bottom).offset(72)
            make.bottom.equalToSuperview().offset(-50)
        }
        submissionBtn.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(50)
            make.bottom.equalToSuperview()
        }
    }
}
