//
//  choosecityVc.swift
//  JCSwift
//
//  Created by MiNi on 2018/5/3.
//  Copyright © 2018年 wdada0620@gmail.com. All rights reserved.
//

import UIKit
import ObjectMapper

enum choosecityVctype : Int {
    case county = 100
    case zone
}

class choosecityVc: BasicTableviewVc {
    //定义block
    typealias fucBlock = (_ backMsg :countryItem) ->()
    //创建block变量
    var blockproerty:fucBlock!
    
    var dataALL:countryAll?
    var type = choosecityVctype.county.rawValue
    override func viewDidLoad() {
        super.viewDidLoad()
        if type == choosecityVctype.county.rawValue {
            self.title = "选择国家"
        } else {
           self.title = "选择区号"
        }
        
        let path = Bundle.main.path(forResource: "JCzh", ofType: "json")
        let data = NSData.init(contentsOfFile: path!)
        let jsonStr = NSString.init(data: data! as Data, encoding: String.Encoding.utf8.rawValue)
        if data != nil {
            self.dataALL = Mapper<countryAll>().map(JSONString:jsonStr! as String)
        }

        registerOfCells(cells: [NSStringFromClass(PersonalCenterCell.self) as NSString])
        self.tableView.reloadData()
        // Do any additional setup after loading the view.
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var arry = [countryItem]()
        switch indexPath.section {
        case 0:
            arry = (dataALL?.Hot)!
        case 1:
            arry = (dataALL?.A)!
        case 2:
            arry = (dataALL?.B)!
        case 3:
            arry = (dataALL?.C)!
        case 4:
            arry = (dataALL?.D)!
        case 5:
            arry = (dataALL?.E)!
        case 6:
            arry = (dataALL?.F)!
        case 7:
            arry = (dataALL?.G)!
        case 8:
            arry = (dataALL?.H)!
        case 9:
            arry = (dataALL?.I)!
        case 10:
            arry = (dataALL?.J)!
        case 11:
            arry = (dataALL?.K)!
        case 12:
            arry = (dataALL?.L)!
        case 13:
            arry = (dataALL?.M)!
        case 14:
            arry = (dataALL?.N)!
        case 15:
            arry = (dataALL?.O)!
        case 16:
            arry = (dataALL?.P)!
        case 17:
            arry = (dataALL?.Q)!
        case 18:
            arry = (dataALL?.R)!
        case 19:
            arry = (dataALL?.S)!
        case 20:
            arry = (dataALL?.T)!
        case 21:
            arry = (dataALL?.U)!
        case 22:
            arry = (dataALL?.W)!
        case 23:
            arry = (dataALL?.V)!
        case 24:
            arry = (dataALL?.Y)!
        case 25:
            arry = (dataALL?.Z)!
        default:
            break
        }
        let item :countryItem = arry[indexPath.row]
        if let _ = blockproerty{
            blockproerty(item)
        }
        self.navigationController?.popViewController(animated: true)
    }
    func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        tableView.scrollToRow(at: IndexPath.init(row: 0, section: index), at: .top, animated: true)
        return index
    }
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return ["Hot","A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","W","V","Y","Z"]
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let arry = ["Hot","A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","W","V","Y","Z"]
        return arry[section]
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 26
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return (dataALL?.Hot.count)!
        case 1:
            return (dataALL?.A.count)!
        case 2:
            return (dataALL?.B.count)!
        case 3:
            return (dataALL?.C.count)!
        case 4:
            return (dataALL?.D.count)!
        case 5:
            return (dataALL?.E.count)!
        case 6:
            return (dataALL?.F.count)!
        case 7:
            return (dataALL?.G.count)!
        case 8:
            return (dataALL?.H.count)!
        case 9:
            return (dataALL?.I.count)!
        case 10:
            return (dataALL?.J.count)!
        case 11:
            return (dataALL?.K.count)!
        case 12:
            return (dataALL?.L.count)!
        case 13:
            return (dataALL?.M.count)!
        case 14:
            return (dataALL?.N.count)!
        case 15:
            return (dataALL?.O.count)!
        case 16:
            return (dataALL?.P.count)!
        case 17:
            return (dataALL?.Q.count)!
        case 18:
            return (dataALL?.R.count)!
        case 19:
            return (dataALL?.S.count)!
        case 20:
            return (dataALL?.T.count)!
        case 21:
            return (dataALL?.U.count)!
        case 22:
            return (dataALL?.W.count)!
        case 23:
            return (dataALL?.V.count)!
        case 24:
            return (dataALL?.Y.count)!
        case 25:
            return (dataALL?.Z.count)!
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: iderntify, for: indexPath)
        
        var arry = [countryItem]()
        switch indexPath.section {
        case 0:
            arry = (dataALL?.Hot)!
        case 1:
            arry = (dataALL?.A)!
        case 2:
            arry = (dataALL?.B)!
        case 3:
            arry = (dataALL?.C)!
        case 4:
            arry = (dataALL?.D)!
        case 5:
            arry = (dataALL?.E)!
        case 6:
            arry = (dataALL?.F)!
        case 7:
            arry = (dataALL?.G)!
        case 8:
            arry = (dataALL?.H)!
        case 9:
            arry = (dataALL?.I)!
        case 10:
            arry = (dataALL?.J)!
        case 11:
            arry = (dataALL?.K)!
        case 12:
            arry = (dataALL?.L)!
        case 13:
            arry = (dataALL?.M)!
        case 14:
            arry = (dataALL?.N)!
        case 15:
            arry = (dataALL?.O)!
        case 16:
            arry = (dataALL?.P)!
        case 17:
            arry = (dataALL?.Q)!
        case 18:
            arry = (dataALL?.R)!
        case 19:
            arry = (dataALL?.S)!
        case 20:
            arry = (dataALL?.T)!
        case 21:
            arry = (dataALL?.U)!
        case 22:
            arry = (dataALL?.W)!
        case 23:
            arry = (dataALL?.V)!
        case 24:
            arry = (dataALL?.Y)!
        case 25:
            arry = (dataALL?.Z)!
        default:
            break
        }
        let item :countryItem = arry[indexPath.row]
        if type == choosecityVctype.county.rawValue {
            cell.textLabel?.text = item.countryName
        } else {
            cell.textLabel?.text = item.countryName! + "(+" + item.areaCode! + ")"
        }
        return cell
    }
}
