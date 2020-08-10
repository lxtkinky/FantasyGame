//
//  LXTHeroTableHelper.swift
//  FantasyGame
//
//  Created by ULDD on 2020/7/29.
//  Copyright © 2020 LXT. All rights reserved.
//

import UIKit
import SQLite

//var hp = 0
//var mp = 0
//var currentHP = 0
//var currentMP = 0
//var attack = 0
//var level = 1
//var maxExp = 0
//var currentExp = 0

//var type = 1      1,英雄 2,地图怪物
//var enhance = 0         //增加输出伤害
//var reduce = 0          //受到伤害减免
//var starLevel = 1
//var magic = 0           //法力
//var criticalChance = 0        //暴击几率
//var criticalDamage = 150   //暴伤增强
//var resistCriticalChance = 0    //抗暴击几率
//var resistCriticalDamage = 0    //暴击伤害减免
//var suckBlood = 0
//var backInjury = 0
class LXTHeroTableHelper: NSObject {
    class func lxt_createTable(){
        let heroTable = Table("hero")
        let id = Expression<Int>("id")
        let heroID = Expression<Int>("heroID")
        let type = Expression<Int>("type")
        let name = Expression<String>("name")
        let hp = Expression<Int>("hp")
        let mp = Expression<Int>("mp")
        let attack = Expression<Int>("attack")
        let level = Expression<Int>("level")
        let maxExp = Expression<Int>("maxExp")
        let currentExp = Expression<Int>("currentExp")
        let desc = Expression<String>("desc")
        let enhance = Expression<Int>("enhance")
        let reduce = Expression<Int>("reduce")
        let starLevel = Expression<Int>("starLevel")
        let magic = Expression<Int>("magic")
        let criticalChance = Expression<Int>("criticalChance")
        let criticalDamage = Expression<Int>("criticalDamage")
        let resistCriticalDamage = Expression<Int>("resistCriticalDamage")
        let resistCriticalChance = Expression<Int>("resistCriticalChance")
        let suckBlood = Expression<Int>("suckBlood")
        let backInjury = Expression<Int>("backInjury")
        
        do {
            try db!.run(heroTable.create(temporary: false, ifNotExists: true, withoutRowid: false, block: { (builder) in
                builder.column(id, primaryKey: .autoincrement)
                builder.column(heroID, unique: true)
                builder.column(name, defaultValue: "")
                builder.column(hp, defaultValue: 0)
                builder.column(mp, defaultValue: 0)
                builder.column(type, defaultValue: 1)
                builder.column(attack, defaultValue: 0)
                builder.column(level, defaultValue: 0)
                builder.column(maxExp, defaultValue: 0)
                builder.column(currentExp, defaultValue: 0)
                builder.column(desc, defaultValue: "")
                builder.column(enhance, defaultValue: 0)
                builder.column(reduce, defaultValue: 0)
                builder.column(starLevel, defaultValue: 1)
                builder.column(magic, defaultValue: 0)
                builder.column(criticalChance, defaultValue: 0)
                builder.column(criticalDamage, defaultValue: 0)
                builder.column(resistCriticalChance, defaultValue: 0)
                builder.column(resistCriticalDamage, defaultValue: 0)
                builder.column(suckBlood, defaultValue: 0)
                builder.column(backInjury, defaultValue: 0)
            }))
        } catch {
            print(error)
        }
    }
    
    class func lxt_saveHero(hero : LXTHeroModel){
        let heroTable = Table("hero")
//        let id = Expression<Int>("id")
        let heroID = Expression<Int>("heroID")
        let name = Expression<String>("name")
        let hp = Expression<Int>("hp")
        let mp = Expression<Int>("mp")
        let attack = Expression<Int>("attack")
        let level = Expression<Int>("level")
        let maxExp = Expression<Int>("maxExp")
        let currentExp = Expression<Int>("currentExp")
        let desc = Expression<String>("desc")
        let enhance = Expression<Int>("enhance")
        let reduce = Expression<Int>("reduce")
        let starLevel = Expression<Int>("starLevel")
        let magic = Expression<Int>("magic")
        let criticalChance = Expression<Int>("criticalChance")
        let criticalDamage = Expression<Int>("criticalDamage")
        let resistCriticalDamage = Expression<Int>("resistCriticalDamage")
        let resistCriticalChance = Expression<Int>("resistCriticalChance")
        let suckBlood = Expression<Int>("suckBlood")
        let backInjury = Expression<Int>("backInjury")
        let type = Expression<Int>("type")
        
