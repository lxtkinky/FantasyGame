//
//  LXTDateHelper.swift
//  FantasyGame
//
//  Created by ULDD on 2020/7/17.
//  Copyright © 2020 LXT. All rights reserved.
//

import UIKit

class LXTDateHelper: NSObject {
    var formmater = DateFormatter()
    
    override init() {
        super.init()
    }
    
    func lxt_stringFromDate(date : Date, format : String) -> String {
        self.formmater.dateFormat = format
        return self.formmater.string(from: date)
    }
}
