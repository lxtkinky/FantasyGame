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
class LXTHeroTableHelper: NSObject {
    class func lxt_createTable(){
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
        
        do {
            try db!.run(heroTable.create(temporary: false, ifNotExists: true, withoutRowid: false, block: { (builder) in
                builder.column(id, primaryKey: .autoincrement)
                builder.column(heroID, unique: true)
                builder.column(name)
                builder.column(hp)
                builder.column(mp)
                builder.column(attack)
                builder.column(level)
                builder.column(maxExp)
                builder.column(currentExp)
                builder.column(desc)
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
        
        do {
            let filter = heroTable.filter(heroID == hero.heroID)
            let items = try db!.prepare(filter)
            var count = 0
            for _ in items {
                count += 1
            }
            if count > 0 {
                let update = filter.update(name <- hero.name,
                                               hp <- hero.hp,
                                               mp <- hero.mp,
                                               attack <- hero.attack,
                                               level <- hero.level,
                                               maxExp <- hero.maxExp,
                                               currentExp <- hero.currentExp,
                                               desc <- hero.desc
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
                                              desc <- hero.desc
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
                heroArray.append(model)
            }
        } catch {
            print(error)
        }
        return heroArray
    }
}
