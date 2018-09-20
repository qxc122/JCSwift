//
//  BasicVc.swift
//  JCSwift
//
//  Created by MiNi on 2018/4/23.
//  Copyright © 2018年 wdada0620@gmail.com. All rights reserved.
//

import UIKit
import SnapKit
import Hue

class BasicVc: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setBasicVcUI()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    private func setBasicVcUI() {
        hidesBackButton()
        setBackButton()
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = UIColor(hex: "#ED1C24")
        self.navigationController?.navigationBar.tintColor = UIColor.white
        let dict:NSDictionary = [NSAttributedStringKey.foregroundColor: UIColor.white,NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 18)]
        self.navigationController?.navigationBar.titleTextAttributes = dict as? [NSAttributedStringKey : AnyObject]
        self.view.backgroundColor = UIColor(hex: "#F3F3F3")
    }
    func setBackButton() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "返回"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(backToSub))
    }
    @objc func backToSub() {
        self.navigationController?.popViewController(animated: true)
    }
    func hidesBackButton() {
//        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
