//
//  LXTSikllLibController.swift
//  FantasyGame
//
//  Created by ULDD on 2020/7/27.
//  Copyright © 2020 LXT. All rights reserved.
//

import UIKit


class LXTSikllLibController: LXTBaseController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    let width = (kScreenWidth - 25) / 4
    let height = (kScreenWidth - 25) / 4 / 3 * 4
    let bookCellKey = "bookCellKey"
    var dataSource : Array<LXTSkillModel> = []
    var isSect = false      //是否宗门藏书阁
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.isSect {
            self.dataSource = LXTSkillTableHelper.lxt_getSkills(isSectType: 1)
        }else{
            self.dataSource = LXTSkillTableHelper.lxt_getBaseSkills()
        }
        
//        for skill in self.dataSource {
//            skill.skillID = 1
//            LXTSkillTableHelper.lxt_updateSkill(model: skill)
//        }
        
        self.lxt_initSubView()
    }
    
    func lxt_initSubView() -> Void {
        self.collectionView.backgroundColor = .white
        self.collectionView.register(UICollectionViewCell.classForCoder(), forCellWithReuseIdentifier: "cell")
        self.collectionView.register(LXTSkillLibCell.classForCoder(), forCellWithReuseIdentifier: self.bookCellKey)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.view.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets(top: statusBarHeight + 44, left: 0, bottom: 0, right: 0))
        }
    }
    
    func lxt_buyAction(skillModel : LXTSkillModel) -> Void {
        var moneyEnough = false
        var buyStr = ""
        if skillModel.buyType == 1 {
            moneyEnough = user.goldNum >= skillModel.priceCount
            buyStr = "金币"
        }else if skillModel.buyType == 2{
            moneyEnough = user.ybNum >= skillModel.priceCount
            buyStr = "元宝"
        }else{
            moneyEnough = false
            buyStr = "材料"
        }
        
        if moneyEnough {
            let buyNum = skillModel.buyType == 1 ? skillModel.goldPrice : skillModel.ybPrice
            
            LXTAlertView.showInfo(info: "花费 \(buyNum) \(buyStr)购买", showCancel: true, completeTitle: "购买") {
                if skillModel.buyType == 1{
                    user.goldNum -= skillModel.goldPrice
                }else if skillModel.buyType == 2{
                    user.ybNum -= skillModel.ybPrice
                }else{
                    //兑换 扣除材料
                }
                
                LXTUserManager().lxt_saveUser(user: user)
                let goods = LXTGoodsModel()
                goods.name = skillModel.name
                goods.type = .skill
                goods.count = 1
                goods.desc = "使用可学习技能\(skillModel.name)"
                goods.relationID = skillModel.skillID
                let _ = LXTGoodsSQliteHelper.lxt_addGoods(goods: goods)
                LXTAlertView.showInfo(info: "获得技能 \(skillModel.name)", showCancel: false, completeTitle: "确定")
            }
            
//            print("购买技能：\(skillModel.name)")
        }else{
            LXTAlertView.showInfo(info: "\(buyStr)不足，无法购买", showCancel: false, completeTitle: "确定")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : LXTSkillLibCell = collectionView.dequeueReusableCell(withReuseIdentifier: self.bookCellKey, for: indexPath) as! LXTSkillLibCell
        cell.skillModel = self.dataSource[indexPath.row]
        
        weak var weakSelf = self
        cell.buyBlock = { model in
            weakSelf?.lxt_buyAction(skillModel: model)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }

}
