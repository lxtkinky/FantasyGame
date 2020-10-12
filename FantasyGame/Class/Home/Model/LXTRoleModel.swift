//
//  LXTRoleModel.swift
//  FantasyGame
//
//  Created by ULDD on 2020/7/14.
//  Copyright © 2020 LXT. All rights reserved.
//

import UIKit

class LXTRoleModel: LXTBaseModel{
//    static var supportsSecureCoding: Bool = true
    
//    func encode(with coder: NSCoder) {
//        coder.encode(hp)
//        coder.encode(mp)
//        coder.encode(currentHP)
//        coder.encode(currentMP)
//        coder.encode(attack)
//        coder.encode(level)
//    }
//    
//    required init?(coder: NSCoder) {
//        hp = Int(coder.decodeInt32(forKey: "hp"))
//        mp = Int(coder.decodeInt32(forKey: "mp"))
//        currentHP = Int(coder.decodeInt32(forKey: "currentHP"))
//        currentMP = Int(coder.decodeInt32(forKey: "currentMP"))
//        attack = Int(coder.decodeInt32(forKey: "attack"))
//        level = Int(coder.decodeInt32(forKey: "level"))
//    }
    
    override init() {
        
    }
    
    var id = 0
    var heroID = 0
    var name = ""
    var hp = 0
    var mp = 0
    var currentHP = 0
    var currentMP = 0
    var attack = 0
    var level = 1
    var maxExp = 0
    var currentExp = 0
    var desc = ""
    var enhance = 0         //增加输出伤害
    var reduce = 0          //受到伤害减免
    var starLevel = 1       //星级
    var magic = 0           //法力
    var criticalChance = 0        //暴击几率
    var criticalDamage = 150   //暴伤增强
    var resistCriticalChance = 0    //抗暴击几率
    var resistCriticalDamage = 0    //暴击伤害减免
    var type = 1                    //1，英雄 2，地图怪物
    var suckBlood = 0               //吸血
    var backInjury = 0              //反伤
    
    var talentSkills = Array<LXTHeroSkillModel>()   //天赋技能
    var skills = Array<LXTHeroSkillModel>(repeating: LXTHeroSkillModel(), count: 6)
}
