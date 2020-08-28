//
//  LXTSkillLibCell.swift
//  FantasyGame
//
//  Created by ULDD on 2020/7/28.
//  Copyright © 2020 LXT. All rights reserved.
//

import UIKit

class LXTSkillLibCell: UICollectionViewCell {
    let skillName = UILabel()
    let priceLabel = UILabel()
    let buyButton = UIButton(type: .custom)
    var buyBlock : ((_ model : LXTSkillModel) -> Void)?
    var skillModel : LXTSkillModel?{
        didSet{
            print("skill id = \(self.skillModel!.id)")
            self.skillName.text = self.skillModel?.name
            self.priceLabel.text = String(self.skillModel!.priceCount)
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.lxt_initSubView()
    }
    
    func lxt_initSubView() -> Void {
        self.contentView.layer.cornerRadius = 5.0
        self.contentView.clipsToBounds = true
//        self.contentView.backgroundColor = kRandomColor()
        self.contentView.layer.borderColor = titleColor51.cgColor
        self.contentView.layer.borderWidth = 1
        
        self.skillName.font = UIFont(name: PingFangSCRegular, size: 12)
        self.skillName.textColor = titleColor51
        self.contentView.addSubview(self.skillName)
        self.skillName.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(10)
        }
        
        self.buyButton.setTitle("购买", for: .normal)
        self.buyButton.addTarget(self, action: #selector(lxt_buyClick), for: .touchUpInside)
        self.buyButton.setTitleColor(titleColor51, for: .normal)
        self.buyButton.titleLabel?.font = UIFont(name: PingFangSCRegular, size: 12)
        self.buyButton.layer.cornerRadius = 4.0
        self.buyButton.clipsToBounds = true
        self.buyButton.layer.borderColor = titleColor51.cgColor
        self.buyButton.layer.borderWidth = 1
        self.contentView.addSubview(self.buyButton)
        self.buyButton.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-10)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 40, height: 20))
        }
        
        self.priceLabel.font = UIFont(name: PingFangSCRegular, size: 12)
        self.contentView.addSubview(self.priceLabel)
        self.priceLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(self.buyButton.snp.top).offset(-5)
        }
    }
    
    @objc func lxt_buyClick() -> Void {
        if let buyBlock = self.buyBlock {
            buyBlock(self.skillModel!)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
