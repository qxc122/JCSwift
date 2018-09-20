//
//  baseNave.swift
//  JCSwift
//
//  Created by MiNi on 2018/5/30.
//  Copyright © 2018年 wdada0620@gmail.com. All rights reserved.
//

import UIKit

class baseNave: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    let isIPad = UIDevice.current.model == "iPad"
    override var shouldAutorotate: Bool{
        return true
    }
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask{
        if isIPad {
            return .all
        } else {
            return .allButUpsideDown
        }
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
