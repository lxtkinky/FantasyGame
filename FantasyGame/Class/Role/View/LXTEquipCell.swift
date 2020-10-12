//
//  LXTEquipCell.swift
//  FantasyGame
//
//  Created by ULDD on 2020/8/12.
//  Copyright © 2020 LXT. All rights reserved.
//

import UIKit

class LXTEquipCell: UICollectionViewCell {
    let equipLabel = UILabel()
    var model : LXTGoodsModel?{
        didSet{
            if model!.id > 0 {
                let strongStr = model!.equipModel.strongLevel > 0 ? "+\(model!.equipModel.strongLevel)" : ""
                self.equipLabel.text = model!.equipModel.name + strongStr
            }else{
                self.equipLabel.text = "点击更换"
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
        self.contentView.layer.borderColor = titleColor51.cgColor
        self.contentView.layer.borderWidth = 1
        self.contentView.addSubview(self.equipLabel)
        self.equipLabel.text = "点击更换"
        self.equipLabel.textAlignment = .center
        self.equipLabel.numberOfLines = 0
        self.equipLabel.font = UIFont(name: PingFangSCRegular, size: 10)
        self.equipLabel.textColor = titleColor51
        self.equipLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(5)
            make.right.equalToSuperview().offset(-5)
            make.centerY.equalToSuperview()
        }
    }
}
