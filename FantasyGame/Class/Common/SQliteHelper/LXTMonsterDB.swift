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
            let table = Table("user_equip")
            let userEquipID = Expression<Int>("userEquipID")
            let heroID = Expression<Int>("heroID")
            let equipID = Expression<Int>("equipID")
            let strongLevel = Expression<Int>("strongLevel")
            
            do {
                try db!.run(table.create(temporary: false, ifNotExists: true, withoutRowid: false, block: { (builder) in
                    builder.column(userEquipID, primaryKey: .autoincrement)
                    builder.column(heroID, defaultValue: 0)
    //                builder.column(userID, defaultValue: 0)
                    builder.column(equipID, defaultValue: 0)
                    builder.column(strongLevel, defaultValue: 1)
                }))
            } catch {
                print("创建表失败：\(error)")
            }
        }
}
