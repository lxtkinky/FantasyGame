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
}

class LXTGoodsModel: NSObject {
    var id = 0
    var name = ""
    var count = 1
    var lock = false
    var useable = true
    var type : GoodsType  = .equip
    var desc = ""
    var relationID = 0
    
    var contentModel : Any?
    var skillModel : LXTSkillModel?
    
}
