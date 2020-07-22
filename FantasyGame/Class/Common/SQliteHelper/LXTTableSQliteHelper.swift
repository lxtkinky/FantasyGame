//
//  LXTTableSQliteHelper.swift
//  FantasyGame
//
//  Created by ULDD on 2020/7/20.
//  Copyright © 2020 LXT. All rights reserved.
//

import UIKit
import SQLite

class LXTTableSQliteHelper: NSObject {
    class func lxt_initTable() {
        
    }
    
    func lxt_createDBFile() -> Void {
//        let sqlitePath = documentPath! + "sqlite/db.sqlite3"
//        if !FileManager.default.fileExists(atPath: sqlitePath){
//            FileManager.default.createDirectory(atPath: documentPath! + "sqlite", withIntermediateDirectories: <#T##Bool#>, attributes: <#T##[FileAttributeKey : Any]?#>)
//        }
    }
    
//    //创建一个内存数据库
//    let db = try Connection()
//    如果要在temporary创建临时磁盘备份数据库,使用如下格式，数据库会在连接关闭后自动删除
//    let db = try Connection(.temporary)
    
//    语句是指对表中全部数据的balance字段进行 -10 操作
//    try db.run(users.update(balance-=10))
    
//    将查询结果封装成一个数组也很简单
//    let all = Array(try db.prepare(users))
    // SELECT * FROM "users"
    class func lxt_createTable(tableName : String) -> Void {
        do {
            //如果不存在的话创建数据库  如果要保存在自定义目录下面 需要先创建相应的目录
            let db = try Connection(documentPath! + "/db.sqlite3")
            db.busyTimeout = 5      //超时时间

            //繁忙处理
            db.busyHandler({ tries in
                if tries >= 3 {
                    return false
                }
                return true
            })
            
            
            let users = Table("users")
            let id = Expression<Int64>("id")
            let name = Expression<String>("userName")
            let account = Expression<String>("account")
            let pass = Expression<String>("pass")
            let email = Expression<String>("email")
            
            _ = try? db.run(users.create(block: { (table) in
                table.column(id, primaryKey: true)
                table.column(account, unique: true)
                table.column(name)
                table.column(pass)
                table.column(email, unique: true)
            }))
            
            let insert = users.insert(name <- "独自流浪", account <- "lixt", pass <- "123456", email <- "601866559@qq.com")
            _ = try? db.run(insert)
            for user in try! db.prepare(users) {
                print("用户名：\(user[name])，密码：\(user[pass])，账号：\(user[account])，邮箱：\(user[email])")
            }
        } catch  {
            print(error)
        }
//        if let db = try? Connection("path/to/db.sqlite3"){
//            let users = Table("users")
//            let id = Expression<Int64>("id")
//            let name = Expression<String>("userName")
//            let account = Expression<String>("account")
//            let pass = Expression<String>("pass")
//            let email = Expression<String>("email")
//
//            _ = try? db.run(users.create(block: { (table) in
//                table.column(id, primaryKey: true)
//                table.column(account, unique: true)
//                table.column(name)
//                table.column(pass)
//                table.column(email, unique: true)
//            }))
//
//            let insert = users.insert(name <- "独自流浪", account <- "lixt", pass <- "123456", email <- "601866559@qq.com")
//            _ = try? db.run(insert)
//            for user in try! db.prepare(users) {
//                print("用户名：\(user[name])，密码：\(user[pass])，账号：\(user[account])，邮箱：\(user[email])")
//            }
//        }
        
    }
}
