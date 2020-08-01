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
    
    func encode(with coder: NSCoder) {
        coder.encode(self.userName, forKey: "userName")
        coder.encode(self.password, forKey: "password")
        coder.encode(self.nickName, forKey: "nickName")
        coder.encode(self.goldNum, forKey: "goldNum")
        coder.encode(self.ybNum, forKey: "ybNum")
    }
    
    required init?(coder: NSCoder) {
        userName = coder.decodeObject(forKey: "userName") as! String
        password = coder.decodeObject(forKey: "password") as! String
        nickName = coder.decodeObject(forKey: "nickName") as! String
        goldNum = Int(coder.decodeInt32(forKey: "goldNum"))
        ybNum = Int(coder.decodeInt32(forKey: "ybNum"))
    }
    
    var userName = ""
    var password = ""
    var nickName = ""
    var goldNum = 0
    var ybNum = 0
    
    override init() {
        super.init()
    }
}
