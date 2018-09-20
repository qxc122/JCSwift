//
//  BasicTableviewVc.swift
//  JCSwift
//
//  Created by MiNi on 2018/4/23.
//  Copyright © 2018年 wdada0620@gmail.com. All rights reserved.
//

import UIKit

class BasicTableviewVc: BasicVc,UITableViewDelegate,UITableViewDataSource{
    
    lazy var tableView : UITableView = UITableView()
    var dataArry = [AnyObject]()
    let iderntify:String = "UITableViewCell"
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        tableView.backgroundColor = UIColor.clear
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: iderntify)
        tableView.dataSource = self
        tableView.delegate   = self
    }
    func registerOfCells(cells arryCell:[NSString])  {
        for className in arryCell {
            let classType = NSClassFromString(className as String) as? UITableViewCell.Type
            if classType != nil{
                tableView.register(classType.self, forCellReuseIdentifier: className as String)
            }
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArry.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: iderntify, for: indexPath)
        return cell
    }
}
