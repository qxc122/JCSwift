//
//  DBGlobalParameter.swift
//  JCSwift
//
//  Created by MiNi on 2018/5/22.
//  Copyright © 2018年 wdada0620@gmail.com. All rights reserved.
//

import Foundation
import SQLite

class DBGlobalParameter{
    private var db: Connection!
    private var data : GlobalParameter?
    
    /// 使用全局变量创建单例
    static let shareInstance = DBGlobalParameter()
    private  init(){
        let error = connectDatabase()
        guard error == nil else {
            return
        }
        queryTableLamp()
    }
    
    // 读取唯一的jcPassengerUrl
    func getdata() -> GlobalParameter? {
        if (self.data != nil) {
            return data
        } else {
            queryTableLamp()
            return data
        }
    }
    // 更新唯一的jcPassengerUrl
    func setdata(data:GlobalParameter)  {
        let error =  tableLampUpdateItem(id : 1, jcPassengerUrl: (data.jcPassengerUrl?.absoluteString)!, jcFilghtUrl: (data.jcFilghtUrl?.absoluteString)!,jcMyTripUrl: (data.jcMyTripUrl?.absoluteString)!, jcContactUrl: (data.jcContactUrl?.absoluteString)!, jcAboutUrl: (data.jcAboutUrl?.absoluteString)!, jcGccUrl: (data.jcGccUrl?.absoluteString)!, jcPrivacyPolicyUrl: (data.jcPrivacyPolicyUrl?.absoluteString)!)
        guard (error == nil) else {
            return
        }
        self.data = data
    }
    
    // 与数据库建立连接
    private func connectDatabase(filePath: String = "/Documents") -> Error? {
        let sqlFilePath = NSHomeDirectory() + filePath + "/db.sqlite.jcFilghtUrlModel"
        do { // 与数据库建立连接
            db = try Connection(sqlFilePath)
            print("jcFilghtUrlModel 与数据库建立连接 成功")
            return tableLampCreate()
        } catch {
            print("jcFilghtUrlModel 与数据库建立连接 失败：\(error)")
            return error
        }
    }
    
    // ===================================== 灯光 =====================================
    private let TABLE_LAMP = Table("table_jcFilghtUrlModel_lamp") // 表名称
    private let TABLE_LAMP_ID = Expression<Int64>("lamp_id") // 列表项及项类型
    private let TABLE_LAMP_jcPassengerUrl = Expression<String>("lamp_jcPassengerUrl") // 列表项及项类型
    private let TABLE_LAMP_jcFilghtUrl = Expression<String>("lamp_jcFilghtUrl")
    private let TABLE_LAMP_jcMyTripUrl = Expression<String>("lamp_jcMyTripUrl") // 列表项及项类型
    private let TABLE_LAMP_jcContactUrl = Expression<String>("lamp_jcContactUrl")
    
    private let TABLE_LAMP_jcAboutUrl = Expression<String>("lamp_jcAboutUrl")
    private let TABLE_LAMP_jcGccUrl = Expression<String>("lamp_jcGccUrl") // 列表项及项类型
    private let TABLE_LAMP_jcPrivacyPolicyUrl = Expression<String>("lamp_jcPrivacyPolicyUrl")
    

    
    // 建表
    private func tableLampCreate() -> Error? {
        do { // 创建表TABLE_LAMP
            try db.run(TABLE_LAMP.create(ifNotExists: true) { table in
                table.column(TABLE_LAMP_ID, primaryKey: .autoincrement) // 主键自加且不为空
                table.column(TABLE_LAMP_jcPassengerUrl)
                table.column(TABLE_LAMP_jcFilghtUrl)
                table.column(TABLE_LAMP_jcMyTripUrl)
                table.column(TABLE_LAMP_jcContactUrl)
                
                table.column(TABLE_LAMP_jcAboutUrl)
                table.column(TABLE_LAMP_jcGccUrl)
                table.column(TABLE_LAMP_jcPrivacyPolicyUrl)
            })
            print("创建表 jcFilghtUrlModel TABLE_LAMP 成功")
            return nil
        } catch {
            print("创建表 jcFilghtUrlModel TABLE_LAMP 失败：\(error)")
            return error
        }
    }

