//
//  LXTStripProgressView.swift
//  FantasyGame
//
//  Created by ULDD on 2020/7/14.
//  Copyright © 2020 LXT. All rights reserved.
//

import UIKit

class LXTStripProgressView: UIView {

    var percentage : CGFloat = 1.0
    var bgColor = UIColor.white
    var foregroundColor = UIColor.red
    var shapeLayer : CAShapeLayer?
    var leftDirection = true
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
//        let pathLine = UIBezierPath()
//        self.foregroundColor.setStroke()
//        pathLine.lineWidth = rect.size.height
//        if self.leftDirection {
//            pathLine.move(to: CGPoint(x: 0, y: rect.size.height / 2))
//            pathLine.addLine(to: CGPoint(x: rect.size.width * self.percentage, y: rect.size.height / 2))
//            print("startX = 0, endX = \(rect.size.width * self.percentage)")
//        }else{
//            pathLine.move(to: CGPoint(x: rect.size.width * (1 - self.percentage), y: rect.size.height / 2))
//            pathLine.addLine(to: CGPoint(x: rect.size.width, y: rect.size.height / 2))
//        }
//
//        pathLine.lineCapStyle = .round
//        pathLine.stroke()
        
        if let layer = self.shapeLayer {
            layer.removeFromSuperlayer()
        }
        
        let pathLine = UIBezierPath()
        if self.leftDirection {
            pathLine.move(to: CGPoint(x: 0, y: rect.size.height / 2))
            pathLine.addLine(to: CGPoint(x: rect.size.width * self.percentage, y: rect.size.height / 2))
        }else{
            pathLine.move(to: CGPoint(x: (1 - self.percentage) * rect.size.width, y: rect.size.height / 2))
            pathLine.addLine(to: CGPoint(x: rect.size.width, y: rect.size.height / 2))
        }
        
        let shapeLayer = CAShapeLayer()
        self.shapeLayer = shapeLayer
        shapeLayer.path = pathLine.cgPath
        shapeLayer.fillColor = kRandomColor().cgColor
        shapeLayer.strokeColor = foregroundColor.cgColor
        shapeLayer.lineWidth = rect.size.height
        self.layer.addSublayer(shapeLayer)
        
    }
}
