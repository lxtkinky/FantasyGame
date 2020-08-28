//
//  LXTStudySkillController.swift
//  FantasyGame
//
//  Created by ULDD on 2020/7/30.
//  Copyright © 2020 LXT. All rights reserved.
//

import UIKit

class LXTStudySkillController: LXTBaseController,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource {

    var collectionView = UICollectionView.init(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    let cellKey = "cellKey"
    let goodsCellKey = "goodsCellKey"
    var dataSource : Array<LXTGoodsModel> = Array<LXTGoodsModel>()
    let goodsView = LXTGoodsView()
    var hero : LXTHeroModel?
    var skill : LXTSkillModel?
    var selectGoods : LXTGoodsModel?
    let studyButton = UIButton(type: .custom)
    var currentSkillArray = Array<LXTHeroSkillModel>()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.lxt_initSubView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.dataSource = LXTGoodsSQliteHelper.lxt_getAllSkillGoods()
        self.collectionView.reloadData()
    }
    
    func lxt_initSubView() {
        self.view.backgroundColor = .white
        
        self.currentSkillArray = LXTHeroSkillDBHelper.lxt_queryHeroSkillByHeroID(heroID: self.hero!.heroID, battle: false)
        
        self.collectionView.backgroundColor = .white
        self.collectionView.register(UICollectionViewCell.classForCoder(), forCellWithReuseIdentifier: self.cellKey)
        self.collectionView.register(LXTGoodsCell.classForCoder(), forCellWithReuseIdentifier: self.goodsCellKey)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.bounces = false
        self.collectionView.showsVerticalScrollIndicator = false
        self.view.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets(top: statusBarHeight + 40, left: 10, bottom: kBottomSafeHeight, right: 10))
        }

        studyButton.setTitle("学习", for: .normal)
        studyButton.setTitleColor(buttonDisableColor, for: .normal)
        studyButton.layer.cornerRadius = 3.0
        studyButton.clipsToBounds = true
        studyButton.layer.borderColor = buttonDisableColor.cgColor
        studyButton.layer.borderWidth = 1.0
        studyButton.addTarget(self, action: #selector(lxt_studyClick), for: .touchUpInside)
        self.view.addSubview(studyButton)
        studyButton.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-100)
            make.size.equalTo(CGSize(width: 50, height: 30))
        }
        
    }
    
    @objc func lxt_studyClick() -> Void {
        if let skillModel = self.skill{
            if let model = self.hero{
                let heroSkill = LXTHeroSkillModel()
                print("准备学习技能SkillID：\(skillModel.skillID)")
                for item in self.currentSkillArray {
                    print("已学习技能SkillID:\(item.skillID)")
                    if item.skillID == skillModel.skillID {
//                        heroSkill = item
                        print("不能重复学习技能")
//                        LXTAlertView.showInfo(info: "不能重复学习技能")
                        LXTAlertView.showInfo(info: "不能重复学习技能", showCancel: false, completeTitle: "确定")
                        return
                    }
                }
                
                self.selectGoods?.count -= 1
                let _ = LXTGoodsSQliteHelper.lxt_updateGoods(model: self.selectGoods!)
                
                heroSkill.heroID = model.heroID
                heroSkill.skillID = skillModel.skillID
                heroSkill.damage = skillModel.damageBase
                let success = LXTHeroSkillDBHelper.lxt_saveHeroSkill(heroSkill: heroSkill)
                print(success ? "学习成功" : "学习失败")
//                LXTAlertView.showInfo(info: success ? "学习成功" : "学习失败")
                LXTAlertView.showInfo(info: success ? "学习成功" : "学习失败", showCancel: false, completeTitle: "确定")
            }
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row < self.dataSource.count{
            let cell : LXTGoodsCell = collectionView.dequeueReusableCell(withReuseIdentifier: self.goodsCellKey, for: indexPath) as! LXTGoodsCell
            cell.goods = self.dataSource[indexPath.row]
            cell.contentView.backgroundColor = themeColorYellow
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cellKey, for: indexPath)
        cell.backgroundColor = .lightGray
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let goods = self.dataSource[indexPath.row]
        self.skill = goods.skillModel
        self.selectGoods = goods
        self.studyButton.setTitleColor(goods.useable ? titleColor51 : buttonDisableColor, for: .normal)
        self.studyButton.layer.borderColor = goods.useable ? titleColor51.cgColor : buttonDisableColor.cgColor
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let wh = (kScreenWidth - 4 - 20) / 5
        return CGSize(width: wh, height: wh)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
}
