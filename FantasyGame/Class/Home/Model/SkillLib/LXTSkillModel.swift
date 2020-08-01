//
//  LXTSkillModel.swift
//  FantasyGame
//
//  Created by ULDD on 2020/7/27.
//  Copyright © 2020 LXT. All rights reserved.
//

import UIKit

class LXTSkillModel: NSObject {
    var id = 0
    var skillID = 0
    var name = ""
    var type = 1
    var damageBase = 0
    var maxLevel = 0
    var damageFormula = 0
    var prerequisite = 0        //学习条件
    var minExp = 0
    var expFormula = 0
    var cd = 0
    var desc = ""
    var goldPrice = 1000
    var ybPrice = 100
}
