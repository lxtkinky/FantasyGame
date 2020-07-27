//
//  LXTHeroSkillCell.swift
//  FantasyGame
//
//  Created by ULDD on 2020/7/27.
//  Copyright © 2020 LXT. All rights reserved.
//

import UIKit

class LXTHeroSkillCell: UICollectionViewCell {
    let width = (kScreenWidth - 35) / 6
    var array = Array<UIView>()
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.lxt_initSubView()
    }
    
    func lxt_initSubView() -> Void {
        for index in 0...5 {
            let skillView = UIView()
            skillView.backgroundColor = kRandomColor()
            self.array.append(skillView)
            self.contentView.addSubview(skillView)
            skillView.snp.makeConstraints { (make) in
                if index == 0{
                    make.left.equalToSuperview().offset(5)
                }else{
                    let preView = self.array[index - 1]
                    make.left.equalTo(preView.snp.right).offset(5)
                }
                
                make.centerY.equalToSuperview()
                make.size.equalTo(CGSize(width: width, height: width))
                
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
