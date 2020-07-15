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
    
    
    override init() {
        super.init()
        self.hp = 100
        self.currentHP = self.hp
        self.mp = 10
        self.currentMP = self.mp
        self.attack = 10
        self.level = 1
    }
    
     func encode(with coder: NSCoder) {
        coder.encode(hp, forKey: "hp")
        coder.encode(mp, forKey: "mp")
//        coder.encode(currentHP, forKey: "currentHP")
//        coder.encode(currentMP, forKey: "currentMP")
        coder.encode(attack, forKey: "attack")
        coder.encode(level, forKey: "level")
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
    }
}
