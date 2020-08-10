//
//  LXTTableSQliteHelper.swift
//  FantasyGame
//
//  Created by ULDD on 2020/7/20.
//  Copyright © 2020 LXT. All rights reserved.
//

import UIKit
import SQLite

var db = try? Connection(documentPath! + "/db.sqlite3")

class LXTTableSQliteHelper: NSObject {
    class func lxt_initTable() {
        if let _ = db {
            db!.busyTimeout = 5      //超时时间

            //繁忙处理
            db!.busyHandler({ tries in
                if tries >= 3 {
                    return false
                }
                return true
            })
            
            let userTableExists = LXTTableSQliteHelper().tableExists(tableName: "users")
            if !userTableExists {
                self.lxt_createTable(tableName: "users")
            }
            
            LXTSkillTableHelper.lxt_createSkillTable()
            let skillTableExists = LXTTableSQliteHelper().tableExists(tableName: "skill")
            if !skillTableExists {
//                LXTTableSQliteHelper().lxt_createSkillTable()
//                LXTSkillTableHelper.lxt_createSkillTable(<#T##self: LXTSkillTableHelper##LXTSkillTableHelper#>)
            }
            LXTSkillTableHelper.lxt_addSkillIDColumn()
            LXTSkillTableHelper.lxt_initSkill()
            
//            LXTTableSQliteHelper().lxt_createGoodsTable()
            LXTGoodsSQliteHelper().lxt_createGoodsTable()
            
            LXTHeroTableHelper.lxt_createTable()
            
            LXTHeroSkillDBHelper.lxt_createTable()
            
            LXTEquipDBHelper.lxt_createTable()
        }
    }
    
//    var name = ""
//    var count = 1
//    var lock = false
//    var useable = true
//    var type = 1
//    var desc = ""
//    var relationID = 0
    func lxt_createGoodsTable() -> Void {
        let goodTable = Table("goods")
        let id = Expression<Int64>("id")
        let name = Expression<String>("name")
        let count = Expression<Int64>("count")
        let lock = Expression<Bool>("lock")
        let useable = Expression<Bool>("useable")
        let type = Expression<Int64>("type")
        let desc = Expression<String>("desc")
        let relationID = Expression<Int64>("relationID")
        
        let _ = try? db!.run(goodTable.create(temporary: false, ifNotExists: true, withoutRowid: true, block: { (builder) in
            builder.column(id, primaryKey: true)
            builder.column(name, unique: true)
            builder.column(count)
            builder.column(lock)
            builder.column(useable)
            builder.column(type)
            builder.column(desc)
            builder.column(relationID)
        }))
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
    
    func tableExists(tableName : String) -> Bool{
        let result = try? db?.scalar("SELECT count(*) FROM sqlite_master WHERE type = 'table' AND name = '\(tableName)'")
        /*
         let result = try? db?.scalar("SELECT count(*) FROM sqlite_master WHERE type = 'table' AND name = ? ","tableName")
         */
        let count = Int.fromDatatypeValue(result as! Int64) //(刚学swift，我不晓得这里是不是这样用的，但测试没问题)
        print("Table \(tableName)  \(count == 1 ? "存在" : "不存在")")
        return count == 1 ? true : false
    }
    
    class func lxt_addColumn<V:Value>(table : Table, columnName : String, column : Expression<V?>, defaultValue : V) -> Void {
        let isExists = self.lxt_columnExists(columnName: columnName, table: table)
        if !isExists {
            do {
                let addColumn = table.addColumn(column, defaultValue: defaultValue)
                try db!.run(addColumn)
                print("新增列\(columnName)成功")
            } catch {
                print("新增列\(columnName)失败,error = \(error)")
            }
        }
    }
    
    class func lxt_columnExists(columnName : String, table : Table) -> Bool {
        var isExists = false
        do {
//            let goodTable = Table("goods")
            let expression = table.expression
            let columnNames = try db!.prepare(expression.template, expression.bindings).columnNames
            for name in columnNames {
                if name == columnName {
                    isExists = true
                    break
                }
            }
        } catch {
            
        }
        
        return isExists
    }
}
