//
//  DBUserInfoModel.swift
//  JCSwift
//
//  Created by MiNi on 2018/5/2.
//  Copyright © 2018年 wdada0620@gmail.com. All rights reserved.
//

import Foundation
import SQLite

class DBUserInfoModel{
    private var db: Connection!
    private var data : UserInfoModel?
    
    /// 使用全局变量创建单例
    static let shareInstance = DBUserInfoModel()
    private  init(){
        let error = connectDatabase()
        guard error == nil else {
            return
        }
        queryTableLamp()
    }
    
    // 读取唯一的accessToken
    func getdata() -> UserInfoModel? {
        if (self.data != nil) {
            return data
        } else {
            queryTableLamp()
            return data
        }
    }

    // 更新唯一的accessToken
    func setdata(data:UserInfoModel)  {
        let error =  tableLampUpdateItem(id : 1, userId: data.userId, surname: data.surname,enName: data.enName, mobile: data.mobile,certType : data.certType, certNo: data.certNo, avatar: data.avatar,authenTicket: data.authenTicket,authenUserId: data.authenUserId, zone: data.zone,sex :data.sex, birthday: data.birthday, nationality: data.nationality)
        self.data = data
        guard (error == nil) else {
            return
        }
    }
    
    // 与数据库建立连接
    private func connectDatabase(filePath: String = "/Documents") -> Error? {
        let sqlFilePath = NSHomeDirectory() + filePath + "/db.sqlite.DBUserInfoModel"
        do { // 与数据库建立连接
            db = try Connection(sqlFilePath)
            print("DBUserInfoModel 与数据库建立连接 成功")
            return tableLampCreate()
        } catch {
            print("DBUserInfoModel 与数据库建立连接 失败：\(error)")
            return error
        }
    }
    
    // ===================================== 灯光 =====================================
    private let TABLE_LAMP = Table("table_DBUserInfoModel_lamp") // 表名称
    private let TABLE_LAMP_ID = Expression<Int64>("lamp_id") // 列表项及项类型
    private let TABLE_LAMP_userId = Expression<String>("lamp_userId")
    private let TABLE_LAMP_surname = Expression<String>("lamp_surname")
    private let TABLE_LAMP_enName = Expression<String>("lamp_enName")
    private let TABLE_LAMP_mobile = Expression<String>("lamp_mobile")
    private let TABLE_LAMP_certType = Expression<String>("lamp_certType")
    private let TABLE_LAMP_certNo = Expression<String>("lamp_certNo")
    private let TABLE_LAMP_avatar = Expression<String>("lamp_avatar")
    private let TABLE_LAMP_authenTicket = Expression<String>("lamp_authenTicket")
    private let TABLE_LAMP_authenUserId = Expression<String>("lamp_authenUserId")
    private let TABLE_LAMP_zone = Expression<String>("lamp_zone")
    private let TABLE_LAMP_sex = Expression<String>("lamp_sex")
    private let TABLE_LAMP_birthday = Expression<String>("lamp_birthday")
    private let TABLE_LAMP_nationality = Expression<String>("lamp_nationality")

    // 建表
    private func tableLampCreate() -> Error? {
        do { // 创建表TABLE_LAMP
            try db.run(TABLE_LAMP.create(ifNotExists: true) { table in
                table.column(TABLE_LAMP_ID, primaryKey: .autoincrement) // 主键自加且不为空
                table.column(TABLE_LAMP_userId)
                table.column(TABLE_LAMP_surname)
                table.column(TABLE_LAMP_enName)
                table.column(TABLE_LAMP_mobile)
                table.column(TABLE_LAMP_certType)
                table.column(TABLE_LAMP_certNo)
                table.column(TABLE_LAMP_avatar)
                table.column(TABLE_LAMP_authenTicket)
                table.column(TABLE_LAMP_authenUserId)
                table.column(TABLE_LAMP_zone)
                table.column(TABLE_LAMP_sex)
                table.column(TABLE_LAMP_birthday)
                table.column(TABLE_LAMP_nationality)
            })
            print("创建表 DBUserInfoModel TABLE_LAMP 成功")
            return nil
        } catch {
            print("创建表 DBUserInfoModel TABLE_LAMP 失败：\(error)")
            return error
        }
    }
    
