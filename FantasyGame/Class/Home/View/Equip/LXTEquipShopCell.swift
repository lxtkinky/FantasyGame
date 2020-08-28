//
//  LXTEquipShopCell.swift
//  FantasyGame
//
//  Created by ULDD on 2020/8/10.
//  Copyright © 2020 LXT. All rights reserved.
//

import UIKit

class LXTEquipShopCell: UICollectionViewCell {
    let equipName = UILabel()
    let priceLabel = UILabel()
    let buyButton = UIButton(type: .custom)
    var buyBlock : ((_ model : LXTEquipModel) -> Void)?
    var equipModel : LXTEquipModel?{
        didSet{
            self.equipName.text = self.equipModel?.name
            switch self.equipModel!.buyType {
            case 1:
                self.priceLabel.text = "金币：" + String(self.equipModel!.priceCount)
            case 2:
                self.priceLabel.text = "元宝：" + String(self.equipModel!.priceCount)
            default:
                self.priceLabel.text = "材料：" + String(self.equipModel!.priceCount)
            }
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.lxt_initSubView()
    }
    
    func lxt_initSubView() -> Void {
        self.contentView.layer.cornerRadius = 5.0
        self.contentView.clipsToBounds = true
        self.contentView.layer.borderColor = titleColor51.cgColor
        self.contentView.layer.borderWidth = 1
        
        self.equipName.font = UIFont(name: PingFangSCRegular, size: 12)
        self.equipName.textColor = titleColor51
        self.contentView.addSubview(self.equipName)
        self.equipName.snp.makeConstraints { (make) in
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
            buyBlock(self.equipModel!)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
