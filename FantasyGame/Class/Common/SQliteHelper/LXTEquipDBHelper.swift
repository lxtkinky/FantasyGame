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
//var speed = 0
//var hp = 0
//var mp = 0
//var defense = 0
//var magicDefense = 0
//var doubleHit = 0
//var hpRecovery = 0
//var mpRecovery = 0

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
        let speed = Expression<Int>("speed")
        let hp = Expression<Int>("hp")
        let mp = Expression<Int>("mp")
        let defense = Expression<Int>("defense")
        let magicDefense = Expression<Int>("magicDefense")
        let doubleHit = Expression<Int>("doubleHit")
        let hpRecovery = Expression<Int>("hpRecovery")
        let mpRecovery = Expression<Int>("mpRecovery")
        let sundriesType = Expression<Int>("sundriesType")
        let buyType = Expression<Int>("buyType")
        let priceCount = Expression<Int>("priceCount")
        
        do {
//            try db!.run(table.delete())
            try db!.run(table.create(temporary: false, ifNotExists: true, withoutRowid: false, block: { (builder) in
                builder.column(id, unique: true)
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
                builder.column(speed, defaultValue: 0)
                builder.column(hp, defaultValue: 0)
                builder.column(mp, defaultValue: 0)
                builder.column(defense, defaultValue: 0)
                builder.column(magicDefense, defaultValue: 0)
                builder.column(doubleHit, defaultValue: 0)
                builder.column(hpRecovery, defaultValue: 0)
                builder.column(mpRecovery, defaultValue: 0)
                builder.column(sundriesType, defaultValue: 0)
                builder.column(buyType, defaultValue: 1)
                builder.column(priceCount, defaultValue: 0)
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
        let speed = Expression<Int>("speed")
        let hp = Expression<Int>("hp")
        let mp = Expression<Int>("mp")
        let defense = Expression<Int>("defense")
        let magicDefense = Expression<Int>("magicDefense")
        let doubleHit = Expression<Int>("doubleHit")
        let hpRecovery = Expression<Int>("hpRecovery")
        let mpRecovery = Expression<Int>("mpRecovery")
        let sundriesType = Expression<Int>("sundriesType")
        let buyType = Expression<Int>("buyType")
        let priceCount = Expression<Int>("priceCount")
        
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
                model.speed = item[speed]
                model.hp = item[hp]
                model.mp = item[mp]
                model.hpRecovery = item[hpRecovery]
                model.mpRecovery = item[mpRecovery]
                model.defense = item[defense]
                model.magicDefense = item[magicDefense]
                model.doubleHit = item[doubleHit]
                model.sundriesType = SundriesType(rawValue: item[sundriesType]) ?? SundriesType.none
                model.buyType = item[buyType]
                model.priceCount = item[priceCount]
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
        let speed = Expression<Int>("speed")
        let hp = Expression<Int>("hp")
        let mp = Expression<Int>("mp")
        let defense = Expression<Int>("defense")
        let magicDefense = Expression<Int>("magicDefense")
        let doubleHit = Expression<Int>("doubleHit")
        let hpRecovery = Expression<Int>("hpRecovery")
        let mpRecovery = Expression<Int>("mpRecovery")
        let sundriesType = Expression<Int>("sundriesType")
        let buyType = Expression<Int>("buyType")
        let priceCount = Expression<Int>("priceCount")
        
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
                                           costStrongStone <- equip.costStrongStone,
                                           name <- equip.name,
                                           goldPrice <- equip.goldPrice,
                                           ybPrice <- equip.ybPrice,
                                           speed <- equip.speed,
                                           hp <- equip.hp,
                                           mp <- equip.mp,
                                           hpRecovery <- equip.hpRecovery,
                                           mpRecovery <- equip.mpRecovery,
                                           defense <- equip.defense,
                                           magicDefense <- equip.magicDefense,
                                           doubleHit <- equip.doubleHit,
                                           sundriesType <- equip.sundriesType.rawValue,
                                           buyType <- equip.buyType,
                                           priceCount <- equip.priceCount)
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
                                          ybPrice <- equip.ybPrice,
                                          speed <- equip.speed,
                                          hp <- equip.hp,
                                          mp <- equip.mp,
                                          hpRecovery <- equip.hpRecovery,
                                          mpRecovery <- equip.mpRecovery,
                                          defense <- equip.defense,
                                          magicDefense <- equip.magicDefense,
                                          doubleHit <- equip.doubleHit,
                                          sundriesType <- equip.sundriesType.rawValue,
                                          buyType <- equip.buyType,
                                          priceCount <- equip.priceCount)
                let _ = try db!.run(insert)
            }
        } catch {
            print(error)
        }
        
    }
    
    
    class func lxt_initEquip(){
        let table = Table("equip")
        do {
            let count =  try db!.scalar(table.count)
            if count == 0 {
                let modelArray = LXTReadFileHelper.lxt_loadEquipArray()
                for item in modelArray {
                    self.lxt_saveEquip(equip: item)
                }
            }
        } catch {
            print("初始化装备异常：\(error)")
        }
    }
}
