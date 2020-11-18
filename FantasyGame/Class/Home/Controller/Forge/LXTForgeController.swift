//
//  LXTForgeController.swift
//  FantasyGame
//
//  Created by ULDD on 2020/10/21.
//  Copyright © 2020 LXT. All rights reserved.
//

import UIKit

class LXTForgeController: UIViewController {

    let drawingBox = UIButton(type: .custom)
    let chooseView = LXTStrongChooseView()
    var dataSource = Array<String>()
    var selectModel : LXTGoodsModel?
    let costGoldLabel  = UILabel()
    let costStoneLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.lxt_initSubView()
    }
    
    func lxt_initSubView() {
        self.drawingBox.backgroundColor = .white
        self.drawingBox.setTitle("选择", for: .normal)
        self.drawingBox.setTitleColor(titleColor51, for: .normal)
        self.drawingBox.titleLabel?.font = UIFont(name: PingFangSCRegular, size: 14)
        self.drawingBox.layer.cornerRadius = 5
        self.drawingBox.layer.borderColor = titleColor51.cgColor
        self.drawingBox.layer.borderWidth = 1
        self.drawingBox.clipsToBounds = true
        self.drawingBox.addTarget(self, action: #selector(lxt_chooseEquipClick), for: .touchUpInside)
        self.view.addSubview(self.drawingBox)
        self.drawingBox.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(kNavigationBarHeight + 60)
            make.size.equalTo(CGSize(width: 60, height: 60))
        }
        
        
        let makeButton = UIButton(type: .custom)
        makeButton.layer.cornerRadius = 5
        makeButton.layer.borderColor = titleColor51.cgColor
        makeButton.layer.borderWidth = 1
        makeButton.clipsToBounds = true
        makeButton.addTarget(self, action: #selector(lxt_strongEquipClick), for: .touchUpInside)
        makeButton.setTitle("打造", for: .normal)
        makeButton.setTitleColor(titleColor51, for: .normal)
        makeButton.titleLabel?.font = UIFont(name: PingFangSCRegular, size: 12)
        self.view.addSubview(makeButton)
        makeButton.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.costStoneLabel.snp.bottom).offset(40)
            make.size.equalTo(CGSize(width: 60, height: 40))
        }
        
        self.view.addSubview(self.chooseView)
        self.chooseView.isHidden = true
        self.chooseView.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        }
        weak var weakSelf = self
        self.chooseView.selectBlock = { model in
            weakSelf?.lxt_selectEquipAction(model: model)
        }
    }
    
    func lxt_selectEquipAction(model : LXTGoodsModel) {
        self.selectModel = model
        self.drawingBox.setTitle("\(model.name)+\(model.equipModel.strongLevel)", for: .normal)
        let multiple = powf(2, Float(model.equipModel.strongLevel + 1))
        let costGold = Int(multiple) * model.equipModel.costStrongGold
        let costStone = Int(multiple) * model.equipModel.costStrongStone
        self.costGoldLabel.text = "消耗：\(costGold)/\(user.goldNum) 金币"
        self.costStoneLabel.text = "消耗：\(costStone)/\(user.stone.count) 强化石"
    }
    
    @objc func lxt_strongEquipClick() {
        if let model = self.selectModel {
            let f = powf(2, Float(model.equipModel.strongLevel + 1))
            print(f)
            if user.goldNum > model.equipModel.costStrongGold * Int(f)
                && user.stone.count > model.equipModel.costStrongStone * Int(f) {
                if arc4random() % 10 == 3 {
                    model.equipModel.strongLevel += 1
                    LXTAlertView.showInfo(info: "强化成功", showCancel: false, completeTitle: "确定")
                    self.drawingBox.setTitle("\(model.name)+\(model.equipModel.strongLevel)", for: .normal)
                    let _ = LXTUserEquipDB.lxt_updateWithEquip(model: model.equipModel)
                }else{
                    LXTAlertView.showInfo(info: "强化失败", showCancel: false, completeTitle: "确定")
                }
            }else{
                LXTAlertView.showTips(tips: "材料不足")
            }
        }
        
        
    }
    
    @objc func lxt_chooseEquipClick() {
        self.chooseView.dataSource = LXTGoodsSQliteHelper.lxt_getAllEquipGoods()
        self.chooseView.isHidden = false
    }

}
 
