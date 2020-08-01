//
//  LXTHeroSkillTableCell.swift
//  FantasyGame
//
//  Created by ULDD on 2020/7/27.
//  Copyright © 2020 LXT. All rights reserved.
//

import UIKit

class LXTHeroSkillTableCell: UITableViewCell {
    let width = (kScreenWidth - 35) / 6
    var array = Array<LXTSkillItem>()
    var skillArray : Array<LXTHeroSkillModel>?{
        didSet{
            self.lxt_updateUIWithData()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.lxt_initSubView()
    }
    
    
    func lxt_initSubView() -> Void {
        self.selectionStyle = .none
        for index in 0...5 {
            let skillView = LXTSkillItem()
//            skillView.backgroundColor = kRandomColor()
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
    
    func lxt_updateUIWithData() {
        for index in 0 ..< self.array.count {
            let skillView = self.array[index]
            if let model = self.skillArray?[index]{
                if model.id > 0 {
                    skillView.backgroundColor = rgb(255, 227, 150)
                    skillView.model = model
                }else{
                    skillView.model = model
                    skillView.backgroundColor = buttonDisableColor
                }
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
