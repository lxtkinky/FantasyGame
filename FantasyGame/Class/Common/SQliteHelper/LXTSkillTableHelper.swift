//
//  LXTSkillTableHelper.swift
//  FantasyGame
//
//  Created by ULDD on 2020/7/27.
//  Copyright © 2020 LXT. All rights reserved.
//

import UIKit
import SQLite

//let skillTable = Table("skill")
//let id = Expression<Int?>("id")
//let skillID = Expression<Int?>("skillID")
//let name = Expression<String>("name")
//let type = Expression<Int64>("type")
//let damageBase = Expression<Int64>("damageBase")
//let maxLevel = Expression<Int64>("maxLevel")
//let damageFormula = Expression<Int64>("formula")
//let prerequisite = Expression<Int64>("prerequisite")
//let minExp = Expression<Int64>("minExp")
//let expFormula = Expression<Int64>("expFormula")
//let cd = Expression<Int64>("cd")
//let desc = Expression<String>("desc")
class LXTSkillTableHelper: NSObject {
    
    class func lxt_addSkillIDColumn() {
        let skillTable = Table("skill")
        let skillID = Expression<Int?>("skillID")
        LXTTableSQliteHelper.lxt_addColumn(table: skillTable, columnName: "skillID", column: skillID, defaultValue: 0)
    }
    
    class func lxt_initSkill(){
        let skill = LXTSkillModel()
        skill.skillID = 2
        skill.name = "基础内功"
        skill.type = 2
        skill.damageBase = 130
        skill.maxLevel = 100
        skill.damageFormula = 10
        skill.prerequisite = 100
        skill.minExp = 100000
        skill.expFormula = 1000000
        skill.cd = 6
        skill.desc = "基础内功，很好很强大"
        
        self.lxt_insertSkill(model: skill)
    }
    
    class func lxt_insertSkill(model : LXTSkillModel) -> Void{
        let skillTable = Table("skill")
//        let id = Expression<Int?>("id")
        let skillID = Expression<Int?>("skillID")
        let name = Expression<String>("name")
        let type = Expression<Int64>("type")
        let damageBase = Expression<Int64>("damageBase")
        let maxLevel = Expression<Int64>("maxLevel")
        let damageFormula = Expression<Int64>("formula")
        let prerequisite = Expression<Int64>("prerequisite")
        let minExp = Expression<Int64>("minExp")
        let expFormula = Expression<Int64>("expFormula")
        let cd = Expression<Int64>("cd")
        let desc = Expression<String>("desc")
    
        do {
            let filter = skillTable.filter(name == model.name)
            let count = try db!.scalar(filter.count)
            if count > 0 {
                print("不能添加重复的技能")
                return
            }
            
            let insert = skillTable.insert(skillID <- model.skillID,
                                           name <- model.name,
                                           type <- Int64(model.type),
                                           damageBase <- Int64(model.damageBase),
                                           maxLevel <- Int64(model.maxLevel),
                                           damageFormula <- Int64(model.damageFormula),
                                           prerequisite <- Int64(model.prerequisite),
                                           minExp <- Int64(model.minExp),
                                           expFormula <- Int64(model.expFormula),
                                           cd <- Int64(model.cd),
                                           desc <- model.desc)
            
            let rowid = try db!.run(insert)
            print("插入成功：rowid = \(rowid)")
        } catch {
            print("插入数据失败：\(error)")
        }
    }
    
    class func lxt_updateSkill(model : LXTSkillModel) -> Void {
        let skillTable = Table("skill")
        let id = Expression<Int?>("id")
        let skillID = Expression<Int?>("skillID")
        let item = skillTable.filter(id == model.id)
        do {
            let update = item.update(skillID <- model.skillID)
            if try db!.run(update) > 0{
//                print("更新成功")
            }else{
                print("更新失败")
            }
        } catch {
            
        }
    }
}
