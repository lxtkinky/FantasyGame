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
    
    var hp = 0
    var mp = 0
    var currentHP = 0
    var currentMP = 0
    var attack = 0
    var level = 1
}
