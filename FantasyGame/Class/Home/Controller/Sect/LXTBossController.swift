//
//  LXTBossController.swift
//  FantasyGame
//
//  Created by ULDD on 2020/10/20.
//  Copyright © 2020 LXT. All rights reserved.
//

import UIKit

class LXTBossController: LXTBaseController {
    let bloodStrip = LXTStripProgressView()
    let bloodLabel = UILabel()
    let chanllegeButton = UIButton(type: .custom)
    var monster = LXTMonsterModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.lxt_initSubView()
    }
    
    @objc func lxt_chanllegeButtonClick(){
        let copyModel = LXTCopyModel()
        copyModel.monster = monster
        nextCopy = copyModel
        self.dismiss(animated: false) {}
    }
    
    @objc func lxt_prizeButtonClick(){
        LXTAlertView.showInfo(info: "获得宗门币 X 1000", showCancel: false, completeTitle: "确定")
    }
    
    func lxt_initSubView() {
        self.navTitleLabel.text = "宗门BOSS"
        
        monster.level = 1
        monster.hp = 1000000000
        monster.attack = monster.level * 1000
        
        self.view.addSubview(self.bloodStrip)
        self.bloodStrip.percentage = 0.8
        self.bloodStrip.backgroundColor = .gray
        self.bloodStrip.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(kNavigationBarHeight + 30)
            make.width.equalToSuperview().multipliedBy(0.7)
            make.height.equalTo(10)
        }
        
        self.bloodLabel.text = "80000/100000"
        lxt_setupLabel(label: self.bloodLabel, textColor: .white, fontName: PingFangSCRegular, fontSize: 10)
        self.view.addSubview(self.bloodLabel)
        self.bloodLabel.snp.makeConstraints { (make) in
            make.center.equalTo(self.bloodStrip)
        }
        
        lxt_borderCornerView(view: self.chanllegeButton, borderWidth: 1, borderColor: titleColor51, cornerRadius: 5)
        self.chanllegeButton.setTitle("挑战", for: .normal)
        self.chanllegeButton.setTitleColor(titleColor51, for: .normal)
        self.chanllegeButton.titleLabel?.font = UIFont(name: PingFangSCRegular, size: 12)
        self.chanllegeButton.addTarget(self, action: #selector(lxt_chanllegeButtonClick), for: .touchUpInside)
        self.view.addSubview(self.chanllegeButton)
        self.chanllegeButton.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.bloodStrip.snp.bottom).offset(50)
            make.size.equalTo(CGSize(width: 50, height: 40))
        }
        
        let prizeButton = UIButton(type: .custom)
        prizeButton.setTitle("领取", for: .normal)
        prizeButton.addTarget(self, action: #selector(lxt_prizeButtonClick), for: .touchUpInside)
        prizeButton.setTitleColor(titleColor51, for: .normal)
        prizeButton.titleLabel?.font = UIFont(name: PingFangSCRegular, size: 12)
        lxt_borderCornerView(view: prizeButton, borderWidth: 1, borderColor: titleColor51, cornerRadius: 5)
        self.view.addSubview(prizeButton)
        prizeButton.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.chanllegeButton.snp.bottom).offset(5)
            make.size.equalTo(CGSize(width: 50, height: 40))
        }
    }
}
