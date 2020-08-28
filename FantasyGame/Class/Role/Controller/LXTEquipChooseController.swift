//
//  LXTEquipChooseController.swift
//  FantasyGame
//
//  Created by ULDD on 2020/8/12.
//  Copyright © 2020 LXT. All rights reserved.
//

import UIKit

class LXTEquipChooseController: LXTBaseController,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource {

    var collectionView = UICollectionView.init(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    let activitySkillCell = "activitySkillCell"
    let equipCell = "equipCell"
    var dataSource : Array<LXTGoodsModel> = Array<LXTGoodsModel>()
    var currentModel : LXTGoodsModel?
    var hero : LXTHeroModel?
    var type = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        self.lxt_initSubView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func lxt_initSubView() {
        self.view.backgroundColor = .white
        
//        self.dataSource = LXTGoodsSQliteHelper.lxt_getAllEquipGoods()
        var equipType = EquipType.all
        for item in EquipType.allCases {
            if item.rawValue == self.type {
                equipType = item
            }
        }
        self.dataSource = LXTGoodsSQliteHelper.lxt_getAllEquipGoods(paramHeroID: 0, paramEquipType: equipType)
        var currIndex = -1
        for (index , model) in self.dataSource.enumerated() {
            if model.userEquip?.heroID == self.hero?.id {
                self.currentModel = model
                currIndex = index
            }
        }
        if currIndex != -1 {
            self.dataSource.remove(at: currIndex)
        }
        
        
        self.collectionView.backgroundColor = .white
        self.collectionView.register(LXTEquipChooseCell.classForCoder(), forCellWithReuseIdentifier: self.equipCell)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.bounces = false
        self.collectionView.showsVerticalScrollIndicator = false
        self.view.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets(top: statusBarHeight + 40, left: 10, bottom: kBottomSafeHeight, right: 10))
        }
    }
    
    func lxt_useClick(model : LXTGoodsModel) -> Void {
        if model == self.currentModel{
            if let current = self.currentModel {
                current.userEquip?.heroID = 0
                let _ = LXTUserEquipDB.lxt_updateUserEquip(userEquip: current.userEquip!)
            }
            
            self.dataSource.insert(self.currentModel!, at: 0)
            self.currentModel = nil
        }else{
            if let current = self.currentModel {
                current.userEquip?.heroID = 0
                let _ = LXTUserEquipDB.lxt_updateUserEquip(userEquip: current.userEquip!)
                self.dataSource.insert(current, at: 0)
            }
            
            model.userEquip?.heroID = self.hero!.id
            let _ = LXTUserEquipDB.lxt_updateUserEquip(userEquip: model.userEquip!)
            self.currentModel = model
            self.dataSource.removeAll { (item) -> Bool in
                return item == model
            }
        }
        
        self.collectionView.reloadData()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return self.dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        weak var weakSelf = self
        if indexPath.section == 0{
            let cell : LXTEquipChooseCell = collectionView.dequeueReusableCell(withReuseIdentifier: self.equipCell, for: indexPath) as! LXTEquipChooseCell
            cell.model = self.currentModel
            cell.useBlock = { model in
                weakSelf?.lxt_useClick(model: model)
            }
            return cell
        }
        let cell : LXTEquipChooseCell = collectionView.dequeueReusableCell(withReuseIdentifier: self.equipCell, for: indexPath) as! LXTEquipChooseCell
        cell.model = self.dataSource[indexPath.row]
        cell.useBlock = { model in
            weakSelf?.lxt_useClick(model: model)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
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