    // 插入
    private func tableLampInsertItem(userId: String?="1", surname: String?="1",enName:String?="1", mobile:String?="1",certType :String?="1", certNo: String?="1", avatar: String?="1",authenTicket: String?="1", authenUserId: String?="1", zone: String?="1",sex :String?="1", birthday:String?="1", nationality: String?="1") -> Error? {
        var dbavatar = avatar
        if dbavatar == nil {
            dbavatar = ""
        }
        
        let insert = TABLE_LAMP.insert(TABLE_LAMP_userId <- userId!, TABLE_LAMP_surname <- surname!,TABLE_LAMP_enName <- enName!, TABLE_LAMP_mobile <- "1",TABLE_LAMP_certType <- "1", TABLE_LAMP_certNo <- "1",TABLE_LAMP_avatar <- dbavatar!, TABLE_LAMP_authenTicket <- authenTicket!,TABLE_LAMP_authenUserId <- authenUserId!,TABLE_LAMP_zone <- "1", TABLE_LAMP_sex <- "1",TABLE_LAMP_birthday <- "1", TABLE_LAMP_nationality <- "1")
        do {
            let rowid = try db.run(insert)
            print("DBUserInfoModel 插入数据成功 id: \(rowid)")
            return nil
        } catch {
            print("DBUserInfoModel 插入数据失败: \(error)")
            return error
        }
    }
    
    // 遍历
    private func queryTableLamp() -> Void {
        do {
            let items = try db.prepare(TABLE_LAMP)
            for item in items {
                let data = UserInfoModel.init(userId: item[TABLE_LAMP_userId], surname: item[TABLE_LAMP_surname], enName: item[TABLE_LAMP_enName], mobile: item[TABLE_LAMP_mobile], certType: item[TABLE_LAMP_certType], certNo: item[TABLE_LAMP_certNo], avatar: item[TABLE_LAMP_avatar], authenTicket: item[TABLE_LAMP_authenTicket], authenUserId: item[TABLE_LAMP_authenUserId], zone: item[TABLE_LAMP_zone], sex: item[TABLE_LAMP_sex], birthday: item[TABLE_LAMP_birthday], nationality: item[TABLE_LAMP_nationality])
                self.data = data
                print("DBUserInfoModel 遍历 ———— userId: \(item[TABLE_LAMP_userId]), surname: \(item[TABLE_LAMP_surname]), enName: \(item[TABLE_LAMP_enName])")
//                return
            }
        } catch  {
            print("DBUserInfoModel 遍历失败: \(error)")
        }
    }
    
    private func tableLampUpdateItem(id : Int64?=1, userId: String?="1", surname: String?="1",enName:String?="1", mobile:String?="1",certType :String?="1", certNo: String?="1", avatar: String?="1",authenTicket: String?="1", authenUserId: String?="1", zone: String?="1",sex :String?="1", birthday:String?="1", nationality: String?="1") -> Error? {
        
        
        var dbavatar = avatar
        if dbavatar == nil {
            dbavatar = ""
        }
        let item = TABLE_LAMP.filter(TABLE_LAMP_ID == id!)
        do {
            if try db.run(item.update(TABLE_LAMP_userId <- userId!,TABLE_LAMP_surname <- surname!,TABLE_LAMP_enName <- enName!,TABLE_LAMP_mobile <- "1",TABLE_LAMP_certType <- "1",TABLE_LAMP_certNo <- "1",TABLE_LAMP_avatar <- dbavatar!,TABLE_LAMP_authenTicket <- authenTicket!,TABLE_LAMP_authenUserId <- authenUserId!,TABLE_LAMP_zone <- "1",TABLE_LAMP_sex <- "1",TABLE_LAMP_birthday <- "1",TABLE_LAMP_nationality <- "1")) > 0 {
                print("DBUserInfoModel \(surname ?? "surname")  \(String(describing: userId)) 更新成功")
                return nil
            } else {
                return tableLampInsertItem(userId: userId, surname: surname, enName: enName, mobile: mobile, certType: certType, certNo: certNo, avatar: avatar, authenTicket: authenTicket, authenUserId: authenUserId, zone: zone, sex: sex, birthday: birthday, nationality: nationality)
            }
        } catch {
            print("DBUserInfoModel \(surname ?? "surname")  \(String(describing: userId)) 更新成功")
            return error
        }
    }
    
    // 删除
    public func tableLampDeleteItem() -> Error? {
        let item = TABLE_LAMP.filter(TABLE_LAMP_ID == 1)
        do {
            try db.run(item.delete())
            print("DBUserInfoModel\(1) 删除成功")
            self.data = nil
            return nil
        } catch {
            print("DBUserInfoModel\(1) 删除失败：\(error)")
            return error
        }
    }
}
