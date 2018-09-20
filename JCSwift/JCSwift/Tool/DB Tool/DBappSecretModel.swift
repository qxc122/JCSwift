//
//  DBappSecetModel.swift
//  JCSwift
//
//  Created by MiNi on 2018/4/28.
//  Copyright © 2018年 wdada0620@gmail.com. All rights reserved.
//

import Foundation
import SQLite

class DBappSecretModel{
    private var db: Connection!
    private var data : appSecretModel?
    
    /// 使用全局变量创建单例
    static let shareInstance = DBappSecretModel()
    private  init(){
        let error = connectDatabase()
        guard error == nil else {
            return
        }
        queryTableLamp()
    }
    
    // 读取唯一的accessToken
    func getdata() -> appSecretModel? {
        if (self.data != nil) {
            return data
        } else {
            queryTableLamp()
            return data
        }
    }
    // 更新唯一的accessToken
    func setdata(data:appSecretModel)  {
        let error =  tableLampUpdateItem(id : 1, accessToken: data.accessToken!, expireTime: data.expireTime!,sessionKey: data.sessionKey!, sessionSecret: data.sessionSecret!)
        guard (error == nil) else {
            return
        }
        self.data = data
    }
    
    // 与数据库建立连接
    private func connectDatabase(filePath: String = "/Documents") -> Error? {
        let sqlFilePath = NSHomeDirectory() + filePath + "/db.sqlite.expireTimeModel"
        do { // 与数据库建立连接
            db = try Connection(sqlFilePath)
            print("expireTimeModel 与数据库建立连接 成功")
            return tableLampCreate()
        } catch {
            print("expireTimeModel 与数据库建立连接 失败：\(error)")
            return error
        }
    }

    // ===================================== 灯光 =====================================
    private let TABLE_LAMP = Table("table_expireTimeModel_lamp") // 表名称
    private let TABLE_LAMP_ID = Expression<Int64>("lamp_id") // 列表项及项类型
    private let TABLE_LAMP_accessToken = Expression<String>("lamp_accessToken") // 列表项及项类型
    private let TABLE_LAMP_expireTime = Expression<TimeInterval>("lamp_expireTime")
    private let TABLE_LAMP_sessionKey = Expression<String>("lamp_sessionKey") // 列表项及项类型
    private let TABLE_LAMP_sessionSecret = Expression<String>("lamp_sessionSecret")

    // 建表
    private func tableLampCreate() -> Error? {
        do { // 创建表TABLE_LAMP
            try db.run(TABLE_LAMP.create(ifNotExists: true) { table in
                table.column(TABLE_LAMP_ID, primaryKey: .autoincrement) // 主键自加且不为空
                table.column(TABLE_LAMP_accessToken)
                table.column(TABLE_LAMP_expireTime)
                table.column(TABLE_LAMP_sessionKey)
                table.column(TABLE_LAMP_sessionSecret)
            })
            print("创建表 expireTimeModel TABLE_LAMP 成功")
            return nil
        } catch {
            print("创建表 expireTimeModel TABLE_LAMP 失败：\(error)")
            return error
        }
    }
    
    // 插入
    private func tableLampInsertItem(accessToken: String, expireTime: TimeInterval,sessionKey: String, sessionSecret: String) -> Error? {
        let insert = TABLE_LAMP.insert(TABLE_LAMP_accessToken <- accessToken, TABLE_LAMP_expireTime <- expireTime,TABLE_LAMP_sessionKey <- sessionKey, TABLE_LAMP_sessionSecret <- sessionSecret)
        do {
            let rowid = try db.run(insert)
            print("expireTimeModel 插入数据成功 id: \(rowid)")
            return nil
        } catch {
            print("expireTimeModel 插入数据失败: \(error)")
            return error
        }
    }
    
    // 遍历
    private func queryTableLamp() -> Void {
        do {
            let items = try db.prepare(TABLE_LAMP)
            for item in items {
                let data = appSecretModel.init(accessToken: item[TABLE_LAMP_accessToken], expireTime: item[TABLE_LAMP_expireTime], sessionKey: item[TABLE_LAMP_sessionKey], sessionSecret: item[TABLE_LAMP_sessionSecret])
                self.data = data
                print("expireTimeModel 遍历 ———— id: \(item[TABLE_LAMP_ID]), accessToken: \(item[TABLE_LAMP_accessToken]), expireTime: \(item[TABLE_LAMP_expireTime])")
                return
            }
        } catch  {
            print("expireTimeModel 遍历失败: \(error)")
        }
    }

    private func tableLampUpdateItem(id: Int64,accessToken: String, expireTime: TimeInterval,sessionKey: String, sessionSecret: String) -> Error? {
        let item = TABLE_LAMP.filter(TABLE_LAMP_ID == id)
        do {
            if try db.run(item.update(TABLE_LAMP_accessToken <- accessToken,TABLE_LAMP_expireTime <- expireTime,TABLE_LAMP_sessionKey <- sessionKey,TABLE_LAMP_sessionSecret <- sessionSecret)) > 0 {
                print("expireTimeModel \(accessToken)  \(expireTime) 更新成功")
                return nil
            } else {
                return tableLampInsertItem(accessToken: accessToken, expireTime: expireTime,sessionKey: sessionKey, sessionSecret: sessionSecret)
            }
        } catch {
            print("expireTimeModel\(accessToken) 更新失败：\(error)")
            return error
        }
    }
}
