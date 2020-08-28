//
//  LXTCopyCell.swift
//  FantasyGame
//
//  Created by ULDD on 2020/8/21.
//  Copyright © 2020 LXT. All rights reserved.
//

import UIKit

class LXTCopyCell: UICollectionViewCell {
    let nameLabel = UILabel()
    let costLabel = UILabel()
    let levelLabel = UILabel()
    let showButton = UIButton(type: .custom)
    let challengeButton = UIButton(type: .custom)
    var challengeBlock : ((_ model : LXTCopyModel) -> Void)?
    var model : LXTCopyModel?{
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
        self.contentView.layer.borderColor = titleColor51.cgColor
        self.contentView.layer.borderWidth = 1
        self.contentView.clipsToBounds = true
        self.contentView.layer.cornerRadius = 5
        
        self.nameLabel.font = UIFont(name: PingFangSCMedium, size: 18)
        self.nameLabel.textColor = titleColor51
        self.contentView.addSubview(self.nameLabel)
        self.nameLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10)
            make.top.equalToSuperview().offset(10)
        }
        
        self.costLabel.font = UIFont(name: PingFangSCRegular, size: 12)
        self.costLabel.textColor = titleColor51
        self.contentView.addSubview(self.costLabel)
        self.costLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.nameLabel)
            make.bottom.equalToSuperview().offset(-10)
        }
        
        self.levelLabel.font = UIFont(name: PingFangSCRegular, size: 12)
        self.levelLabel.textColor = titleColor51
        self.contentView.addSubview(self.levelLabel)
        self.levelLabel.snp.makeConstraints { (make) in
            make.center.equalTo(self.contentView)
        }
        
        self.challengeButton.setTitle("挑战", for: .normal)
        self.challengeButton.addTarget(self, action: #selector(lxt_chanllengeClick), for: .touchUpInside)
        self.challengeButton.setTitleColor(titleColor51, for: .normal)
        self.challengeButton.titleLabel?.font = UIFont(name: PingFangSCRegular, size: 12)
        self.challengeButton.layer.cornerRadius = 5
        self.challengeButton.layer.borderColor = titleColor51.cgColor
        self.challengeButton.layer.borderWidth = 1
        self.challengeButton.clipsToBounds = true
        self.contentView.addSubview(self.challengeButton)
        self.challengeButton.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview().offset(-5)
            make.size.equalTo(CGSize(width: 50, height: 40))
        }
        
        self.showButton.setTitle("查看", for: .normal)
        self.showButton.setTitleColor(titleColor51, for: .normal)
        self.showButton.titleLabel?.font = UIFont(name: PingFangSCRegular, size: 12)
        self.showButton.layer.cornerRadius = 5
        self.showButton.layer.borderColor = titleColor51.cgColor
        self.showButton.layer.borderWidth = 1
        self.showButton.clipsToBounds = true
        self.contentView.addSubview(self.showButton)
        self.showButton.snp.makeConstraints { (make) in
            make.right.equalTo(self.challengeButton)
            make.top.equalToSuperview().offset(5)
            make.size.equalTo(CGSize(width: 50, height: 40))
        }
    }
    
    @objc func lxt_chanllengeClick() {
        self.challengeBlock?(self.model!)
    }
    
    func lxt_updateUIWithModel() {
        self.nameLabel.text = self.model!.name
        self.levelLabel.text = "等级\(self.model!.level)"
        self.costLabel.text = "副本券 x \(self.model!.couponCost)"
    }
}
