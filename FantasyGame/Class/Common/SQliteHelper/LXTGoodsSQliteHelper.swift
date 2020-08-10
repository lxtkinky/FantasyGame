//
//  LXTGoodsSQliteHelper.swift
//  FantasyGame
//
//  Created by ULDD on 2020/7/28.
//  Copyright © 2020 LXT. All rights reserved.
//

import UIKit
import SQLite

class LXTGoodsSQliteHelper: NSObject {
    func lxt_addGoods(goods : LXTGoodsModel) -> Bool {
        let goodTable = Table("goods")
//        let id = Expression<Int>("id")
        let name = Expression<String>("name")
        let count = Expression<Int>("count")
        let lock = Expression<Bool>("lock")
        let useable = Expression<Bool>("useable")
        let type = Expression<Int>("type")
        let desc = Expression<String>("desc")
        let relationID = Expression<Int>("relationID")
        
        do {
            let filter = goodTable.filter(type == goods.type.rawValue && relationID == goods.relationID)
            let rowCount = try db!.scalar(filter.count)
            if rowCount > 0 {
                let update = filter.update(count += goods.count)
                let rowid = try db!.run(update)
                if rowid > 0{
                    print("更新成功")
                }else{
                    print("更新物品失败")
                }
            }else{
                let insert =  goodTable.insert(name <- goods.name,
                count <- Int(goods.count),
                lock <- goods.lock,
                useable <- goods.useable,
                type <- goods.type.rawValue,
                desc <- goods.desc,
                relationID <- Int(goods.relationID))
                let rowid = try db!.run(insert)
                if rowid > 0{
                    print("插入成功")
                }else{
                    print("新增物品失败")
                }
            }
            
        } catch {
            print(error)
        }
        return true
    }
    
    class func lxt_updateGoods(model : LXTGoodsModel) -> Bool {
        model.count = model.count < 0 ? 0 : model.count
        let goodTable = Table("goods")
        let id = Expression<Int>("id")
        let name = Expression<String>("name")
        let count = Expression<Int>("count")
        let lock = Expression<Bool>("lock")
        let useable = Expression<Bool>("useable")
        let type = Expression<Int>("type")
        let desc = Expression<String>("desc")
//        let relationID = Expression<Int>("relationID")
        do {
            let filter = goodTable.filter(id == model.id)
            let update = filter.update(name <- model.name,
                                       count <- model.count,
                                       lock <- model.lock,
                                       useable <- model.useable,
                                       type <- model.type.rawValue,
                                       desc <- model.desc)
            let rowid = try db!.run(update)
            if rowid > 0 {
                print("更新物品信息成功")
                return true
            }else{
                print("更新物品信息失败")
                return true
            }
        } catch {
            print("更新失败,\(error)")
        }
        
        return false
    }
    
    func lxt_getAllSkillGoods() -> Array<LXTGoodsModel> {
        var goodsArray = Array<LXTGoodsModel>()
        let goodTable = Table("goods")
        let id = Expression<Int>("id")
        let name = Expression<String>("name")
        let count = Expression<Int>("count")
        let lock = Expression<Bool>("lock")
        let useable = Expression<Bool>("useable")
        let type = Expression<Int>("type")
        let desc = Expression<String>("desc")
        let relationID = Expression<Int>("relationID")
        let filter = goodTable.filter(goodTable[type] == GoodsType.skill.rawValue)
        
        let skillTable = Table("skill")
        let skillName = Expression<String>("name")
        let skillType = Expression<Int>("type")
        let damageBase = Expression<Int>("damageBase")
        let maxLevel = Expression<Int>("maxLevel")
        let damageFormula = Expression<Int>("formula")
        let prerequisite = Expression<Int>("prerequisite")
        let minExp = Expression<Int>("minExp")
        let expFormula = Expression<Int>("expFormula")
        let cd = Expression<Int>("cd")
        let skillDesc = Expression<String>("desc")
        let skillID = Expression<Int>("skillID")
        
        do {
            let join = filter.join(skillTable, on: goodTable[relationID] == skillTable[skillID])
//            goodTable.join(skillTable, on: goodTable[relationID] == skillTable[skillID])
//            let goods = try db!.pluck(join)       //取第一行
//            print("lxt--goods name = \(String(describing: goods?[goodTable[name]]))")
            for goods in try db!.prepare(join) {
                let model = LXTGoodsModel()
                model.id = Int(goods[goodTable[id]])
                model.name = goods[goodTable[name]]
                model.count = Int(goods[goodTable[count]])
                model.lock = goods[goodTable[lock]]
                model.useable = goods[goodTable[useable]]
                model.type = GoodsType(rawValue: Int(goods[goodTable[type]])) ?? GoodsType.skill
                model.desc = goods[goodTable[desc]]
                model.relationID = Int(goods[goodTable[relationID]])

                let skillModel = LXTSkillModel()
                skillModel.skillID = goods[skillTable[skillID]]
                skillModel.name = goods[skillTable[skillName]]
                skillModel.type = goods[skillTable[skillType]]
                skillModel.damageBase = goods[skillTable[damageBase]]
                skillModel.maxLevel = goods[skillTable[maxLevel]]
                skillModel.damageFormula = goods[skillTable[damageFormula]]
                skillModel.prerequisite = goods[skillTable[prerequisite]]
                skillModel.minExp = goods[skillTable[minExp]]
                skillModel.expFormula = goods[skillTable[expFormula]]
                skillModel.cd = goods[skillTable[cd]]
                skillModel.desc = goods[skillTable[skillDesc]]
                model.skillModel = skillModel

                goodsArray.append(model)
            }
        } catch {
            print(error)
        }
        
        return goodsArray
    }
    
    func lxt_getAllGoods() -> Array<LXTGoodsModel> {
        var goodsArray = Array<LXTGoodsModel>()
        let goodTable = Table("goods")
        let id = Expression<Int>("id")
        let name = Expression<String>("name")
        let count = Expression<Int>("count")
        let lock = Expression<Bool>("lock")
        let useable = Expression<Bool>("useable")
        let type = Expression<Int>("type")
        let desc = Expression<String>("desc")
        let relationID = Expression<Int>("relationID")
        do {
            let filter = goodTable.filter(count > 0)
            for goods in try db!.prepare(filter) {
                let model = LXTGoodsModel()
                model.id = Int(goods[id])
                model.name = goods[name]
                model.count = Int(goods[count])
                model.lock = goods[lock]
                model.useable = goods[useable]
                model.type = GoodsType.init(rawValue: Int(goods[type])) ?? GoodsType.equip
                model.desc = goods[desc]
                model.relationID = Int(goods[relationID])
                goodsArray.append(model)
                print("物品名称：\(model.name), 关联ID：\(model.relationID)")
            }
        } catch {
            
        }
        
        return goodsArray
    }
    
    func lxt_createGoodsTable() -> Void {
        let goodTable = Table("goods")
        let id = Expression<Int>("id")
        let name = Expression<String>("name")
        let count = Expression<Int>("count")
        let lock = Expression<Bool>("lock")
        let useable = Expression<Bool>("useable")
        let type = Expression<Int>("type")
        let desc = Expression<String>("desc")
        let relationID = Expression<Int>("relationID")
        
        do {
            let _ = try db!.run(goodTable.create(temporary: false, ifNotExists: true, withoutRowid: false, block: { (builder) in
                builder.column(id, primaryKey: .autoincrement)
                builder.column(name, unique: true)
                builder.column(count)
                builder.column(lock)
                builder.column(useable)
                builder.column(type)
                builder.column(desc)
                builder.column(relationID)
            }))
        } catch {
            print(error)
        }
        
    }
}
