//
//  LXTExpStripView.swift
//  FantasyGame
//
//  Created by ULDD on 2020/7/18.
//  Copyright © 2020 LXT. All rights reserved.
//

import UIKit

class LXTExpStripView: UIView {
    let expLabel = UILabel()
    var shapeLayer : CAShapeLayer?
    var percentage = CGFloat(0.0)
    let exp = LXTStripProgressView()
    var hero : LXTHeroModel?{
        didSet{
            if let hero = self.hero {
//                print(" currentExp = \(hero.currentExp), maxExp = \(hero.maxExp)")
                self.percentage = CGFloat(hero.currentExp) / CGFloat(hero.maxExp)
                self.expLabel.text = "\(hero.currentExp)/\(hero.maxExp)"
                self.setNeedsDisplay()
            }
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.lightGray
        
        self.addSubview(self.expLabel)
        self.expLabel.font = UIFont(name: PingFangSCRegular, size: 10)
        self.expLabel.textColor = .white
        self.expLabel.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        if let layer = self.shapeLayer{
            layer.removeFromSuperlayer()
        }

        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: rect.size.height / 2))
        path.addLine(to: CGPoint(x: rect.size.width * self.percentage, y: rect.size.height / 2))

        self.shapeLayer = CAShapeLayer()
        self.shapeLayer?.strokeColor = UIColor.blue.cgColor
        self.shapeLayer?.path = path.cgPath
        self.shapeLayer?.lineWidth = rect.size.height
//        self.layer.addSublayer(self.shapeLayer!)
        self.layer.insertSublayer(self.shapeLayer!, at: 0)
    }
}
