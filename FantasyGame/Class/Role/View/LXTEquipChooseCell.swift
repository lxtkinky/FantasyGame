//
//  LXTEquipChooseCell.swift
//  FantasyGame
//
//  Created by ULDD on 2020/8/14.
//  Copyright © 2020 LXT. All rights reserved.
//

import UIKit

class LXTEquipChooseCell: UICollectionViewCell {
    let nameLabel = UILabel()
    let useButton = UIButton(type: .custom)
    var useBlock : ((_ model : LXTGoodsModel) -> Void)?
    var model : LXTGoodsModel?{
        didSet{
            if let _ = model {
                self.useButton.isHidden = false
                if model?.userEquip?.heroID != 0 {
                    self.useButton.setTitle("卸下", for: .normal)
                }else{
                    self.useButton.setTitle("装备", for: .normal)
                }
                self.nameLabel.text = model?.equipModel.name
            }else{
                self.useButton.isHidden = true
                self.nameLabel.text = ""
            }
            
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
        self.contentView.layer.borderWidth = 1
        self.contentView.layer.borderColor = themeColorYellow.cgColor
        self.contentView.layer.cornerRadius = 5
        self.contentView.clipsToBounds = true
        
        self.nameLabel.font = UIFont(name: PingFangSCRegular, size: 14)
        self.nameLabel.textColor = titleColor51
        self.contentView.addSubview(self.nameLabel)
        self.nameLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10)
            make.centerY.equalToSuperview()
        }
        
        self.useButton.setTitle("装备", for: .normal)
        self.useButton.setTitleColor(titleColor51, for: .normal)
        self.useButton.addTarget(self, action: #selector(lxt_useClick), for: .touchUpInside)
        self.useButton.layer.cornerRadius = 5.0
        self.useButton.titleLabel?.font = UIFont(name: PingFangSCRegular, size: 14)
        self.useButton.clipsToBounds = true
        self.useButton.layer.borderColor = themeColorYellow.cgColor
        self.useButton.layer.borderWidth = 1
        self.contentView.addSubview(self.useButton)
        self.useButton.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-10)
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 60, height: 40))
        }
    }
    
    @objc func lxt_useClick() {
        if let _ = self.model {
            self.useBlock?(self.model!)
        }
        
    }
}
