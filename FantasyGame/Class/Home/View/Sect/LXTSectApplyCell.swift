//
//  LXTSectApplyCell.swift
//  FantasyGame
//
//  Created by ULDD on 2020/10/14.
//  Copyright © 2020 LXT. All rights reserved.
//

import UIKit

class LXTSectApplyCell: UICollectionViewCell {
    var nameLabel = UILabel()
    var countLabel = UILabel()
    var applyButton = UIButton(type: .custom)
    var applyAction : ((_ sectId : Int)->Void)?
    var model : LXTSectModel?{
        didSet{
            self.lxt_updateUI()
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.lxt_initSubView()
    }
    
    func lxt_initSubView() {
        self.contentView.layer.cornerRadius = 5
        self.contentView.clipsToBounds = true
        self.contentView.layer.borderColor = titleColor51.cgColor
        self.contentView.layer.borderWidth = 1
        
        self.nameLabel.font = UIFont(name: PingFangSCMedium, size: 14)
        self.nameLabel.text = "宗门名称"
        self.nameLabel.textColor = titleColor51
        self.contentView.addSubview(self.nameLabel)
        self.nameLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10)
            make.centerY.equalToSuperview()
        }
        
        self.applyButton.setTitle("申请", for: .normal)
        self.applyButton.addTarget(self, action: #selector(applyButtonClick), for: .touchUpInside)
        self.applyButton.layer.borderColor = titleColor51.cgColor
        self.applyButton.layer.borderWidth = 1
        self.applyButton.clipsToBounds = true
        self.applyButton.layer.cornerRadius = 4
        self.applyButton.setTitleColor(titleColor51, for: .normal)
        self.applyButton.titleLabel?.font = UIFont(name: PingFangSCRegular, size: 12)
        self.contentView.addSubview(self.applyButton)
        self.applyButton.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-10)
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 50, height: 40))
        }
        
        self.countLabel.font = UIFont(name: PingFangSCRegular, size: 12)
        self.countLabel.textColor = titleColor51
        self.countLabel.text = "0/10"
        self.contentView.addSubview(self.countLabel)
        self.countLabel.snp.makeConstraints { (make) in
            make.right.equalTo(self.applyButton.snp.left).offset(-10)
            make.centerY.equalToSuperview()
        }
    }
    
    func lxt_updateUI() {
        self.nameLabel.text = self.model?.sectName
        self.countLabel.text = "\(self.model!.currentNum) / \(self.model!.maxNum)"
    }
    
    @objc func applyButtonClick() {
        self.applyAction?(self.model!.sectId)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
