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
    class func lxt_addGoods(goods : LXTGoodsModel) -> Bool {
        let goodTable = Table("goods")
//        let id = Expression<Int>("id")
        let name = Expression<String>("name")
        let count = Expression<Int>("count")
        let lock = Expression<Bool>("lock")
        let useable = Expression<Bool>("useable")
        let type = Expression<Int>("type")
        let desc = Expression<String>("desc")
        let relationID = Expression<Int>("relationID")
        let userID = Expression<Int>("userID")
        
        do {
            let filter = goodTable.filter(type == goods.type.rawValue && relationID == goods.relationID && userID == user.userID)
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
                relationID <- Int(goods.relationID),
                userID  <- user.userID)
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
    
    
    class func lxt_saveEquipGoods(goods : LXTGoodsModel) -> Bool{
        let goodTable = Table("goods")
//        let id = Expression<Int>("id")
        let name = Expression<String>("name")
        let count = Expression<Int>("count")
        let lock = Expression<Bool>("lock")
        let useable = Expression<Bool>("useable")
        let type = Expression<Int>("type")
        let desc = Expression<String>("desc")
        let relationID = Expression<Int>("relationID")
        let userID = Expression<Int>("userID")
        
        do {
            var rowid = LXTUserEquipDB.lxt_saveUserEquip(userEquip: goods.userEquip!)
            goods.relationID = rowid
            let insert =  goodTable.insert(name <- goods.name,
                                           count <- Int(goods.count),
                                           lock <- goods.lock,
                                           useable <- goods.useable,
                                           type <- goods.type.rawValue,
                                           desc <- goods.desc,
                                           relationID <- Int(goods.relationID),
                                           userID <- user.userID)
            rowid = Int(try db!.run(insert))
            if rowid > 0{
                print("插入成功")
            }else{
                print("新增物品失败")
            }
        } catch {
            print(error)
        }
        return false
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
    
    class func lxt_getAllSkillGoods() -> Array<LXTGoodsModel> {
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
        let userID = Expression<Int>("userID")
        let filter = goodTable.filter(goodTable[type] == GoodsType.skill.rawValue && goodTable[count] > 0 && goodTable[userID] == userID)
        
        
        let skillTable = Table("skill")
        let skillName = Expression<String>("name")
        let skillType = Expression<Int>("type")
        let damageBase = Expression<Int>("damageBase")
        let maxLevel = Expression<Int>("maxLevel")
        let damageFormula = Expression<Int>("formula")
        let studyLevel = Expression<Int>("studyLevel")
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
                skillModel.studyLevel = goods[skillTable[studyLevel]]
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
    
    class func lxt_getAllGoods() -> Array<LXTGoodsModel> {
//        let filter = goodTable.filter(count > 0)
//        for goods in try db!.prepare(filter) {
//            let model = LXTGoodsModel()
//            model.id = Int(goods[id])
//            model.name = goods[name]
//            model.count = Int(goods[count])
//            model.lock = goods[lock]
//            model.useable = goods[useable]
//            model.type = GoodsType.init(rawValue: Int(goods[type])) ?? GoodsType.equip
//            model.desc = goods[desc]
//            model.relationID = Int(goods[relationID])
//            goodsArray.append(model)
//            print("物品名称：\(model.name), 关联ID：\(model.relationID)")
//        }
        var goodsArray = Array<LXTGoodsModel>()
        let equipArray = self.lxt_getAllEquipGoods()
        let skillArray = self.lxt_getAllSkillGoods()
        let sundiresArray = self.lxt_getAllSundriesGoods()
        goodsArray += equipArray
        goodsArray += skillArray
        goodsArray += sundiresArray
        return goodsArray
    }
    
    class func lxt_getSundriesGoods(sundriesType : SundriesType) -> LXTGoodsModel{
        let model = LXTGoodsModel()
        let goodTable = Table("goods")
        let id = Expression<Int>("id")
        let name = Expression<String>("name")
        let count = Expression<Int>("count")
        let lock = Expression<Bool>("lock")
        let useable = Expression<Bool>("useable")
        let type = Expression<Int>("type")
        let desc = Expression<String>("desc")
        let relationID = Expression<Int>("relationID")
        let userID = Expression<Int>("userID")
        let filter = goodTable.filter(goodTable[type] == GoodsType.sundries.rawValue && goodTable[count] > 0 && goodTable[userID] == user.userID && goodTable[relationID] == sundriesType.rawValue)
        do {
            for goods in try db!.prepare(filter) {
                let model = LXTGoodsModel()
                model.id = Int(goods[id])
                model.name = goods[name]
                model.count = Int(goods[count])
                model.lock = goods[lock]
                model.useable = goods[useable]
                model.type = GoodsType(rawValue: Int(goods[type])) ?? GoodsType.sundries
                model.desc = goods[desc]
                model.relationID = Int(goods[relationID])
//                if model.relationID == SundriesType.coupon.rawValue {
//                    user.couponModel = model
//                }
//                goodsArray.append(model)
            }
        } catch {
            print(error)
        }
        return model
    }
    
    class func lxt_getAllSundriesGoods() -> Array<LXTGoodsModel>{
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
        let userID = Expression<Int>("userID")
        let filter = goodTable.filter(goodTable[type] == GoodsType.sundries.rawValue && goodTable[count] > 0 && goodTable[userID] == user.userID)
        do {
            for goods in try db!.prepare(filter) {
                let model = LXTGoodsModel()
                model.id = Int(goods[id])
                model.name = goods[name]
                model.count = Int(goods[count] )
                model.lock = goods[lock]
                model.useable = goods[useable]
                model.type = GoodsType(rawValue: Int(goods[type])) ?? GoodsType.sundries
                model.desc = goods[desc]
                model.relationID = Int(goods[relationID])
                if model.relationID == SundriesType.coupon.rawValue {
                    user.couponModel = model
                }
                
                if model.relationID == SundriesType.stone.rawValue {
                    user.stone = model
                }
                goodsArray.append(model)
            }
        } catch {
            print(error)
        }
        
        return goodsArray
    }
    
//    class func lxt_saveSundries(sundries : LXTGoodsModel){
//        let goodTable = Table("goods")
//        let name = Expression<String>("name")
//        let count = Expression<Int>("count")
//        let type = Expression<Int>("type")
//        let desc = Expression<String>("desc")
//        let relationID = Expression<Int>("relationID")
//        let userID = Expression<Int>("userID")
//        
//        do {
//            let filter = goodTable.filter(relationID == sundries.relationID && type == sundries.type.rawValue)
//            let update = filter.update(count += sundries.count)
//            let _ = try db!.run(update)
//        } catch {
//            
//        }
//    }
    
    class func lxt_getAllEquipGoods(paramHeroID : Int, paramEquipType : EquipType) -> Array<LXTGoodsModel>{
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
        let userID = Expression<Int>("userID")
        
        
        let userEquipTable = Table("user_equip")
        let userEquipID = Expression<Int>("userEquipID")
        let heroID = Expression<Int>("heroID")
        let relationEquipID = Expression<Int>("equipID")
        let strongLevel = Expression<Int>("strongLevel")
        
        let equipTable = Table("equip")
        let equipID = Expression<Int>("id")
        let equipName = Expression<String>("name")
        let level = Expression<Int>("level")
        let attack = Expression<Int>("attack")
        let magic = Expression<Int>("magic")
        let enhance = Expression<Int>("enhance")
        let reduce = Expression<Int>("reduce")
        let equipType = Expression<Int>("type")
        let maxStrongLevel = Expression<Int>("maxStrongLevel")
        let costStrongGold = Expression<Int>("costStrongGold")
        let costStrongStone = Expression<Int>("costStrongStone")
        let goldPrice = Expression<Int>("goldPrice")
        let ybPrice = Expression<Int>("ybPrice")
        let equipFilter = goodTable.filter(goodTable[type] == GoodsType.equip.rawValue && goodTable[userID] == user.userID && goodTable[count] > 0)
        
        do {
            var equipJoin = equipFilter.join(userEquipTable, on: goodTable[relationID] == userEquipTable[userEquipID])
            if paramHeroID != 0 {
                equipJoin = equipFilter.join(userEquipTable, on: goodTable[relationID] == userEquipTable[userEquipID] && userEquipTable[heroID] == paramHeroID)
            }
            
            if paramEquipType != EquipType.all {
                equipJoin = equipJoin.join(equipTable, on: userEquipTable[relationEquipID] == equipTable[equipID] && equipTable[equipType] == paramEquipType.rawValue)
            }else{
                equipJoin = equipJoin.join(equipTable, on: userEquipTable[relationEquipID] == equipTable[equipID])
            }
            
            for goods in try db!.prepare(equipJoin) {
                let model = LXTGoodsModel()
                model.id = Int(goods[goodTable[id]])
                model.name = goods[goodTable[name]]
                model.count = Int(goods[goodTable[count]])
                model.lock = goods[goodTable[lock]]
                model.useable = goods[goodTable[useable]]
                model.type = GoodsType(rawValue: Int(goods[goodTable[type]])) ?? GoodsType.equip
                model.desc = goods[goodTable[desc]]
                model.relationID = Int(goods[goodTable[relationID]])
                
                let userEquip = LXTUserEquipModel()
                userEquip.heroID = goods[userEquipTable[heroID]]
                userEquip.userEquipID = goods[userEquipTable[userEquipID]]
                userEquip.equipID = goods[userEquipTable[relationEquipID]]
                userEquip.strongLevel = goods[userEquipTable[strongLevel]]
                model.userEquip = userEquip
                
                let equip = LXTEquipModel()
                equip.id = goods[equipTable[equipID]]
                equip.level = goods[equipTable[level]]
                equip.attack = goods[equipTable[attack]]
                equip.magic = goods[equipTable[magic]]
                equip.enhance = goods[equipTable[enhance]]
                equip.reduce = goods[equipTable[reduce]]
                equip.type = goods[equipTable[equipType]]
                equip.maxStrongLevel = goods[equipTable[maxStrongLevel]]
                equip.costStrongStone = goods[equipTable[costStrongStone]]
                equip.costStrongGold = goods[equipTable[costStrongGold]]
                equip.name = goods[equipTable[equipName]]
                equip.goldPrice = goods[equipTable[goldPrice]]
                equip.ybPrice = goods[equipTable[ybPrice]]
                
                equip.strongLevel = goods[userEquipTable[strongLevel]]
                equip.userEquipID = goods[userEquipTable[userEquipID]]
                equip.heroID = goods[userEquipTable[heroID]]
                model.equipModel = equip
                
                goodsArray.append(model)
            }
        } catch {
            print(error)
        }
        return goodsArray
    }
    
    class func lxt_getAllEquipGoods() -> Array<LXTGoodsModel>{
        return self.lxt_getAllEquipGoods(paramHeroID: 0, paramEquipType: EquipType.all)
    }
    
    class func lxt_createGoodsTable() -> Void {
        let goodTable = Table("goods")
        let id = Expression<Int>("id")
        let name = Expression<String>("name")
        let count = Expression<Int>("count")
        let lock = Expression<Bool>("lock")
        let useable = Expression<Bool>("useable")
        let type = Expression<Int>("type")
        let desc = Expression<String>("desc")
        let relationID = Expression<Int>("relationID")
        let userID = Expression<Int>("userID")
        
        do {
            let _ = try db!.run(goodTable.create(temporary: false, ifNotExists: true, withoutRowid: false, block: { (builder) in
                builder.column(id, primaryKey: .autoincrement)
                builder.column(name, defaultValue: "未知物品")
                builder.column(count, defaultValue: 0)
                builder.column(lock, defaultValue: false)
                builder.column(useable, defaultValue: false)
                builder.column(type, defaultValue: 0)
                builder.column(desc, defaultValue: "未知物品")
                builder.column(relationID, defaultValue: 0)
                builder.column(userID, defaultValue: 0)
            }))
        } catch {
            print(error)
        }
        
        self.lxt_initSundries()
    }
    
    
    /// 杂物
    class func lxt_initSundries(){
//        var model = LXTGoodsModel()
//        model.type = GoodsType.sundries
//        model.relationID = SundriesType.coupon.rawValue
//        model.name = "副本券"
//        model.desc = "挑战副本消耗副本券"
//        model.count = 0
//
//        let _ = self.lxt_addGoods(goods: model)
//
//        model = LXTGoodsModel()
//        model.type = GoodsType.sundries
//        model.relationID = SundriesType.iron.rawValue
//        model.name = "凡铁"
//        model.desc = "凡铁，打造装备的材料"
//        model.count = 0
//        let _ = self.lxt_addGoods(goods: model)
    }
}
