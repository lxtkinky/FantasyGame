//
//  LXTHeroSkillDBHelper.swift
//  FantasyGame
//
//  Created by ULDD on 2020/7/30.
//  Copyright © 2020 LXT. All rights reserved.
//

import UIKit
import SQLite

class LXTHeroSkillDBHelper: NSObject {

    class func lxt_createTable(){
        let table = Table("hero_skill")
        let id = Expression<Int>("id")
        let heroID = Expression<Int>("heroID")
        let skillID = Expression<Int>("skillID")
        let level = Expression<Int>("level")
        let currentExp = Expression<Int>("currentExp")
        let damage = Expression<Int>("damage")
        
        
        do {
            try db!.run(table.create(temporary: false, ifNotExists: true, withoutRowid: false, block: { (builder) in
                builder.column(id, primaryKey: .autoincrement)
                builder.column(heroID)
                builder.column(skillID)
                builder.column(level)
                builder.column(currentExp)
                builder.column(damage)
            }))
        } catch {
            print("创建英雄技能表失败：\(error)")
        }
        let enable = Expression<Bool?>("enable")
        let deleteState = Expression<Bool?>("deleteState")
        let index = Expression<Int?>("index")
        
        var exists = LXTTableSQliteHelper.lxt_columnExists(columnName: "enable", table: table)
        if !exists {
            LXTTableSQliteHelper.lxt_addColumn(table: table, columnName: "enable", column: enable, defaultValue: false)
        }
        
        exists = LXTTableSQliteHelper.lxt_columnExists(columnName: "deleteState", table: table)
        if !exists {
            LXTTableSQliteHelper.lxt_addColumn(table: table, columnName: "deleteState", column: deleteState, defaultValue: false)
        }
        
        exists = LXTTableSQliteHelper.lxt_columnExists(columnName: "index", table: table)
        if !exists {
            LXTTableSQliteHelper.lxt_addColumn(table: table, columnName: "index", column: index, defaultValue: 0)
        }
        
        self.lxt_repairSkill()
    }
    
    class func lxt_repairSkill(){
        let table = Table("hero_skill")
        let enable = Expression<Bool?>("enable")
//        let deleteState = Expression<Bool?>("deleteState")
        let index = Expression<Int?>("index")
        do {
            let filter = table.filter(index == 0)
            let update = filter.update(enable <- false)
            let _ = try db!.run(update)
        } catch {
            print(error)
        }
    }
    
    class func lxt_updateHeroSkillExp(exp : Int){
        let table = Table("hero_skill")
        let enable = Expression<Bool>("enable")
        let currentExp = Expression<Int>("currentExp")
        let update = table.filter(enable == true).update(currentExp += exp)
        do {
            let row = try db!.run(update)
            if row > 0 {
                print("更新exp成功")
            }else{
//                print("没有技能上阵")
            }
        } catch {
            print(error)
        }
    }
    
    
    /// 查询英雄技能
    /// - Parameters:
    ///   - heroID: 英雄ID
    ///   - battle: 只查询上阵技能
    /// - Returns: 查询英雄已学习技能
    class func lxt_queryHeroSkillByHeroID(heroID : Int, battle : Bool) -> Array<LXTHeroSkillModel>{
        var heroSkillArray = Array<LXTHeroSkillModel>()
        let table = Table("hero_skill")
        let id = Expression<Int>("id")
        let heroID = Expression<Int>("heroID")
        let skillID = Expression<Int>("skillID")
        let level = Expression<Int>("level")
        let currentExp = Expression<Int>("currentExp")
        let damage = Expression<Int>("damage")
        let enable = Expression<Bool>("enable")
        let deleteState = Expression<Bool>("deleteState")
        
        let skillTable = Table("skill")
        let name = Expression<String>("name")
        let type = Expression<Int64>("type")
        let damageBase = Expression<Int64>("damageBase")
        let maxLevel = Expression<Int64>("maxLevel")
        let damageFormula = Expression<Int64>("formula")
        let studyLevel = Expression<Int64>("studyLevel")
        let minExp = Expression<Int>("minExp")
        let expFormula = Expression<Int>("expFormula")
        let cd = Expression<Int>("cd")
        let desc = Expression<String>("desc")
        let index = Expression<Int>("index")
        do {
            var query = table.join(skillTable, on: table[skillID] == skillTable[skillID])
                .filter(table[heroID] == heroID)
            if battle {
                query = table.join(skillTable, on: table[skillID] == skillTable[skillID])
                    .filter(table[heroID] == heroID && table[enable] == true)
            }
            for item in try db!.prepare(query) {
                let model = LXTHeroSkillModel()
                model.id = item[table[id]]
                model.heroID = item[table[heroID]]
                model.skillID = item[table[skillID]]
                model.level = item[table[level]]
                model.currentExp = item[table[currentExp]]
                model.damage = item[table[damage]]
                model.enable = item[table[enable]]
                model.deleteState = item[table[deleteState]]
                model.index = item[table[index]]
                 
                let skill = LXTSkillModel()
                skill.name = item[skillTable[name]]
                skill.skillID = item[table[skillID]]
                skill.type = Int(item[skillTable[type]])
                skill.damageBase = Int(item[skillTable[damageBase]])
                skill.maxLevel = Int(item[skillTable[maxLevel]])
                skill.damageFormula = Int(item[skillTable[damageFormula]])
                skill.studyLevel = Int(item[skillTable[studyLevel]])
                skill.minExp = item[skillTable[minExp]]
                skill.expFormula = item[skillTable[expFormula]]
                skill.cd = item[skillTable[cd]]
                skill.desc = item[skillTable[desc]]
                model.skill = skill
                heroSkillArray.append(model)
            }
        } catch {
            print(error)
        }
        
        
        
        return heroSkillArray
    }
    
    class func lxt_saveHeroSkill(heroSkill : LXTHeroSkillModel) -> Bool{
        let table = Table("hero_skill")
        let id = Expression<Int>("id")
        let heroID = Expression<Int>("heroID")
        let skillID = Expression<Int>("skillID")
        let level = Expression<Int>("level")
        let currentExp = Expression<Int>("currentExp")
        let damage = Expression<Int>("damage")
        let enable = Expression<Bool>("enable")
        let deleteState = Expression<Bool>("deleteState")
        let index = Expression<Int>("index")
        do {
            let filter = table.filter(id == heroSkill.id)
            let count = try db!.scalar(filter.count)
//            for _ in try db!.prepare(filter) {
//                count += 1
//            }
            if count > 0 {
                let update = filter.update(level <- heroSkill.level,
                                          currentExp <- heroSkill.currentExp,
                                          damage <- heroSkill.damage,
                                          enable <- heroSkill.enable,
                                          deleteState <- heroSkill.deleteState,
                                          index <- heroSkill.index)
                let rowid = try db!.run(update)
                return rowid > 0
            }else{
                let insert = table.insert(heroID <- heroSkill.heroID,
                                          skillID <- heroSkill.skillID,
                                          level <- heroSkill.level,
                                        currentExp <- heroSkill.currentExp,
                                        damage <- heroSkill.damage,
                                        enable <- heroSkill.enable,
                                        deleteState <- heroSkill.deleteState,
                                        index <- heroSkill.index)
                let rowid  = try db!.run(insert)
                return rowid > 0
            }
            
        } catch {
            print(error)
            return false
        }
    }
}
