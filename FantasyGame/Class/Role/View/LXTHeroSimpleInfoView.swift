//
//  LXTHeroSimpleInfoView.swift
//  FantasyGame
//
//  Created by ULDD on 2020/8/11.
//  Copyright © 2020 LXT. All rights reserved.
//

import UIKit

class LXTHeroSimpleInfoView: UIView, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    var dataSource = Array<String>()
    let cellKey = "cellKey"
    let infoKey = "infoKey"
    let equipKey = "equipKey"
    let skillKey = "skillKey"
    let expStrip = LXTExpStripView()
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    var skillBlock : (() -> Void)?
    var equipBlock : ((_ type : Int) -> Void)?
    var hero : LXTHeroModel?{
        didSet{
            self.lxt_updateData()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.lxt_initSubView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func lxt_initSubView() {
        self.collectionView.backgroundColor = .white
        self.collectionView.register(UICollectionViewCell.classForCoder(), forCellWithReuseIdentifier: self.cellKey)
        self.collectionView.register(LXTEquipCell.classForCoder(), forCellWithReuseIdentifier: self.equipKey)
        self.collectionView.register(LXTHeroSkillCell.classForCoder(), forCellWithReuseIdentifier: self.skillKey)
        self.collectionView.register(LXTSimpleInfoCell.classForCoder(), forCellWithReuseIdentifier: self.infoKey)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    func lxt_updateData() {
        self.dataSource.removeAll()
        self.dataSource.append("英雄：\(self.hero!.name)")
        self.dataSource.append("等级：\(self.hero!.level)")
        self.dataSource.append("生命：\(self.hero!.hp)")
        self.dataSource.append("魔法：\(self.hero!.mp)")
        self.dataSource.append("攻击：\(self.hero!.totalAttack)")
        self.dataSource.append("法攻：\(self.hero!.totalMagic)")
        
        self.collectionView.reloadData()
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }else if section == 1{
            return self.dataSource.count
        }else if section == 2{
            return 10
        }
        else{
            return 6
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cellKey, for: indexPath)
            if cell.contentView.subviews.count == 0 {
                cell.contentView.addSubview(self.expStrip)
                self.expStrip.snp.makeConstraints { (make) in
                    make.left.right.equalToSuperview()
                    make.centerY.equalToSuperview()
                    make.height.equalTo(10)
                }
            }
            self.expStrip.hero = self.hero
            return cell
        }else if indexPath.section == 1{
            let cell : LXTSimpleInfoCell = collectionView.dequeueReusableCell(withReuseIdentifier: self.infoKey, for: indexPath) as! LXTSimpleInfoCell
            cell.infoLabel.text = self.dataSource[indexPath.row]
            return cell
        }else if indexPath.section == 2{
            let cell : LXTEquipCell = collectionView.dequeueReusableCell(withReuseIdentifier: self.equipKey, for: indexPath) as! LXTEquipCell
            cell.model = self.hero?.equipArray[indexPath.row]
            return cell
        }
        let cell : LXTHeroSkillCell = collectionView.dequeueReusableCell(withReuseIdentifier: self.skillKey, for: indexPath) as! LXTHeroSkillCell
        cell.skill = self.hero?.skills[indexPath.row].skill
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 3 {
            self.skillBlock?()
        }else if indexPath.section == 2{
            self.equipBlock?(indexPath.row)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            return CGSize(width: kScreenWidth, height: 30)
        }else if indexPath.section == 1{
            return CGSize(width: kScreenWidth / 2 - 0.5 - 10, height: 30)
        }
        let wh = (kScreenWidth - 5 * 5 - 10) / 6
        return CGSize(width: wh, height: wh)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if section > 0 {
            return UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 10)
        }
        return UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
    }
}
