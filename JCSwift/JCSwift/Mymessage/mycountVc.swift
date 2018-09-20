//
//  mycountVc.swift
//  JCSwift
//
//  Created by MiNi on 2018/5/21.
//  Copyright © 2018年 wdada0620@gmail.com. All rights reserved.
//

import UIKit
import ObjectMapper
import ESPullToRefresh
class mycountVc: BasicTableviewVc {

    lazy private var head = mycountHead()
    lazy private var exit = UIButton()

    var userInfo:UserInfoModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "我的账户"

        registerOfCells(cells: [NSStringFromClass(mycountCell.self) as NSString])
        self.tableView.es.addPullToRefresh {
            [unowned self] in
            self.loadData()
        }
        self.tableView.es.startPullToRefresh()
        exit.isHidden = true
        self.view.addSubview(exit)
        exit.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(50)
        }
        exit.backgroundColor = UIColor(hex: "#ED1C24")
        exit.setTitle("退出", for: UIControlState())
        exit.titleLabel?.font = UIFont(name: "PingFangSC-Regular", size: 17)
        exit.addTarget(self, action: #selector(loginOut), for: .touchUpInside)
    }
    
    @objc func loginOut() {
        view.showLoadingTilteActivity(message: "退出中...")
        NetworkTools.shareInstance.URLBASIC_tpurseuserlogout({ (res) in
            self.view.hideActivity()
            DBUserInfoModel.shareInstance.tableLampDeleteItem()
            self.navigationController?.popViewController(animated: true)
        }) { (error) in
            self.view.hideActivity()
            self.view.showMessage(message: error.localizedDescription)
        }
    }
    func loadData() -> Void {
        NetworkTools.shareInstance.URLBASIC_jcMyInfo({ (res) in
            self.userInfo = Mapper<UserInfoModel>().map(JSONString: res)
//            DBUserInfoModel.shareInstance.setdata(data: self.userInfo!)
            
            self.tableView.es.stopPullToRefresh()
            
            self.head.frame = CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 137)
            self.tableView.tableHeaderView = self.head
            self.head.userInfo = self.userInfo
            self.tableView.reloadData()
            self.exit.isHidden = false
        }) { (error) in
            self.tableView.es.stopPullToRefresh()
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.userInfo != nil {
            return 2
        } else {
            return 0
        }
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let vc = EditMymessageVc()
            vc.saveDoneOk = { (sex,suName,Enname,birthday,nationality,zone,phone) in
                self.userInfo?.sex = sex
                self.userInfo?.surname = suName
                self.userInfo?.enName = Enname
                self.userInfo?.birthday = birthday
                self.userInfo?.nationlityName = nationality
                self.userInfo?.zone = zone
                self.userInfo?.mobile = phone
                self.head.userInfo = self.userInfo
            }
            vc.userInfo = self.userInfo
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            let vc = EachWkWebVc()
            vc.Uurl = DBGlobalParameter.shareInstance.getdata()?.jcPassengerUrl
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(mycountCell.self), for: indexPath)
        let tmp = cell as! mycountCell
        if indexPath.row == 0 {
            tmp.icon.image = UIImage.init(named: "我的资料")
            tmp.name.text = "我的资料"
        } else {
            tmp.icon.image = UIImage.init(named: "常用旅客")
            tmp.name.text = "常用旅客"
        }
        return cell
    }
}
