//
//  LXTViewHelper.swift
//  FantasyGame
//
//  Created by ULDD on 2020/10/16.
//  Copyright © 2020 LXT. All rights reserved.
//

import Foundation
import UIKit

func lxt_borderCornerView(view : UIView, borderWidth : CGFloat, borderColor : UIColor, cornerRadius : CGFloat) {
    if cornerRadius > 0 {
        view.layer.cornerRadius = cornerRadius
        view.clipsToBounds = true
    }
    
    if borderWidth > 0 {
        view.layer.borderWidth = borderWidth
        view.layer.borderColor = borderColor.cgColor
    }
//    return view
}


func lxt_setupLabel(label : UILabel, textColor : UIColor, fontName : String, fontSize : CGFloat) {
    label.textColor = textColor
    label.font = UIFont(name: fontName, size: fontSize)
}
