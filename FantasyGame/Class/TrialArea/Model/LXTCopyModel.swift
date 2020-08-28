//
//  LXTCopyModel.swift
//  FantasyGame
//
//  Created by ULDD on 2020/8/17.
//  Copyright © 2020 LXT. All rights reserved.
//

import UIKit

class LXTCopyModel: NSObject {
    var id = 0
    var name = ""
    var couponCost = 1
    var level = 1
    var monster = LXTMonsterModel()
    var sundries = Array<LXTGoodsModel>()
    var isTrailCopy = false
}
