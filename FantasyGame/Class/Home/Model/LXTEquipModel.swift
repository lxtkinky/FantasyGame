//
//  LXTEquipModel.swift
//  FantasyGame
//
//  Created by ULDD on 2020/8/3.
//  Copyright © 2020 LXT. All rights reserved.
//

import UIKit

enum EquipType : Int, CaseIterable {
    case all = 0
    case weapon = 1 //武器
    case clothes = 2 //技能
    case helmet = 3
    case hand = 4
    case ring = 5
    case belt = 6
    case shoes = 7
    case treasure = 8
    case shield = 9
    case horse = 10
}

class LXTEquipModel: NSObject {
    var id = 0
    var name = ""
    var goldPrice = 0
    var ybPrice = 0
//    var equipID = 0
    var level = 0               //佩戴等级
    var strengthenLevel = 0           //强化等级
    var attack = 0
    var magic = 0
//    var fixedDamage = 0     //固定伤害
//    var coeffcient = 0      //伤害系数
    var enhance = 0         //增加输出伤害
    var reduce = 0          //受到伤害减免
//    var toxin = 0           //毒素伤害系数
    var type = 1                //装备类型  1武器，2衣服，3头，4手，5戒指，6腰带，7鞋子，8宝物，9盾牌，10坐骑
    var maxStrongLevel = 1
    var costStrongGold = 0
    var costStrongStone = 0
    var speed = 0
    var hp = 0
    var mp = 0
    var defense = 0
    var magicDefense = 0
    var doubleHit = 0
    var hpRecovery = 0
    var mpRecovery = 0
    var sundriesType = SundriesType.none
    var buyType = 1     //1，金币 2，元宝 3，材料兑换
    var priceCount = 0
    var skill = LXTHeroSkillModel()
    
    
    var userEquipID = 0
    var heroID = 0
    var strongLevel = 1
}
