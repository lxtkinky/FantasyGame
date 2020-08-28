//
//  LXTRoleManager.swift
//  FantasyGame
//
//  Created by ULDD on 2020/7/17.
//  Copyright © 2020 LXT. All rights reserved.
//

import UIKit

class LXTRoleManager: NSObject {
    class func lxt_saveHero(hero : LXTHeroModel) -> Void {
            LXTHeroTableHelper.lxt_saveHero(hero: hero)
//            let fileExists = FileManager().fileExists(atPath: documentPath! + "/data/role/hero.data")
//            if !fileExists {
//                do {
//                    try FileManager().createDirectory(atPath: documentPath! + "/data/role/", withIntermediateDirectories: true, attributes: nil)
//                    FileManager.default.createFile(atPath: documentPath! + "/data/role/hero.data", contents: nil, attributes: nil)
//                } catch  {
//                    print("创建文件失败")
//                }
//
//            }
//            if let data = try? NSKeyedArchiver.archivedData(withRootObject: hero, requiringSecureCoding: true){
//
//                if let _ = try? data.write(to: URL(fileURLWithPath: documentPath! + "/data/role/hero.data")){
//
//                }else{
//                    print("写入文件失败")
//                }
//            }else{
//                print("失败1")
//            }
        
        }
    
    /*
           self.hero = LXTRoleManager.lxt_loadHero()
           self.skillArray = Array<LXTHeroSkillModel>(repeating: LXTHeroSkillModel(), count: 6)
           for model in LXTHeroSkillDBHelper.lxt_queryHeroSkillByHeroID(heroID: 1, battle: true) {
               self.skillArray[model.index - 1] = model
               print("上阵技能：\(model.skill?.name ?? "未知技能")")
           }
           self.hero.skills = self.skillArray
           let equipArray = LXTGoodsSQliteHelper.lxt_getAllEquipGoods(paramHeroID: self.hero.id, paramEquipType: .all)
           for item in equipArray {
               self.hero.equipArray[item.equipModel.type - 1] = item
           }
           self.heroView.hero = self.hero
    */
    class func lxt_loadAllHero() -> Array<LXTHeroModel>{
        let array = LXTHeroTableHelper.lxt_queryAllHero()
        for hero in array {
            for model in LXTHeroSkillDBHelper.lxt_queryHeroSkillByHeroID(heroID: hero.id, battle: true) {
                hero.skills[model.index - 1] = model
                print("上阵技能：\(model.skill?.name ?? "未知技能")")
            }
            
            let equipArray = LXTGoodsSQliteHelper.lxt_getAllEquipGoods(paramHeroID: hero.id, paramEquipType: .all)
            for item in equipArray {
                hero.equipArray[item.equipModel.type - 1] = item
            }
            hero.lxt_calculate()
        }
        return array
    }
    
    class func lxt_updateHeroSkill(){
        for hero in heroArray {
            var skills = Array<LXTHeroSkillModel>(repeating: LXTHeroSkillModel(), count: 6)
            for model in LXTHeroSkillDBHelper.lxt_queryHeroSkillByHeroID(heroID: hero.id, battle: true) {
                skills[model.index - 1] = model
                print("上阵技能：\(model.skill?.name ?? "未知技能")")
            }
            hero.skills = skills
        }
    }
    
    class func lxt_updateHeroEquip(){
        for hero in heroArray {
            let equipArray = LXTGoodsSQliteHelper.lxt_getAllEquipGoods(paramHeroID: hero.id, paramEquipType: .all)
            var tempArray = Array<LXTGoodsModel>(repeating: LXTGoodsModel(), count: 10)
            for item in equipArray {
                tempArray[item.equipModel.type - 1] = item
            }
            hero.equipArray = tempArray
            hero.lxt_calculate()
        }
    }

        class func lxt_loadHero() -> LXTHeroModel {
//            do {
//                let data = try Data(contentsOf: URL(fileURLWithPath: documentPath! + "/data/role/hero.data"))
//                let hero = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? LXTHeroModel
//                return hero ?? LXTHeroModel.init()
//            } catch  {
//                print("解档文件失败")
//            }
            let heroArray = LXTHeroTableHelper.lxt_queryAllHero()
            if heroArray.count > 0 {
                return heroArray[0]
            }else{
                let hero = LXTHeroModel()
                hero.heroID = 1
                hero.name = "主角"
                LXTHeroTableHelper.lxt_saveHero(hero: hero)
                return hero
            }
        }
    
    
    /// 保存最后在线时间
    class func lxt_saveArchiveDate() {
        let archiveDate = Date()
        UserDefaults.standard.set(archiveDate, forKey: "archiveDate")
        let dateStr = LXTDateHelper().lxt_stringFromDate(date: archiveDate, format: "yyyy-MM-dd HH:mm:ss")
        print("lxt-- 存档 = \(dateStr)")
    }
    
    
    /// 结算离线收益
    class func lxt_offlineRevenue() -> String? {
        var revenueStr : String? = nil
        if let archiveDate = UserDefaults.standard.object(forKey: "archiveDate") as? Date{
            let dateStr = LXTDateHelper().lxt_stringFromDate(date: archiveDate, format: "yyyy-MM-dd HH:mm:ss")
            var interval = Date().timeIntervalSince(archiveDate)
            interval = interval > 12 * 60 * 60 ? 12 * 60 * 60 : interval
            print("lxt-- 上次存档时间 = \(dateStr), interval = \(interval)")
            if interval > 1 * 60 {
                let pkCount = Int(interval / 5 )
                user.goldNum += pkCount
                let totalExp = pkCount * 10
                let hero = self.lxt_loadHero()
                hero.currentExp += totalExp
                if hero.currentExp + totalExp > hero.maxExp {
                    hero.currentExp -= hero.maxExp
                    hero.level += 1
                }
                var hpCount = 0
                var attackCount = 0
                for _  in 1...pkCount {
                    if Int(arc4random()) % probability == 1{
                        if arc4random() % 5 == 1 {
                            hero.attack += 1
                            attackCount += 1
                        }else{
                            hero.hp += 1
                            hpCount += 1
                        }
                    }
                }
                self.lxt_saveHero(hero: hero)
                LXTUserManager().lxt_saveUser(user: user)
                revenueStr = "离线战斗\(pkCount)次，生命+\(hpCount)，攻击+\(attackCount)"
            }
        }else{
            print("lxt-- 没有存档")
        }
        return revenueStr
    }
}
