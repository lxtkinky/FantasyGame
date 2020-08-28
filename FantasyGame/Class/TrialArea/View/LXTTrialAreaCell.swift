//
//  LXTTrialAreaself.swift
//  FantasyGame
//
//  Created by ULDD on 2020/8/20.
//  Copyright © 2020 LXT. All rights reserved.
//

import UIKit

class LXTTrialAreaCell: UICollectionViewCell{
    let nameLabel = UILabel()
    let countLabel = UILabel()
    let levelLabel = UILabel()
    let currCountLabel = UILabel()
    let showButton = UIButton(type: .custom)
    let challengeButton = UIButton(type: .custom)
    let batchButton = UIButton(type: .custom)
    let getButton = UIButton(type: .custom)
    var challengeBlock : (() -> Void)?
    var userModel : LXTUserModel?{
        didSet{
            if let _ = userModel {
                self.lxt_updateUIWithModel()
            }
        }
    }
//    var model : LXTCopyModel?{
//        didSet{
//            self.lxt_updateUIWithModel()
//        }
//    }
    
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
        self.nameLabel.text = "试练塔"
        self.nameLabel.textColor = titleColor51
        self.contentView.addSubview(self.nameLabel)
        self.nameLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10)
            make.top.equalToSuperview().offset(10)
        }
        
        self.countLabel.font = UIFont(name: PingFangSCRegular, size: 12)
        self.countLabel.textColor = titleColor51
        self.contentView.addSubview(self.countLabel)
        self.countLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.nameLabel)
            make.bottom.equalToSuperview().offset(-10)
        }
        
        self.currCountLabel.font = UIFont(name: PingFangSCRegular, size: 12)
        self.currCountLabel.textColor = titleColor51
        self.contentView.addSubview(self.currCountLabel)
        self.currCountLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.nameLabel)
            make.bottom.equalTo(self.countLabel.snp.top).offset(2)
        }
        
        self.levelLabel.font = UIFont(name: PingFangSCRegular, size: 12)
        self.levelLabel.textColor = titleColor51
        self.contentView.addSubview(self.levelLabel)
        self.levelLabel.snp.makeConstraints { (make) in
            make.center.equalTo(self.contentView)
        }
        
        let buttonSize = CGSize(width: 50, height: 40)
        
        self.batchButton.setTitle("扫荡", for: .normal)
        self.batchButton.addTarget(self, action: #selector(lxt_batchChanllegeClick), for: .touchUpInside)
        self.batchButton.setTitleColor(titleColor51, for: .normal)
        self.batchButton.titleLabel?.font = UIFont(name: PingFangSCRegular, size: 12)
        self.batchButton.layer.cornerRadius = 5
        self.batchButton.layer.borderColor = titleColor51.cgColor
        self.batchButton.layer.borderWidth = 1
        self.batchButton.clipsToBounds = true
        self.contentView.addSubview(self.batchButton)
        self.batchButton.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview().offset(-5)
            make.size.equalTo(buttonSize)
            
        }
        
        self.challengeButton.setTitle("挑战", for: .normal)
        self.challengeButton.addTarget(self, action: #selector(lxt_challengeClick), for: .touchUpInside)
        self.challengeButton.setTitleColor(titleColor51, for: .normal)
        self.challengeButton.titleLabel?.font = UIFont(name: PingFangSCRegular, size: 12)
        self.challengeButton.layer.cornerRadius = 5
        self.challengeButton.layer.borderColor = titleColor51.cgColor
        self.challengeButton.layer.borderWidth = 1
        self.challengeButton.clipsToBounds = true
        self.contentView.addSubview(self.challengeButton)
        self.challengeButton.snp.makeConstraints { (make) in
            make.right.equalTo(self.batchButton.snp.left).offset(-10)
            make.bottom.equalToSuperview().offset(-5)
            make.size.equalTo(buttonSize)
        }
        
        
        
        self.getButton.setTitle("领取", for: .normal)
        self.getButton.addTarget(self, action: #selector(lxt_getPrize), for: .touchUpInside)
        self.getButton.setTitleColor(titleColor51, for: .normal)
        self.getButton.titleLabel?.font = UIFont(name: PingFangSCRegular, size: 12)
        self.getButton.layer.cornerRadius = 5
        self.getButton.layer.borderColor = titleColor51.cgColor
        self.getButton.layer.borderWidth = 1
        self.getButton.clipsToBounds = true
        self.contentView.addSubview(self.getButton)
        self.getButton.snp.makeConstraints { (make) in
            make.right.equalTo(self.batchButton)
            make.top.equalToSuperview().offset(5)
            make.size.equalTo(buttonSize)
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
            make.right.equalTo(self.getButton.snp.left).offset(-10)
            make.top.equalToSuperview().offset(5)
            make.size.equalTo(buttonSize)
        }
    }
    
    @objc func lxt_challengeClick() {
        self.challengeBlock?()
    }
    
    @objc func lxt_getPrize() {
        if !self.userModel!.hasGetPrize {
            user.hasGetPrize = true
            self.userModel = user
            LXTUserManager().lxt_saveUser(user: user)
            
            let goods = LXTGoodsModel()
            goods.type = GoodsType.sundries
            goods.name = "副本券"
            goods.relationID = SundriesType.coupon.rawValue
            goods.count = user.trialCount / 10 + 1
            goods.desc = "副本券，可以用于挑战副本"
            let _ = LXTGoodsSQliteHelper.lxt_addGoods(goods: goods)
            LXTAlertView.showInfo(info: "\(goods.name) x \(goods.count)", showCancel: false, completeTitle: "确定")
        }
    }
    
    @objc func lxt_batchChanllegeClick() {
        if self.userModel!.challengeCount < self.userModel!.totalChallengeCount {
            if self.userModel!.trialCount % 10 == 0 {
                return
            }
            var count = self.userModel!.trialCount % 10
            count = min(10 - count, self.userModel!.totalChallengeCount - self.userModel!.challengeCount)
            user.trialCount += count
            user.challengeCount += count
            LXTUserManager().lxt_saveUser(user: user)
            self.userModel = user
        }
    }
    
    func lxt_updateUIWithModel() {
//        self.nameLabel.text = self.userModel!.name
        self.levelLabel.text = "等级：10"
        self.currCountLabel.text = "层数：\(self.userModel!.trialCount)"
        self.countLabel.text = "挑战： \(self.userModel!.totalChallengeCount - self.userModel!.challengeCount)/\(self.userModel!.totalChallengeCount)"
        self.getButton.setTitle(self.userModel!.hasGetPrize ? "已领" : "领取", for: .normal)
        
    }
}
