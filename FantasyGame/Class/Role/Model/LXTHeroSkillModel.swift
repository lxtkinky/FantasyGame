//
//  LXTHeroSkillModel.swift
//  FantasyGame
//
//  Created by ULDD on 2020/7/30.
//  Copyright © 2020 LXT. All rights reserved.
//

import UIKit

class LXTHeroSkillModel: NSObject {
    var id = 0
    var heroID = 0
    var skillID = 0
    var level = 1
    var damage = 0
    var currentExp = 0
    var deleteState = false //是否删除
    //是否上阵
    var enable = false
    var index = 0       //第几个技能位
    
    var skill : LXTSkillModel?
}
