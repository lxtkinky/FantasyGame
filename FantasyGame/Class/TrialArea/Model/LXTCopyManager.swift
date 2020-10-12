//
//  LXTCopyManager.swift
//  FantasyGame
//
//  Created by ULDD on 2020/8/20.
//  Copyright © 2020 LXT. All rights reserved.
//

import UIKit

var copyArray = Array<LXTCopyModel>()
class LXTCopyManager: NSObject {
    
    class func lxt_loadAllCopy() -> Array<LXTCopyModel>{
        if copyArray.count == 0 {
            var copyModel = LXTCopyModel()
            copyModel.name = "铜矿副本"
            copyModel.level = 10
            copyModel.couponCost = 1
            
            var monster = LXTMonsterModel()
            monster.level = 10
            monster.attack = 30
            monster.name = "铜矿野兽"
            copyModel.monster = monster
            
            var goods = LXTGoodsModel()
            goods.type = .sundries
            goods.relationID = SundriesType.copper.rawValue
            goods.name = "铜矿"
            goods.desc = "铜矿，打造装备的材料"
            goods.count = 1
            copyModel.sundries.append(goods)
            
            let stone1 = LXTGoodsModel()
            stone1.name = "强化石"
            stone1.desc = "强化石，用于强化装备"
            stone1.count = 1
            stone1.type = .sundries
            stone1.relationID = SundriesType.stone.rawValue
            copyModel.sundries.append(stone1)
            copyArray.append(copyModel)
            
            
            
            copyModel = LXTCopyModel()
            copyModel.name = "铁矿副本"
            copyModel.couponCost = 3
            copyModel.level = 50
            
            monster = LXTMonsterModel()
            monster.level = 2
            monster.attack = 30
            monster.name = "食铁兽"
            copyModel.monster = monster
            
            goods = LXTGoodsModel()
            goods.type = .sundries
            goods.relationID = SundriesType.iron.rawValue
            goods.name = "精铁"
            goods.desc = "精铁，打造装备的材料"
            goods.count = 1
            copyModel.sundries.append(goods)
            copyArray.append(copyModel)
        }
        return copyArray
    }
}
