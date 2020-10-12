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
        let userID = Expression<Int>("userID")
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
        let mapLevel = Expression<Int>("mapLevel")
        
        do {
            try db!.run(heroTable.create(temporary: false, ifNotExists: true, withoutRowid: false, block: { (builder) in
                builder.column(id, primaryKey: .autoincrement)
                builder.column(heroID, defaultValue: 0)
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
                builder.column(mapLevel, defaultValue: 1)
                builder.column(userID, defaultValue: 0)
            }))
        } catch {
            print(error)
        }
        
//        let hero = LXTHeroModel()
//        hero.heroID = 1
//        hero.name = "主角"
//        LXTHeroTableHelper.lxt_saveHero(hero: hero)
        
        self.lxt_initMonster()
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
        let mapLevel = Expression<Int>("mapLevel")
        let userID = Expression<Int>("userID")
        
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
                                               type <- hero.type,
                                               mapLevel <- hero.mapLevel
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
                                              type <- hero.type,
                                              userID <- user.userID)
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
        let mapLevel = Expression<Int>("mapLevel")
        let userID = Expression<Int>("userID")
        
        do {
            let filter = heroTable.filter(userID == user.userID && type == 1)
            for hero in try db!.prepare(filter) {
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
                model.mapLevel = hero[mapLevel]
                heroArray.append(model)
            }
        } catch {
            print(error)
        }
        return heroArray
    }
    
    class func lxt_queryAllMonster() -> Array<LXTMonsterModel>{
        var monsterArray = Array<LXTMonsterModel>()
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
//        let mapLevel = Expression<Int>("mapLevel")
        let userID = Expression<Int>("userID")
        
        do {
            let filter = heroTable.filter(userID == user.userID && type == 2)
            for hero in try db!.prepare(filter) {
                let model = LXTMonsterModel()
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
//                model.mapLevel = hero[mapLevel]
                monsterArray.append(model)
            }
        } catch {
            print(error)
        }
        return monsterArray
    }
    
    class func lxt_initMonster() {
        let monster1 = LXTHeroModel()
        monster1.heroID = 2
        monster1.name = "稻草人"
        monster1.level = 1
        monster1.attack = 10
        monster1.magic = 10
        monster1.maxExp = 10
        monster1.hp = 100
        monster1.type = 2
        LXTHeroTableHelper.lxt_saveHero(hero: monster1)
        
        let monster2 = LXTHeroModel()
        monster2.heroID = 3
        monster2.name = "骷髅"
        monster2.level = 1
        monster2.attack = 20
        monster2.magic = 20
        monster2.maxExp = 15
        monster2.hp = 200
        monster2.type = 2
        LXTHeroTableHelper.lxt_saveHero(hero: monster2)
        
        let monster3 = LXTHeroModel()
        monster3.heroID = 4
        monster3.name = "虎蛇"
        monster3.level = 1
        monster3.attack = 30
        monster3.magic = 30
        monster3.maxExp = 20
        monster3.hp = 400
        monster3.type = 2
        LXTHeroTableHelper.lxt_saveHero(hero: monster3)
        
        let monster4 = LXTHeroModel()
        monster4.heroID = 5
        monster4.name = "多钩猫"
        monster4.level = 1
        monster4.attack = 40
        monster4.magic = 40
        monster4.maxExp = 25
        monster4.hp = 800
        monster4.type = 2
        LXTHeroTableHelper.lxt_saveHero(hero: monster4)
        
        let monster5 = LXTHeroModel()
        monster5.heroID = 6
        monster5.name = "雪人"
        monster5.level = 1
        monster5.attack = 50
        monster5.magic = 50
        monster5.maxExp = 30
        monster5.hp = 1000
        monster5.type = 2
        LXTHeroTableHelper.lxt_saveHero(hero: monster5)
        
        let monster6 = LXTHeroModel()
        monster6.heroID = 7
        monster6.name = "兽人"
        monster6.level = 1
        monster6.attack = 70
        monster6.magic = 70
        monster6.maxExp = 40
        monster6.hp = 2000
        monster6.type = 2
        LXTHeroTableHelper.lxt_saveHero(hero: monster6)
    }
}
