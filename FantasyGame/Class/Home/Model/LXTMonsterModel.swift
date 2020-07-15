//
//  LXTMonsterModel.swift
//  FantasyGame
//
//  Created by ULDD on 2020/7/14.
//  Copyright © 2020 LXT. All rights reserved.
//

import UIKit

class LXTMonsterModel: LXTRoleModel {
    override init() {
        super.init()
        
        self.hp = 80
        self.currentHP = self.hp
        self.mp = 10
        self.currentMP = self.mp
        self.attack = 10
        self.level = 1
    }
    
    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//        super.init(coder: coder)
    }
}
