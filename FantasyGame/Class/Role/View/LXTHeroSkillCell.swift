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
    let skillLabel = UILabel()
    var skill : LXTSkillModel?{
        didSet{
            if let model = self.skill {
                self.skillLabel.text = model.name
            }else{
                self.skillLabel.text = "点击设置"
            }
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.lxt_initSubView()
    }
    
    func lxt_initSubView() {
        self.contentView.layer.borderColor = titleColor51.cgColor
        self.contentView.layer.borderWidth = 1
        self.contentView.addSubview(self.skillLabel)
        self.skillLabel.text = "点击设置"
        self.skillLabel.text = "点击更换"
        self.skillLabel.numberOfLines = 0
        self.skillLabel.font = UIFont(name: PingFangSCRegular, size: 10)
        self.skillLabel.textColor = titleColor51
        self.skillLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(5)
            make.right.equalToSuperview().offset(-5)
            make.centerY.equalToSuperview()
        }
    }
    
//    func lxt_initSubView() -> Void {
//        for index in 0...5 {
//            let skillView = UIView()
//            skillView.backgroundColor = kRandomColor()
//            self.array.append(skillView)
//            self.contentView.addSubview(skillView)
//            skillView.snp.makeConstraints { (make) in
//                if index == 0{
//                    make.left.equalToSuperview().offset(5)
//                }else{
//                    let preView = self.array[index - 1]
//                    make.left.equalTo(preView.snp.right).offset(5)
//                }
//
//                make.centerY.equalToSuperview()
//                make.size.equalTo(CGSize(width: width, height: width))
//
//            }
//        }
//    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
