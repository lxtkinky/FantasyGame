//
//  LXTStrongController.swift
//  FantasyGame
//
//  Created by ULDD on 2020/8/28.
//  Copyright © 2020 LXT. All rights reserved.
//

import UIKit

class LXTStrongController: LXTBaseController {
    
    let equipBox = UIButton(type: .custom)
    let chooseView = LXTStrongChooseView()
    var selectModel : LXTGoodsModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.lxt_initSubView()
    }
    
    func lxt_initSubView() {
        self.equipBox.backgroundColor = .white
        self.equipBox.setTitle("选择", for: .normal)
        self.equipBox.setTitleColor(titleColor51, for: .normal)
        self.equipBox.titleLabel?.font = UIFont(name: PingFangSCRegular, size: 14)
        self.equipBox.layer.cornerRadius = 5
        self.equipBox.layer.borderColor = titleColor51.cgColor
        self.equipBox.layer.borderWidth = 1
        self.equipBox.clipsToBounds = true
        self.equipBox.addTarget(self, action: #selector(lxt_chooseEquipClick), for: .touchUpInside)
        self.view.addSubview(self.equipBox)
        self.equipBox.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(kNavigationBarHeight + 60)
            make.size.equalTo(CGSize(width: 80, height: 80))
        }
        
        let strongButton = UIButton(type: .custom)
        strongButton.layer.cornerRadius = 5
        strongButton.layer.borderColor = titleColor51.cgColor
        strongButton.layer.borderWidth = 1
        strongButton.clipsToBounds = true
        strongButton.addTarget(self, action: #selector(lxt_strongEquipClick), for: .touchUpInside)
        strongButton.setTitle("强化", for: .normal)
        strongButton.setTitleColor(titleColor51, for: .normal)
        strongButton.titleLabel?.font = UIFont(name: PingFangSCRegular, size: 12)
        self.view.addSubview(strongButton)
        strongButton.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.equipBox.snp.bottom).offset(20)
            make.size.equalTo(CGSize(width: 40, height: 30))
        }
        
        self.view.addSubview(self.chooseView)
        self.chooseView.isHidden = true
        self.chooseView.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        }
        weak var weakSelf = self
        self.chooseView.selectBlock = { model in
            weakSelf?.selectModel = model
            weakSelf?.equipBox.setTitle("\(model.name)+\(model.equipModel.strongLevel)", for: .normal)
        }
    }
    
    @objc func lxt_strongEquipClick() {
        if let model = self.selectModel {
            if arc4random() % 10 == 3 {
                model.equipModel.strongLevel += 1
                LXTAlertView.showInfo(info: "强化成功", showCancel: false, completeTitle: "确定")
                self.equipBox.setTitle("\(model.name)+\(model.equipModel.strongLevel)", for: .normal)
                let _ = LXTUserEquipDB.lxt_updateWithEquip(model: model.equipModel)
            }else{
                LXTAlertView.showInfo(info: "强化失败", showCancel: false, completeTitle: "确定")
            }
            
        }
    }
    
    @objc func lxt_chooseEquipClick() {
        self.chooseView.dataSource = LXTGoodsSQliteHelper.lxt_getAllEquipGoods()
        self.chooseView.isHidden = false
    }
    
}
