//
//  DBdata.swift
//  JCSwift
//
//  Created by MiNi on 2018/4/27.
//  Copyright © 2018年 wdada0620@gmail.com. All rights reserved.
//

import Foundation
import SQLite

class DBappIdModel{
    private var db: Connection!
    private var data : appIdModel?
    
    /// 使用全局变量创建单例
    static let shareInstance = DBappIdModel()
    private  init(){
        let error = connectDatabase()
        guard error == nil else {
            return
        }
        queryTableLamp()
    }

    // 读取唯一的appid
    func getdata() -> appIdModel? {
        if (self.data != nil) {
            return data
        } else {
            queryTableLamp()
            return data
        }
    }
    // 更新唯一的appid
    func setdata(data:appIdModel)  {
        let error =  tableLampUpdateItem(id : 1, appId: data.appId!, appSecret: data.appSecret!)
        guard (error == nil) else {
            return
        }
        self.data = data
    }
    
    // 与数据库建立连接
    private func connectDatabase(filePath: String = "/Documents") -> Error? {
        let sqlFilePath = NSHomeDirectory() + filePath + "/db.sqlite.appIdModel"
        do { // 与数据库建立连接
            db = try Connection(sqlFilePath)
            print("appIdModel 与数据库建立连接 成功")
            return tableLampCreate()
        } catch {
            print("appIdModel 与数据库建立连接 失败：\(error)")
            return error
        }
    }

    // ===================================== 灯光 =====================================
    private let TABLE_LAMP = Table("table_appId_lamp") // 表名称
    private let TABLE_LAMP_ID = Expression<Int64>("lamp_id") // 列表项及项类型
    private let TABLE_LAMP_APPID = Expression<String>("lamp_appId") // 列表项及项类型
    private let TABLE_LAMP_APPSECRET = Expression<String>("lamp_appSecret")

    
    // 建表
    private func tableLampCreate() -> Error? {
        do { // 创建表TABLE_LAMP
            try db.run(TABLE_LAMP.create(ifNotExists: true) { table in
                table.column(TABLE_LAMP_ID, primaryKey: .autoincrement) // 主键自加且不为空
                table.column(TABLE_LAMP_APPID)
                table.column(TABLE_LAMP_APPSECRET)
            })
            print("创建表 appIdModel TABLE_LAMP 成功")
            return nil
        } catch {
            print("创建表 appIdModel TABLE_LAMP 失败：\(error)")
            return error
        }
    }
    
    // 插入
    private func tableLampInsertItem(appId: String, appSecret: String) -> Error? {
        let insert = TABLE_LAMP.insert(TABLE_LAMP_APPID <- appId, TABLE_LAMP_APPSECRET <- appSecret)
        do {
            let rowid = try db.run(insert)
            print("appIdModel 插入数据成功 id: \(rowid)")
            return nil
        } catch {
            print("appIdModel 插入数据失败: \(error)")
            return error
        }
    }
    
    // 遍历
    private func queryTableLamp() -> Void {
        do {
            let items = try db.prepare(TABLE_LAMP)
            for item in items {
                let data = appIdModel.init(appId: item[TABLE_LAMP_APPID], appSecret: item[TABLE_LAMP_APPSECRET])
                self.data = data
                print("appIdModel 遍历 ———— id: \(item[TABLE_LAMP_ID]), appId: \(item[TABLE_LAMP_APPID]), appSecret: \(item[TABLE_LAMP_APPSECRET])")
                return
            }
        } catch  {
            print("appIdModel 遍历失败: \(error)")
        }
    }
    
//    // 读取
//    private func readTableLampItem(id: Int64) -> AnySequence<Row>? {
//        do {
//            let items = try db.prepare(TABLE_LAMP.filter(TABLE_LAMP_ID == id))
////            for item in items {
////                print("\n读取（灯光）appId: \(item[TABLE_LAMP_APPID]), appSecret: \(item[TABLE_LAMP_APPSECRET])")
////            }
//            return items
//        } catch  {
//            return nil
//        }
//    }
//
    // 更新
    private func tableLampUpdateItem(id: Int64, appId: String, appSecret: String) -> Error? {
        let item = TABLE_LAMP.filter(TABLE_LAMP_ID == id)
        do {
            if try db.run(item.update(TABLE_LAMP_APPID <- appId,TABLE_LAMP_APPSECRET <- appSecret)) > 0 {
                print("appIdModel \(appId)  \(appSecret) 更新成功")
                return nil
            } else {
                return tableLampInsertItem(appId: appId, appSecret: appSecret)
            }
        } catch {
            print("appIdModel\(appId) 更新失败：\(error)")
            return error
        }
    }
    
    // 删除
    private func tableLampDeleteItem(id: Int64) -> Error? {
        let item = TABLE_LAMP.filter(TABLE_LAMP_ID == id)
        do {
            try db.run(item.delete())
            print("appIdModel\(id) 删除成功")
            return nil
        } catch {
            print("appIdModel\(id) 删除失败：\(error)")
            return error
        }
    }
}
