//
//  LXTEquipModel.swift
//  FantasyGame
//
//  Created by ULDD on 2020/8/3.
//  Copyright © 2020 LXT. All rights reserved.
//

import UIKit

class LXTEquipModel: NSObject {
    var id = 0
    var name = ""
    var goldPrice = 0
    var ybPrice = 0
    var equipID = 0
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
    var maxStrongLevel = 0
    var costStrongGold = 0
    var costStrongStone = 0
    var skill = LXTHeroSkillModel()
    
}
