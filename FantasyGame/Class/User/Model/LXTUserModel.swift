//
//  LXTUserModel.swift
//  FantasyGame
//
//  Created by ULDD on 2020/7/28.
//  Copyright © 2020 LXT. All rights reserved.
//

import UIKit

class LXTUserModel: LXTBaseModel,NSSecureCoding {
    static var supportsSecureCoding: Bool = true
    var userName = ""
    var password = ""
    var nickName = ""
    var goldNum = 0
    var ybNum = 0
    var userID = 0      //由服务器分配
    var trialCount = 0      //试练塔层数
    var totalChallengeCount = 10      //今日可用挑战次数
    var challengeCount = 0              //今日已挑战次数   //可用挑战次数
    var lastDate = ""
    var hasGetPrize = false             //是否可以领取奖励
    var mapIndex = 1                    //地图索引
    
    //获取物品列表的时候赋值
    var couponModel : LXTGoodsModel = LXTGoodsModel()
    var stone = LXTGoodsModel()
    var sectId = 0      //宗门ID
    
    override init() {
        super.init()
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(self.userName, forKey: "userName")
        coder.encode(self.password, forKey: "password")
        coder.encode(self.nickName, forKey: "nickName")
        coder.encode(self.goldNum, forKey: "goldNum")
        coder.encode(self.ybNum, forKey: "ybNum")
        coder.encode(self.userID, forKey: "userID")
        coder.encode(self.trialCount, forKey: "trialCount")
        coder.encode(self.totalChallengeCount, forKey: "totalChallengeCount")
        coder.encode(self.challengeCount, forKey: "challengeCount")
        coder.encode(self.lastDate, forKey: "lastDate")
        coder.encode(self.hasGetPrize, forKey: "hasGetPrize")
        coder.encode(self.mapIndex, forKey: "mapIndex")
    }
    
    required init?(coder: NSCoder) {
        userName = coder.decodeObject(forKey: "userName") as! String
        password = coder.decodeObject(forKey: "password") as! String
        nickName = coder.decodeObject(forKey: "nickName") as! String
        goldNum = Int(coder.decodeInt32(forKey: "goldNum"))
        ybNum = Int(coder.decodeInt32(forKey: "ybNum"))
        userID = Int(coder.decodeInt32(forKey: "userID"))
        trialCount = Int(coder.decodeInt32(forKey: "trialCount"))
        totalChallengeCount = Int(coder.decodeInt32(forKey: "totalChallengeCount"))
        challengeCount = Int(coder.decodeInt32(forKey: "challengeCount"))
        lastDate = coder.decodeObject(forKey: "lastDate") as! String
        hasGetPrize = coder.decodeBool(forKey: "hasGetPrize")
        mapIndex = Int(coder.decodeInt32(forKey: "mapIndex"))
    }
    
    
}
