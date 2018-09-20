//
//  PersonalCenterVc.swift
//  JCSwift
//
//  Created by MiNi on 2018/4/24.
//  Copyright © 2018年 wdada0620@gmail.com. All rights reserved.
//

import UIKit


class PersonalCenterVc: BasicTableviewVc  {

    override func viewDidLoad() {
        let back = UIImageView()
        back.contentMode = .scaleToFill
        back.image = UIImage.init(named: "飞ag机")
        self.view.addSubview(back)
        back.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.top.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        back.clipsToBounds = true
        super.viewDidLoad()
        self.title = "个人中心"

        dataArry.append(pcitem.init(name: "我的账户", icon: "我的账户", idd: "1"))
        dataArry.append(pcitem.init(name: "首页", icon: "首页", idd: "1"))
        dataArry.append(pcitem.init(name: "预定航班", icon: "预订航班", idd: "1"))
        dataArry.append(pcitem.init(name: "我的行程", icon: "我的行程", idd: "1"))
        dataArry.append(pcitem.init(name: "联系我们", icon: "联系我们", idd: "1"))
        dataArry.append(pcitem.init(name: "关于我们", icon: "关于我们", idd: "1"))
//        dataArry.append(pcitem.init(name: "切换语言", icon: "中文", idd: "1"))
        
        registerOfCells(cells: [NSStringFromClass(PersonalCenterCell.self) as NSString])
        self.tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = EachWkWebVc()
        if indexPath.row == 1 || indexPath.row == 4 || indexPath.row == 5 {
            if indexPath.row == 1 {
                self.navigationController?.popViewController(animated: true)
                return
            }else if indexPath.row == 4 {
                vc.Uurl = DBGlobalParameter.shareInstance.getdata()?.jcContactUrl
            } else if indexPath.row == 5 {
//                vc.Uurl = DBGlobalParameter.shareInstance.getdata()?.jcAboutUrl
                vc.Surl = "http://www.tempus.cn/"
            }
        } else {
            let userInfo = DBUserInfoModel.shareInstance.getdata()
            if userInfo != nil {
                if indexPath.row == 0 {
                    self.navigationController?.pushViewController(mycountVc(), animated: true)
                    return
                } else if indexPath.row == 2 {
                    vc.Uurl = DBGlobalParameter.shareInstance.getdata()?.jcFilghtUrl
                } else if indexPath.row == 3 {
                    vc.Uurl = DBGlobalParameter.shareInstance.getdata()?.jcMyTripUrl
                }
            } else {
                self.navigationController?.pushViewController(SignInVc(), animated: true)
                return
            }
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(PersonalCenterCell.self), for: indexPath)
        let tmp = cell as! PersonalCenterCell
        tmp.setdata(item: dataArry[indexPath.row] as! pcitem)
        return cell
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
//    override func viewWillAppear(_ animated: Bool) {
//        self.navigationController?.navigationBar.isHidden = true
//    }
//    override func viewWillDisappear(_ animated: Bool) {
//        self.navigationController?.navigationBar.isHidden = false
//    }
}
