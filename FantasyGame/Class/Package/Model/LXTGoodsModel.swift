//
//  LXTGoodsModel.swift
//  FantasyGame
//
//  Created by ULDD on 2020/7/28.
//  Copyright © 2020 LXT. All rights reserved.
//

import UIKit

enum GoodsType : Int {
    case equip = 1 //装备
    case skill = 2 //技能
    case sundries = 3 //杂物
}

enum SundriesType : Int {
    case none = 0
    case coupon = 1 //副本券
    case iron = 2    //精铁
    case copper = 3     //黄铜
}

class LXTGoodsModel: NSObject {
    var id = 0
    var name = ""
    var count = 0
    var lock = false
    var useable = true
    var type : GoodsType  = .equip
    var desc = ""
    var relationID = 0
    var userID = 0
    
    var contentModel : Any?
    var skillModel : LXTSkillModel?
    var equipModel : LXTEquipModel = LXTEquipModel()
    var userEquip : LXTUserEquipModel?
    
}
