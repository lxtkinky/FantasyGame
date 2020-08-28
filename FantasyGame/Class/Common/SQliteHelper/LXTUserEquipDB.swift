//
//  LXTUserEquipDB.swift
//  FantasyGame
//
//  Created by ULDD on 2020/8/10.
//  Copyright © 2020 LXT. All rights reserved.
//

import UIKit
import SQLite

class LXTUserEquipDB: NSObject {
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
            print("创建装备表失败：\(error)")
        }
    }
    
//    class func lxt_getAllUserEquip() -> Array<LXTUserEquipModel>{
//        let userEquipTable = Table("user_equip")
//        let userEquipID = Expression<Int>("userEquipID")
//        let heroID = Expression<Int>("heroID")
//        let relationEquipID = Expression<Int>("equipID")
//        let strongLevel = Expression<Int>("strongLevel")
//
//        let equipTable = Table("equip")
//        let equipID = Expression<Int>("id")
//        let equipName = Expression<String>("name")
//        let level = Expression<Int>("level")
//        let attack = Expression<Int>("attack")
//        let magic = Expression<Int>("magic")
//        let enhance = Expression<Int>("enhance")
//        let reduce = Expression<Int>("reduce")
//        let equipType = Expression<Int>("type")
//        let maxStrongLevel = Expression<Int>("maxStrongLevel")
//        let costStrongGold = Expression<Int>("costStrongGold")
//        let costStrongStone = Expression<Int>("costStrongStone")
//        let goldPrice = Expression<Int>("goldPrice")
//        let ybPrice = Expression<Int>("ybPrice")
//        let equipFilter = userEquipTable.filter(userEquipTable[type] == GoodsType.equip.rawValue)
//    }
    
    class func lxt_saveUserEquip(userEquip : LXTUserEquipModel) -> Int{
        let table = Table("user_equip")
        do {
            let heroID = Expression<Int>("heroID")
            let userEquipID = Expression<Int>("userEquipID")
            let equipID = Expression<Int>("equipID")
            let strongLevel = Expression<Int>("strongLevel")
            let insert = table.insert(heroID <- userEquip.heroID,
                                      equipID <- userEquip.equipID,
                                      strongLevel <- userEquip.strongLevel)
            let rowid = try db!.run(insert)

            let rowidExpression = Expression<Int>("rowid")
            let filter2 = table.filter(table[rowidExpression] == Int(rowid)).select(userEquipID)
            var user_equip_id = 0
            for item in try db!.prepare(filter2) {
                user_equip_id = item[userEquipID]
                print("user_equip_id = \(user_equip_id)")
            }
            return Int(rowid)
        } catch {
            
        }
        return 0
    }
    
    class func lxt_updateUserEquip(userEquip : LXTUserEquipModel) -> Int{
        let table = Table("user_equip")
        do {
            let heroID = Expression<Int>("heroID")
            let userEquipID = Expression<Int>("userEquipID")
            let equipID = Expression<Int>("equipID")
            let strongLevel = Expression<Int>("strongLevel")
            let filter = table.filter(userEquipID == userEquip.userEquipID)
            let update = filter.update(heroID <- userEquip.heroID,
                                      equipID <- userEquip.equipID,
                                      strongLevel <- userEquip.strongLevel)
            let rowid = try db!.run(update)
            return Int(rowid)
        } catch {
            
        }
        return 0
    }
    
    class func lxt_updateWithEquip(model : LXTEquipModel) -> Int{
        let table = Table("user_equip")
        do {
            let heroID = Expression<Int>("heroID")
            let userEquipID = Expression<Int>("userEquipID")
//            let equipID = Expression<Int>("equipID")
            let strongLevel = Expression<Int>("strongLevel")
            let filter = table.filter(userEquipID == model.userEquipID)
            let update = filter.update(heroID <- model.heroID,
//                                      equipID <- model.id,
                                      strongLevel <- model.strongLevel)
            let rowid = try db!.run(update)
            return Int(rowid)
        } catch {
            
        }
        return 0
    }
}
