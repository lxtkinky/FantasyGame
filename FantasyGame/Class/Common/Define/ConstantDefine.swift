//
//  ConstantDefine.swift
//  FantasyGame
//
//  Created by ULDD on 2020/7/14.
//  Copyright © 2020 LXT. All rights reserved.
//

import UIKit


let kScreenWidth = UIScreen.main.bounds.width
let kScreenHeight = UIScreen.main.bounds.height

//Color
func rgb(_ red : UInt32, _ green : UInt32, _ blue : UInt32) -> UIColor {
    return UIColor(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1)
}

//rgba(17, 61, 104, 1)
func rgba(_ red : UInt32, _ green : UInt32, _ blue : UInt32, _ alpha : CGFloat) -> UIColor {
    return UIColor(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: alpha)
}

func kRandomColor() -> UIColor {
    return rgb(arc4random() % 255, arc4random() % 255, arc4random() % 255)
}

let roleBorderColor = rgb(34, 189, 130)
let roleBgColor = rgb(66, 66, 66)
let bloodColor = rgb(255, 91, 101)
let manaColor = rgb(0, 179, 248)
let titleColor51 = rgb(51, 51, 51)
let titleDisableColor = rgb(102, 102, 102)
let buttonDisableColor = rgb(200, 200, 200)
let buttonEnableColor = titleColor51
let themeColorYellow = rgba(255, 227, 150, 1)

let documentPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last

let probability = 100           //

//NotificationName
let NotificationNameUpdateHero = NSNotification.Name(rawValue: "notificationNameSaveHero")
let KNotificationAppActive = NSNotification.Name(rawValue: "KNotificationAppActive")

let KNotificationHeroSkillChange = NSNotification.Name(rawValue: "KNotificationHeroSkillChange")


//Font
let PingFangSCMedium = "PingFangSC-Medium"
let PingFangSCSemibold = "PingFangSC-Semibold"
let PingFangSCLight = "PingFangSC-Light"
let PingFangSCUltralight = "PingFangSC-Ultralight"
let PingFangSCRegular = "PingFangSC-Regular"
let PingFangSCThin = "PingFangSC-Thin"


//屏幕
let statusBarHeight = UIApplication.shared.statusBarFrame.height
var isFullScreen: Bool {
    if #available(iOS 11, *) {
          guard let w = UIApplication.shared.delegate?.window, let unwrapedWindow = w else {
              return false
          }
          
          if unwrapedWindow.safeAreaInsets.left > 0 || unwrapedWindow.safeAreaInsets.bottom > 0 {
              print(unwrapedWindow.safeAreaInsets)
              return true
          }
    }
    return false
}

var kNavigationBarHeight: CGFloat {
   //return UIApplication.shared.statusBarFrame.height == 44 ? 88 : 64
   return isFullScreen ? 88 : 64
}
    
var kBottomSafeHeight: CGFloat {
   //return UIApplication.shared.statusBarFrame.height == 44 ? 34 : 0
   return isFullScreen ? 34 : 0
}


//用户
var user = LXTUserManager().lxt_loadUser()
var heroArray = LXTRoleManager.lxt_loadAllHero()
var goodsArray = LXTGoodsSQliteHelper.lxt_getAllGoods()
var dateHelper = LXTDateHelper()



