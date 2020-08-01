//
//  LXTMonsterModel.swift
//  FantasyGame
//
//  Created by ULDD on 2020/7/14.
//  Copyright © 2020 LXT. All rights reserved.
//

import UIKit

class LXTMonsterModel: LXTRoleModel {
    override var level: Int{
        didSet{
            if level > 0 {
                self.maxExp = level * 10
                self.attack = level > 1 ? 30 * level : 10
                self.hp = 100 * level
                self.currentHP = 100 * level
            }else{
                self.maxExp = 10
                self.attack = 10
                self.hp = 100
                self.currentHP = 100 
            }
            
        }
    }
    override init() {
        super.init()
        
        self.hp = 80
        self.currentHP = self.hp
        self.mp = 10
        self.currentMP = self.mp
        self.attack = 10
        self.level = 1
        self.maxExp = level * 10
    }
    
    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//        super.init(coder: coder)
    }
}
