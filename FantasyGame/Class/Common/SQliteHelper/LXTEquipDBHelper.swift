//
//  LXTEquipDBHelper.swift
//  FantasyGame
//
//  Created by ULDD on 2020/8/3.
//  Copyright © 2020 LXT. All rights reserved.
//

import UIKit
import SQLite

//    var id = 0
//    var equipID = 0
//    var level = 0               //佩戴等级
//    var attack = 0
//    var magic = 0
//    var enhance = 0         //增加输出伤害
//    var reduce = 0          //受到伤害减免
//    var skill = LXTHeroSkillModel()

class LXTEquipDBHelper: NSObject {
    class func lxt_createTable(){
        let table = Table("equip")
        let id = Expression<Int>("id")
        let name = Expression<String>("name")
        let level = Expression<Int>("level")
        let attack = Expression<Int>("attack")
        let magic = Expression<Int>("magic")
        let enhance = Expression<Int>("enhance")
        let reduce = Expression<Int>("reduce")
        let skillID = Expression<Int>("skillID")
        let type = Expression<Int>("type")
        let maxStrongLevel = Expression<Int>("maxStrongLevel")
        let costStrongGold = Expression<Int>("costStrongGold")
        let costStrongStone = Expression<Int>("costStrongStone")
        let goldPrice = Expression<Int>("goldPrice")
        let ybPrice = Expression<Int>("ybPrice")
        
        do {
            try db!.run(table.create(temporary: false, ifNotExists: true, withoutRowid: false, block: { (builder) in
                builder.column(id, primaryKey: .autoincrement)
                builder.column(level, defaultValue: 1)
                builder.column(name, defaultValue: "未知装备")
                builder.column(attack, defaultValue: 0)
                builder.column(magic, defaultValue: 0)
                builder.column(enhance, defaultValue: 0)
                builder.column(reduce, defaultValue: 0)
                builder.column(skillID, defaultValue: 0)
                builder.column(type, defaultValue: 0)
                builder.column(maxStrongLevel, defaultValue: 0)
                builder.column(costStrongGold, defaultValue: 0)
                builder.column(costStrongStone, defaultValue: 0)
                builder.column(goldPrice, defaultValue: 0)
                builder.column(ybPrice, defaultValue: 0)
            }))
        } catch {
            print("创建装备表失败：\(error)")
        }
        
        self.lxt_initEquip()
    }
    
    class func lxt_queryAllEquip() -> Array<LXTEquipModel>{
        var equipArray = Array<LXTEquipModel>()
        let table = Table("equip")
        let id = Expression<Int>("id")
        let level = Expression<Int>("level")
        let attack = Expression<Int>("attack")
        let magic = Expression<Int>("magic")
        let enhance = Expression<Int>("enhance")
        let reduce = Expression<Int>("reduce")
//        let skillID = Expression<Int>("skillID")
        let type = Expression<Int>("type")
        let maxStrongLevel = Expression<Int>("maxStrongLevel")
        let costStrongGold = Expression<Int>("costStrongGold")
        let costStrongStone = Expression<Int>("costStrongStone")
        let goldPrice = Expression<Int>("goldPrice")
        let ybPrice = Expression<Int>("ybPrice")
        let name = Expression<String>("name")
        
        do {
            for item in try db!.prepare(table) {
                let model = LXTEquipModel()
                model.id = item[id]
                model.level = item[level]
                model.attack = item[attack]
                model.magic = item[magic]
                model.enhance = item[enhance]
                model.reduce = item[reduce]
//                model.skil
                model.type = item[type]
                model.maxStrongLevel = item[maxStrongLevel]
                model.costStrongStone = item[costStrongStone]
                model.costStrongGold = item[costStrongGold]
                model.name = item[name]
                model.goldPrice = item[goldPrice]
                model.ybPrice = item[ybPrice]
                equipArray.append(model)
            }
        } catch {
            
        }
        
        return equipArray
    }
    
    class func lxt_saveEquip(equip : LXTEquipModel){
        let table = Table("equip")
        let id = Expression<Int>("id")
        let level = Expression<Int>("level")
        let attack = Expression<Int>("attack")
        let magic = Expression<Int>("magic")
        let enhance = Expression<Int>("enhance")
        let reduce = Expression<Int>("reduce")
//        let skillID = Expression<Int>("skillID")
        let type = Expression<Int>("type")
        let maxStrongLevel = Expression<Int>("maxStrongLevel")
        let costStrongGold = Expression<Int>("costStrongGold")
        let costStrongStone = Expression<Int>("costStrongStone")
        let goldPrice = Expression<Int>("goldPrice")
        let ybPrice = Expression<Int>("ybPrice")
        let name = Expression<String>("name")
        do {
            let filter = table.filter(id == equip.id)
            let count = try db!.scalar(filter.count)
            if count > 0 {
                let update = filter.update(level <- equip.level,
                                           attack <- equip.attack,
                                           magic <- equip.magic,
                                           enhance <- equip.enhance,
                                           reduce <- equip.reduce,
                                           type <- equip.type,
                                           maxStrongLevel <- equip.maxStrongLevel,
                                           costStrongGold <- equip.costStrongGold,
                                           costStrongStone <- equip.costStrongStone)
                let _ = try db!.run(update)
            }else{
                let insert = table.insert(id <- equip.id,
                                          level <- equip.level,
                                          attack <- equip.attack,
                                          magic <- equip.magic,
                                          enhance <- equip.enhance,
                                          reduce <- equip.reduce,
                                          type <- equip.type,
                                          maxStrongLevel <- equip.maxStrongLevel,
                                          costStrongGold <- equip.costStrongGold,
                                          costStrongStone <- equip.costStrongStone,
                                          name <- equip.name,
                                          goldPrice <- equip.goldPrice,
                                          ybPrice <- equip.ybPrice)
                let _ = try db!.run(insert)
            }
        } catch {
            
        }
        
    }
    
    
    class func lxt_initEquip(){
        let equip = LXTEquipModel()
        equip.id = 1
        equip.name = "丈八蛇矛"
        equip.goldPrice = 100000
        equip.ybPrice = 0
        equip.type = 1
        equip.attack = 50
        equip.magic = 50
        equip.maxStrongLevel = 10
        equip.costStrongGold = 1000
        equip.costStrongStone = 1
        
        self.lxt_saveEquip(equip: equip)
    }
}
