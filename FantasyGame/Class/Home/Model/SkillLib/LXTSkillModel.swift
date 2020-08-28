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
    var buyType = 1             //1、金币购买，  2，元宝购买, 3材料兑换
    var goldPrice = 1000
    var ybPrice = 100
    var priceCount = 0          //购买或兑换数量
    var sundiresType = SundriesType.none    //兑换材料类型
    
    var enhance = 0         //增加我方输出伤害
    var reduce = 0          //增加我方伤害减免
    var starLevel = 1
    var magic = 0           //法力
    var criticalChance = 0        //暴击几率
    var criticalDamage = 150   //暴伤增强
    var resistCriticalChance = 0    //抗暴击几率
    var resistCriticalDamage = 0    //暴击伤害减免
    var suckBlood = 0
    var backInjury = 0
}
