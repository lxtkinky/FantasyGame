//
//  LXTMapCell.swift
//  FantasyGame
//
//  Created by ULDD on 2020/11/9.
//  Copyright © 2020 LXT. All rights reserved.
//

import UIKit

class LXTMapCell: UITableViewCell {
    let mapName = UILabel()
    let monsterName = UILabel()
    let fallLabel = UILabel()
    let challengeButton = UIButton(type: .custom)
    let hangUpLabel = UILabel()
    var monster : LXTMonsterModel?{
        didSet{
            self.lxt_updateUIWithModel()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.lxt_initSubView()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.lxt_initSubView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

    func lxt_initSubView() {
        let boxView = UIView()
        lxt_borderCornerView(view: boxView, borderWidth: 1, borderColor: titleColor51, cornerRadius: 5)
        self.contentView.addSubview(boxView)
        boxView.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview().offset(5)
            make.right.equalToSuperview().offset(-5)
            make.bottom.equalToSuperview()
        }
        
        lxt_setupLabel(label: self.mapName, textColor: titleColor51, fontName: PingFangSCSemibold, fontSize: 12)
        self.contentView.addSubview(self.mapName)
        self.mapName.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10)
            make.top.equalToSuperview().offset(15)
        }
        
        lxt_setupLabel(label: self.monsterName, textColor: titleColor51, fontName: PingFangSCRegular, fontSize: 10)
        self.contentView.addSubview(self.monsterName)
        self.monsterName.snp.makeConstraints { (make) in
            make.left.equalTo(self.mapName)
            make.bottom.equalToSuperview().offset(-10)
        }
        
        lxt_setupLabel(label: self.fallLabel, textColor: titleColor51, fontName: PingFangSCRegular, fontSize: 10)
        self.contentView.addSubview(self.fallLabel)
        self.fallLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.monsterName.snp.right).offset(10)
            make.centerY.equalTo(self.monsterName)
        }
        
        lxt_setupLabel(label: self.hangUpLabel, textColor: titleColor51, fontName: PingFangSCRegular, fontSize: 10)
        self.hangUpLabel.text = "挂机中..."
        self.hangUpLabel.isHidden = true
        self.contentView.addSubview(self.hangUpLabel)
        self.hangUpLabel.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-10)
            make.centerY.equalTo(self.mapName)
        }
        
        lxt_borderCornerView(view: self.challengeButton, borderWidth: 1, borderColor: titleColor51, cornerRadius: 5)
        self.challengeButton.setTitle("挑战", for: .normal)
        self.challengeButton.setTitleColor(titleColor51, for: .normal)
        self.challengeButton.titleLabel?.font = UIFont(name: PingFangSCRegular, size: 12)
        self.contentView.addSubview(self.challengeButton)
        self.challengeButton.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview().offset(-10)
            make.size.equalTo(CGSize(width: 40, height: 30))
        }
    }
    
    func lxt_updateUIWithModel() {
        self.mapName.text = self.monster!.name
        self.monsterName.text = "怪物：\(self.monster!.name)"
        self.fallLabel.text = "掉落：经验 x \(self.monster!.maxExp)"
    }
}
