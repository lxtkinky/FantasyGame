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

func rgb(_ red : UInt32, _ green : UInt32, _ blue : UInt32) -> UIColor {
    return UIColor(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1)
}

func kRandomColor() -> UIColor {
    return rgb(arc4random() % 255, arc4random() % 255, arc4random() % 255)
}

let roleBorderColor = rgb(34, 189, 130)
let roleBgColor = rgb(66, 66, 66)
let bloodColor = rgb(255, 91, 101)
let manaColor = rgb(0, 179, 248)

let documentPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last
