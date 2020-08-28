//
//  LXTTrialAreaController.swift
//  FantasyGame
//
//  Created by ULDD on 2020/7/18.
//  Copyright © 2020 LXT. All rights reserved.
//

import UIKit

class LXTTrialAreaController: UIViewController,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource {
    var collectionView = UICollectionView.init(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    let cellKey = "cellKey"
    let trialKey = "trialKey"
    let copyKey = "copyKey"
    var dataSource : Array<LXTCopyModel> = []
    var activity = "活动"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.lxt_initData()
        self.lxt_initSubView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.collectionView.reloadData()
    }
    
    func lxt_initSubView() {
        self.view.backgroundColor = .white
        
        self.collectionView.backgroundColor = .white
        self.collectionView.register(UICollectionViewCell.classForCoder(), forCellWithReuseIdentifier: self.cellKey)
        self.collectionView.register(LXTTrialAreaCell.classForCoder(), forCellWithReuseIdentifier: self.trialKey)
        self.collectionView.register(LXTCopyCell.classForCoder(), forCellWithReuseIdentifier: self.copyKey)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.bounces = false
        self.collectionView.showsVerticalScrollIndicator = false
        self.view.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets(top: statusBarHeight + 20, left: 10, bottom: kBottomSafeHeight, right: 10))
        }
    }
    
    func lxt_initData() {
        self.dataSource = LXTCopyManager.lxt_loadAllCopy()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 2
        }
        return self.dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        weak var weakSelf = self
        if indexPath.section == 0 {
            if indexPath.row == 1 {
                let cell : LXTTrialAreaCell = collectionView.dequeueReusableCell(withReuseIdentifier: self.trialKey, for: indexPath) as! LXTTrialAreaCell
                cell.userModel = user
                
                cell.challengeBlock = {
                    weakSelf?.lxt_trialChanllenge()
                }
                return cell
            }else{
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cellKey, for: indexPath)
                cell.contentView.layer.borderColor = titleColor51.cgColor
                cell.contentView.layer.borderWidth = 1
                cell.contentView.clipsToBounds = true
                cell.contentView.layer.cornerRadius = 5
                for label in cell.contentView.subviews {
                    label.removeFromSuperview()
                }
                let label = UILabel()
                label.textColor = titleColor51
                label.font = UIFont(name: PingFangSCRegular, size: 12)
                cell.contentView.addSubview(label)
                label.snp.makeConstraints { (make) in
                    make.center.equalToSuperview()
                }
                label.text =  self.activity
                return cell
            }
            
        }
        let cell : LXTCopyCell = collectionView.dequeueReusableCell(withReuseIdentifier: self.copyKey, for: indexPath) as! LXTCopyCell
        cell.model = self.dataSource[indexPath.row]
        cell.challengeBlock = { model in
            weakSelf?.lxt_copyChanllenge(model: model)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: kScreenWidth - 20, height: 95)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            
        }else{
//            if indexPath.row == 1 {
//                self.lxt_trialChanllenge()
//            }
        }
    }
    
    func lxt_copyChanllenge(model : LXTCopyModel) {
        if heroArray.first!.level < model.level {
            LXTAlertView.showInfo(info: "等级不足，无法挑战", showCancel: false, completeTitle: "确定")
            return
        }
        
        if user.couponModel.count < model.couponCost {
            LXTAlertView.showInfo(info: "副本券不足，无法挑战", showCancel: false, completeTitle: "确定")
            return
        }
        if nextCopy == nil {
            nextCopy = model
            copyCount = 1
            self.tabBarController?.selectedIndex = 0
        }
    }
    
    func lxt_trialChanllenge() {
        if user.challengeCount >= user.totalChallengeCount {
            LXTAlertView.showInfo(info: "", showCancel: false, completeTitle: "确定")
        }else{
            if nextCopy == nil {
                nextCopy = LXTCopyModel()
                nextCopy?.isTrailCopy = true
                nextCopy?.name = "试炼"
                
                let monster = LXTMonsterModel()
                monster.level = user.trialCount + 1
                monster.name = "\(monster.level)层试炼怪"
                monster.attack = monster.level * 3
                monster.hp = monster.level * 10
                monster.currentHP = monster.hp
                nextCopy?.monster = monster
                
                copyCount = 1
                
                user.challengeCount += 1
                
                self.tabBarController?.selectedIndex = 0
            }else{
                LXTAlertView.showInfo(info: "", showCancel: false, completeTitle: "确定")
            }
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }

}
