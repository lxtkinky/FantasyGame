//
//  LXTSkillItem.swift
//  FantasyGame
//
//  Created by ULDD on 2020/7/31.
//  Copyright © 2020 LXT. All rights reserved.
//

import UIKit

class LXTSkillItem: UIView {
    let skillNameLabel = UILabel()
    var model : LXTHeroSkillModel?{
        didSet{
            self.lxt_updateUIWithModel()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.lxt_initSubView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func lxt_initSubView() {
        self.skillNameLabel.font = UIFont(name: PingFangSCRegular, size: 12)
        self.skillNameLabel.textColor = titleColor51
        self.addSubview(self.skillNameLabel)
        self.skillNameLabel.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
    }
    
    func lxt_updateUIWithModel() {
        self.skillNameLabel.text = self.model?.skill?.name
    }

}
