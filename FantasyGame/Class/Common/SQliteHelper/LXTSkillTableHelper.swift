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

//var enhance = 0         //增加输出伤害
//var reduce = 0          //受到伤害减免
//var starLevel = 1
//var magic = 0           //法力
//var criticalChance = 0        //暴击几率
//var criticalDamage = 150   //暴伤增强
//var resistCriticalChance = 0    //抗暴击几率
//var resistCriticalDamage = 0    //暴击伤害减免
class LXTSkillTableHelper: NSObject {
    
    //    技能名称，伤害类型，伤害基数，等级，等级叠加公式，学习条件，等级经验基数，等级经验公式，冷却CD
    class func lxt_createSkillTable() -> Void {
        let skillTable = Table("skill")
        let id = Expression<Int64>("id")
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
        let buyType = Expression<Int>("buyType")
        
        let _ = try? db!.run(skillTable.create(block: { (table) in
            table.column(id, primaryKey: true)
            table.column(name, unique: true)
            table.column(type)
            table.column(damageBase)
            table.column(maxLevel)
            table.column(damageFormula)
            table.column(prerequisite)
            table.column(minExp)
            table.column(expFormula)
            table.column(cd)
            table.column(desc)
            table.column(buyType, defaultValue: 1)
        }))
    }
    
    class func lxt_getBaseSkills() -> Array<LXTSkillModel> {
        let skillTable = Table("skill")
        let id = Expression<Int64>("id")
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
        let skillID = Expression<Int>("skillID")
        let buyType = Expression<Int>("buyType")
        
        var skillArr = Array<LXTSkillModel>()
        for skill in try! db!.prepare(skillTable) {
            
            let model = LXTSkillModel()
            model.id = Int(skill[id])
            model.name = String(skill[name])
            model.type = Int(skill[type])
            model.damageBase = Int(skill[damageBase])
            model.maxLevel = Int(skill[maxLevel])
            model.damageFormula = Int(skill[damageFormula])
            model.prerequisite = Int(skill[prerequisite])
            model.minExp = Int(skill[minExp])
            model.expFormula = Int(skill[expFormula])
            model.cd = Int(skill[cd])
            model.desc = String(skill[desc])
            model.skillID = skill[skillID]
            model.buyType = skill[buyType]
            print("技能名称：\(skill[name])，skillID = \(skill[skillID])，对地方造成\(skill[damageBase])%的物理伤害")
            skillArr.append(model)
        }
        
        return skillArr
    }
    
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
        
        let ybSkill = LXTSkillModel()
        ybSkill.skillID = 3
        ybSkill.name = "大挪移神通"
        ybSkill.type = 2
        ybSkill.buyType = 2
        ybSkill.damageBase = 130
        ybSkill.maxLevel = 100
        ybSkill.damageFormula = 10
        ybSkill.prerequisite = 100
        ybSkill.minExp = 100000
        ybSkill.expFormula = 1000000
        ybSkill.cd = 6
        ybSkill.desc = "大挪移神通，很好很强大"
        self.lxt_insertSkill(model: ybSkill)
        
//        let skill2 = LXTSkillModel()
//        skill2.skillID = 1
//        skill2.id = 1
//        self.lxt_updateSkill(model: skill2)
//        skill2.name = "基础剑法"
//        skill2.type = 2
//        skill2.damageBase = 110
//        skill2.maxLevel = 100
//        skill2.damageFormula = 10
//        skill2.prerequisite = 100
//        skill2.minExp = 100000
//        skill2.expFormula = 1000000
//        skill2.cd = 6
//        skill2.desc = "基础剑法，很好很强大"
//
//        self.lxt_insertSkill(model: skill2)
        
        let skill3 = LXTSkillModel()
        skill3.skillID = 3
        skill3.name = "一点寒光(剑)"
        skill3.type = 2
        skill3.damageBase = 150
        skill3.maxLevel = 100
        skill3.damageFormula = 10
        skill3.prerequisite = 100
        skill3.minExp = 100000
        skill3.expFormula = 1000000
        skill3.cd = 6
        skill3.desc = "进阶剑招，非常强大"
        self.lxt_insertSkill(model: skill3)
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
        let buyType = Expression<Int>("buyType")
    
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
                                           buyType <- model.buyType,
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
