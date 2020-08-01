//
//  LXTGoodsCell.swift
//  FantasyGame
//
//  Created by ULDD on 2020/7/28.
//  Copyright © 2020 LXT. All rights reserved.
//

import UIKit

class LXTGoodsCell: UICollectionViewCell {
    let goodsName = UILabel()
    let countLabel = UILabel()
    var goods : LXTGoodsModel?{
        didSet{
            self.lxt_updateUIWithModel()
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.lxt_initSubView()
    }
    
    func lxt_initSubView() -> Void {
        self.goodsName.font = UIFont(name: PingFangSCRegular, size: 12)
        self.goodsName.textColor = titleColor51
        self.contentView.addSubview(self.goodsName)
        self.goodsName.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
        
        
        self.countLabel.font = UIFont(name: PingFangSCRegular, size: 10)
        self.countLabel.textColor = titleColor51
        self.contentView.addSubview(self.countLabel)
        self.countLabel.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-5)
            make.bottom.equalToSuperview().offset(-5)
        }
    }
    
    func lxt_updateUIWithModel() {
        self.goodsName.text = self.goods?.name
        self.countLabel.text = String(self.goods!.count)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
