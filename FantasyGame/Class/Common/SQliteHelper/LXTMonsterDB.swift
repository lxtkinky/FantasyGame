//
//  LXTMonsterDB.swift
//  FantasyGame
//
//  Created by ULDD on 2020/8/31.
//  Copyright © 2020 LXT. All rights reserved.
//

import UIKit
import SQLite
class LXTMonsterDB: NSObject {
    class func lxt_createTable() {
        let table = Table("monster")
        let id = Expression<Int>("id")
        let mapNum = Expression<Int>("mapNum")
        let name = Expression<String>("name")
        let level = Expression<Int>("level")
        
        do {
            try db!.run(table.create(temporary: false, ifNotExists: true, withoutRowid: false, block: { (builder) in
                builder.column(id, primaryKey: .autoincrement)
                builder.column(mapNum, defaultValue: 0)
                builder.column(name, defaultValue: "未知")
                builder.column(level, defaultValue: 1)
            }))
        } catch {
            print("创建表失败：\(error)")
        }
    }
}
