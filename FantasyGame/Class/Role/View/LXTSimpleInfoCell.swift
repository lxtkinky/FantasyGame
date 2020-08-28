//
//  LXTSimpleInfoCell.swift
//  FantasyGame
//
//  Created by ULDD on 2020/8/11.
//  Copyright © 2020 LXT. All rights reserved.
//

import UIKit

class LXTSimpleInfoCell: UICollectionViewCell {
    let infoLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(self.infoLabel)
        self.infoLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10)
            make.centerY.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