    // 插入
    private func tableLampInsertItem(jcPassengerUrl: String, jcFilghtUrl: String,jcMyTripUrl: String, jcContactUrl: String, jcAboutUrl: String,jcGccUrl: String, jcPrivacyPolicyUrl: String) -> Error? {
        let insert = TABLE_LAMP.insert(TABLE_LAMP_jcPassengerUrl <- jcPassengerUrl, TABLE_LAMP_jcFilghtUrl <- jcFilghtUrl,TABLE_LAMP_jcMyTripUrl <- jcMyTripUrl, TABLE_LAMP_jcContactUrl <- jcContactUrl, TABLE_LAMP_jcAboutUrl <- jcAboutUrl, TABLE_LAMP_jcGccUrl <- jcGccUrl, TABLE_LAMP_jcPrivacyPolicyUrl <- jcPrivacyPolicyUrl)
        do {
            let rowid = try db.run(insert)
            print("jcFilghtUrlModel 插入数据成功 id: \(rowid)")
            return nil
        } catch {
            print("jcFilghtUrlModel 插入数据失败: \(error)")
            return error
        }
    }

    // 遍历
    private func queryTableLamp() -> Void {
        do {
            let items = try db.prepare(TABLE_LAMP)
            for item in items {
                let data = GlobalParameter.init(jcPassengerUrl: item[TABLE_LAMP_jcPassengerUrl], jcFilghtUrl: item[TABLE_LAMP_jcFilghtUrl], jcMyTripUrl: item[TABLE_LAMP_jcMyTripUrl], jcContactUrl: item[TABLE_LAMP_jcContactUrl], jcAboutUrl: item[TABLE_LAMP_jcAboutUrl], jcGccUrl: item[TABLE_LAMP_jcGccUrl], jcPrivacyPolicyUrl: item[TABLE_LAMP_jcPrivacyPolicyUrl])
                self.data = data
                print("jcFilghtUrlModel 遍历 ———— id: \(item[TABLE_LAMP_ID]), jcPassengerUrl: \(item[TABLE_LAMP_jcPassengerUrl]), jcFilghtUrl: \(item[TABLE_LAMP_jcFilghtUrl])")
                return
            }
        } catch  {
            print("jcFilghtUrlModel 遍历失败: \(error)")
        }
    }

    private func tableLampUpdateItem(id: Int64,jcPassengerUrl: String, jcFilghtUrl: String,jcMyTripUrl: String, jcContactUrl: String,jcAboutUrl: String,jcGccUrl: String, jcPrivacyPolicyUrl: String) -> Error? {
        let item = TABLE_LAMP.filter(TABLE_LAMP_ID == id)
        do {
            if try db.run(item.update(TABLE_LAMP_jcPassengerUrl <- jcPassengerUrl,TABLE_LAMP_jcFilghtUrl <- jcFilghtUrl,TABLE_LAMP_jcMyTripUrl <- jcMyTripUrl,TABLE_LAMP_jcContactUrl <- jcContactUrl,TABLE_LAMP_jcAboutUrl <- jcAboutUrl,TABLE_LAMP_jcGccUrl <- jcGccUrl,TABLE_LAMP_jcPrivacyPolicyUrl <- jcPrivacyPolicyUrl)) > 0 {
                print("jcFilghtUrlModel \(jcPassengerUrl)  \(jcFilghtUrl) 更新成功")
                return nil
            } else {
                return tableLampInsertItem(jcPassengerUrl: jcPassengerUrl, jcFilghtUrl: jcFilghtUrl,jcMyTripUrl: jcMyTripUrl, jcContactUrl: jcContactUrl, jcAboutUrl: jcAboutUrl,jcGccUrl: jcGccUrl, jcPrivacyPolicyUrl: jcPrivacyPolicyUrl)
            }
        } catch {
            print("jcFilghtUrlModel\(jcPassengerUrl) 更新失败：\(error)")
            return error
        }
    }
}
