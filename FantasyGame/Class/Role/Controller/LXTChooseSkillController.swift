//
//  LXTChooseSkillController.swift
//  FantasyGame
//
//  Created by ULDD on 2020/7/31.
//  Copyright © 2020 LXT. All rights reserved.
//

import UIKit

class LXTChooseSkillController: LXTBaseController,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource {

   var collectionView = UICollectionView.init(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    let activitySkillCell = "activitySkillCell"
    let skillCell = "skillCell"
    var dataSource : Array<LXTHeroSkillModel> = Array<LXTHeroSkillModel>()
    var activityArray : Array<LXTHeroSkillModel> = Array<LXTHeroSkillModel>(repeating: LXTHeroSkillModel(), count: 6)
    var selectIndex = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        self.lxt_initSubView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func lxt_initSubView() {
        self.view.backgroundColor = .white
        
        self.dataSource = LXTHeroSkillDBHelper.lxt_queryHeroSkillByHeroID(heroID: 1, battle: false)
        for model in self.dataSource {
            if model.enable && model.index > 0 {
                print("技能位：\(model.index)")
                self.activityArray[model.index - 1] = model
                
            }
        }
        
        self.collectionView.backgroundColor = .white
        self.collectionView.register(LXTHeroSkillActivityCell.classForCoder(), forCellWithReuseIdentifier: self.activitySkillCell)
        self.collectionView.register(LXTHeroSkillChooseCell.classForCoder(), forCellWithReuseIdentifier: self.skillCell)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.bounces = false
        self.collectionView.showsVerticalScrollIndicator = false
        self.view.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets(top: statusBarHeight + 40, left: 10, bottom: kBottomSafeHeight, right: 10))
        }
    }
    
    func lxt_activityClick(model : LXTHeroSkillModel) -> Void {
        if model.enable {
            model.enable = false
            self.activityArray[model.index - 1] = LXTHeroSkillModel()
        }else{
            model.enable = true
            self.activityArray[self.selectIndex].enable = false  //覆盖之前的技能位设置
            self.activityArray[self.selectIndex] = model
            model.index = self.selectIndex + 1
        }
        
        print("index = \(model.index)")
        
        let _ = LXTHeroSkillDBHelper.lxt_saveHeroSkill(heroSkill: model)
        self.collectionView.reloadData()
        
        NotificationCenter.default.post(name: KNotificationHeroSkillChange, object: nibName)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 6
        }
        return self.dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0{
            let cell : LXTHeroSkillActivityCell = collectionView.dequeueReusableCell(withReuseIdentifier: self.activitySkillCell, for: indexPath) as! LXTHeroSkillActivityCell
            let model = self.activityArray[indexPath.row]
            cell.contentView.layer.borderWidth = 1
            if indexPath.row == self.selectIndex {
                cell.contentView.layer.borderColor = UIColor.black.cgColor
            }else{
                cell.contentView.layer.borderColor = UIColor.clear.cgColor
            }
            if model.id > 0 {
                cell.contentView.backgroundColor = rgb(255, 227, 150)
                
            }else{
                cell.contentView.backgroundColor = buttonDisableColor
            }
            cell.model = model
            return cell
        }
        let cell : LXTHeroSkillChooseCell = collectionView.dequeueReusableCell(withReuseIdentifier: self.skillCell, for: indexPath) as! LXTHeroSkillChooseCell
        cell.backgroundColor = rgb(255, 227, 150)
        cell.heroSkill = self.dataSource[indexPath.row]
        weak var weakSelf = self
        cell.activityBlock = { model in
            weakSelf?.lxt_activityClick(model: model)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            self.selectIndex = indexPath.row
            self.collectionView.reloadData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0{
            let wh = (kScreenWidth - 5 - 20) / 6
            return CGSize(width: wh, height: wh)
        }
        return CGSize(width: kScreenWidth - 20, height: 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 0, bottom: 30, right: 0)
    }

}
