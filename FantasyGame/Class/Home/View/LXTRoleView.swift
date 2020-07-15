//
//  LXTRoleView.swift
//  FantasyGame
//
//  Created by ULDD on 2020/7/14.
//  Copyright © 2020 LXT. All rights reserved.
//

import UIKit

class LXTRoleView: UIView {
    var bloodStrip = LXTStripProgressView()
    var bloodLabel = UILabel.init()
    var role : LXTRoleModel?{
        didSet{
            self.lxt_updateBlood()
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.lxt_initSubView()
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func lxt_initSubView() -> Void {
        self.addSubview(self.bloodStrip)
        self.bloodStrip.percentage = 1
//        self.bloodStrip.layer.borderWidth = 1
//        self.bloodStrip.layer.borderColor = UIColor.blue.cgColor
        self.bloodStrip.backgroundColor = .lightGray
        self.bloodStrip.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        self.addSubview(self.bloodLabel)
        self.bloodLabel.text = "0/0"
        self.bloodLabel.font = UIFont.systemFont(ofSize: 6)
        self.bloodLabel.textColor = .white
        self.bloodLabel.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
    }

    func lxt_updateBlood() -> Void {
        if let role = self.role{
            let currentHP = role.currentHP > 0 ? role.currentHP : 0
            self.bloodLabel.text = "\(role.hp)/\(currentHP)"
            self.bloodStrip.percentage = CGFloat(currentHP) / CGFloat(role.hp)
            print("blood per = \(self.bloodStrip.percentage)")
            self.bloodStrip.setNeedsDisplay()
        }

    }
}
