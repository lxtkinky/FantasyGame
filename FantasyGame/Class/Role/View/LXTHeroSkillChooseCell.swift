//
//  LXTHeroSkillChooseCell.swift
//  FantasyGame
//
//  Created by ULDD on 2020/7/31.
//  Copyright © 2020 LXT. All rights reserved.
//

import UIKit

class LXTHeroSkillChooseCell: UICollectionViewCell {
    let skillNameLabel = UILabel()
    let activityButton = UIButton(type: .custom)
    var activityBlock : ((_ model : LXTHeroSkillModel) -> Void)?
    var heroSkill : LXTHeroSkillModel?{
        didSet{
            self.lxt_updateUIWithModel()
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.lxt_initSubView()
    }
    
    func lxt_initSubView() -> Void {
        self.skillNameLabel.font = UIFont(name: PingFangSCRegular, size: 14)
        self.skillNameLabel.textColor = titleColor51
        self.contentView.addSubview(self.skillNameLabel)
        self.skillNameLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(10)
        }
        
        self.activityButton.setTitle("装备", for: .normal)
        self.activityButton.setTitleColor(titleColor51, for: .normal)
        self.activityButton.layer.borderColor = rgba(17, 61, 104, 1).cgColor
        self.activityButton.layer.borderWidth = 1.0
        self.activityButton.layer.cornerRadius = 3
        self.activityButton.clipsToBounds = true
        self.activityButton.titleLabel?.font = UIFont(name: PingFangSCRegular, size: 12)
        self.activityButton.addTarget(self, action: #selector(lxt_activityButtonClick), for: .touchUpInside)
        self.contentView.addSubview(self.activityButton)
        self.activityButton.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-10)
            make.size.equalTo(CGSize(width: 60, height: 40))
        }
    }
    
    @objc func lxt_activityButtonClick() -> Void {
//        self.heroSkill?.enable = !self.heroSkill!.enable
        if let block = self.activityBlock {
            block(self.heroSkill!)
        }
    }
    
    func lxt_updateUIWithModel() -> Void {
        self.skillNameLabel.text = self.heroSkill?.skill?.name
        
        if self.heroSkill!.enable {
            self.activityButton.setTitle("卸载", for: .normal)
        }else{
            self.activityButton.setTitle("装备", for: .normal)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