        do {
            let filter = heroTable.filter(heroID == hero.heroID)
//            let items = try db!.prepare(filter)
            let count = try db?.scalar(filter.count)
//            for _ in items {
//                count += 1
//            }
            if count! > 0 {
                let update = filter.update(name <- hero.name,
                                               hp <- hero.hp,
                                               mp <- hero.mp,
                                               attack <- hero.attack,
                                               level <- hero.level,
                                               maxExp <- hero.maxExp,
                                               currentExp <- hero.currentExp,
                                               desc <- hero.desc,
                                               enhance <- hero.enhance,
                                               reduce <- hero.reduce,
                                               starLevel <- hero.starLevel,
                                               magic <- hero.magic,
                                               criticalChance <- hero.criticalChance,
                                               criticalDamage <- hero.criticalDamage,
                                               resistCriticalChance <- hero.resistCriticalChance,
                                               resistCriticalDamage <- hero.resistCriticalDamage,
                                               suckBlood <- hero.suckBlood,
                                               backInjury <- hero.backInjury,
                                               type <- hero.type
                )
                let rowid = try db!.run(update)
                if rowid > 0 {
//                    print("更新成功")
                }else{
                    print("更新失败")
                }
            }else{
                let insert = heroTable.insert(heroID <- hero.heroID,
                                              name <- hero.name,
                                              hp <- hero.hp,
                                              mp <- hero.mp,
                                              attack <- hero.attack,
                                              level <- hero.level,
                                              maxExp <- hero.maxExp,
                                              currentExp <- hero.currentExp,
                                              desc <- hero.desc,
                                              enhance <- hero.enhance,
                                              reduce <- hero.reduce,
                                              starLevel <- hero.starLevel,
                                              magic <- hero.magic,
                                              criticalChance <- hero.criticalChance,
                                              criticalDamage <- hero.criticalDamage,
                                              resistCriticalChance <- hero.resistCriticalChance,
                                              resistCriticalDamage <- hero.resistCriticalDamage,
                                              suckBlood <- hero.suckBlood,
                                              backInjury <- hero.backInjury,
                                              type <- hero.type
                                              )
                let rowid = try db!.run(insert)
                if rowid > 0 {
                    print("插入成功")
                }else{
                    print("插入失败")
                }
            }
        } catch  {
            print(error)
        }
        
    }
    
    class func lxt_queryAllHero() -> Array<LXTHeroModel>{
        var heroArray = Array<LXTHeroModel>()
        let heroTable = Table("hero")
        let id = Expression<Int>("id")
        let heroID = Expression<Int>("heroID")
        let name = Expression<String>("name")
        let hp = Expression<Int>("hp")
        let mp = Expression<Int>("mp")
        let attack = Expression<Int>("attack")
        let level = Expression<Int>("level")
        let maxExp = Expression<Int>("maxExp")
        let currentExp = Expression<Int>("currentExp")
        let desc = Expression<String>("desc")
        let enhance = Expression<Int>("enhance")
        let reduce = Expression<Int>("reduce")
        let starLevel = Expression<Int>("starLevel")
        let magic = Expression<Int>("magic")
        let criticalChance = Expression<Int>("criticalChance")
        let criticalDamage = Expression<Int>("criticalDamage")
        let resistCriticalDamage = Expression<Int>("resistCriticalDamage")
        let resistCriticalChance = Expression<Int>("resistCriticalChance")
        let suckBlood = Expression<Int>("suckBlood")
        let backInjury = Expression<Int>("backInjury")
        let type = Expression<Int>("type")
        
        do {
            for hero in try db!.prepare(heroTable) {
                let model = LXTHeroModel()
                model.id = hero[id]
                model.heroID = hero[heroID]
                model.name = hero[name]
                model.hp = hero[hp]
                model.currentHP = hero[hp]
                model.currentMP = hero[mp]
                model.mp = hero[mp]
                model.attack = hero[attack]
                model.level = hero[level]
                model.maxExp = hero[maxExp]
                model.currentExp = hero[currentExp]
                model.desc = hero[desc]
                model.enhance = hero[enhance]
                model.reduce = hero[reduce]
                model.starLevel = hero[starLevel]
                model.magic = hero[magic]
                model.criticalDamage = hero[criticalDamage]
                model.criticalChance = hero[criticalChance]
                model.resistCriticalDamage = hero[resistCriticalDamage]
                model.resistCriticalChance = hero[resistCriticalChance]
                model.suckBlood = hero[suckBlood]
                model.backInjury = hero[backInjury]
                model.type = hero[type]
                heroArray.append(model)
            }
        } catch {
            print(error)
        }
        return heroArray
    }
}
