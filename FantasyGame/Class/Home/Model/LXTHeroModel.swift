//
//  LXTHeroModel.swift
//  FantasyGame
//
//  Created by ULDD on 2020/7/14.
//  Copyright © 2020 LXT. All rights reserved.
//

import UIKit

class LXTHeroModel: LXTRoleModel,NSSecureCoding {
    static var supportsSecureCoding: Bool = true
    var equipArray : Array<LXTGoodsModel> = Array<LXTGoodsModel>(repeating: LXTGoodsModel(), count: 10)
    
    var totalAttack = 0
    var totalMagic: Int = 0
    override var level: Int{
        didSet{
            self.maxExp = level * 10000
        }
    }
    
    var mapLevel = 1
    override var maxExp: Int{
        get{
             return level * 10000
        }
        set{
            super.maxExp = newValue
        }
    }
    
    override init() {
        super.init()
        self.hp = 100
        self.currentHP = self.hp
        self.mp = 10
        self.currentMP = self.mp
        self.attack = 10
        self.level = 1
        self.maxExp = 1000
        self.currentExp = 0
    }
    
     func encode(with coder: NSCoder) {
        coder.encode(hp, forKey: "hp")
        coder.encode(mp, forKey: "mp")
//        coder.encode(currentHP, forKey: "currentHP")
//        coder.encode(currentMP, forKey: "currentMP")
        coder.encode(attack, forKey: "attack")
        coder.encode(level, forKey: "level")
        coder.encode(maxExp, forKey: "maxExp")
        coder.encode(currentExp, forKey: "currentExp")
        coder.encode(mapLevel, forKey: "mapLevel")
    }

    
    required init?(coder: NSCoder) {
//        super.init(coder: coder)
        super.init()
        self.hp = Int(coder.decodeInt32(forKey: "hp"))
        mp = Int(coder.decodeInt32(forKey: "mp"))
        currentHP = hp
        currentMP = mp
//        currentHP = Int(coder.decodeInt32(forKey: "currentHP"))
//        currentMP = Int(coder.decodeInt32(forKey: "currentMP"))
        attack = Int(coder.decodeInt32(forKey: "attack"))
        level = Int(coder.decodeInt32(forKey: "level"))
        maxExp = Int(coder.decodeInt32(forKey: "maxExp"))
        currentExp = Int(coder.decodeInt32(forKey: "currentExp"))
        mapLevel = Int(coder.decodeInt32(forKey: "mapLevel"))
    }
    
    func lxt_calculate() {
        self.totalAttack = self.attack
        self.totalMagic = self.magic
        for item in self.equipArray {
            let strongAttack = Int(Float(item.equipModel.attack * item.equipModel.strongLevel ) / 10.0)
            self.totalAttack += item.equipModel.attack + strongAttack
            let strongMagic = Int(Float(item.equipModel.magic * item.equipModel.strongLevel ) / 10.0)
            self.totalMagic += item.equipModel.magic + strongMagic
        }
    }
}
