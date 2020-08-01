//
//  LXTHeroSkillActivityCell.swift
//  FantasyGame
//
//  Created by ULDD on 2020/7/31.
//  Copyright © 2020 LXT. All rights reserved.
//

import UIKit

class LXTHeroSkillActivityCell: UICollectionViewCell {
    let skillItem = LXTSkillItem()
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
        self.addSubview(self.skillItem)
        self.skillItem.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    func lxt_updateUIWithModel() {
        self.skillItem.model = self.model
    }
}
