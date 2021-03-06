//
//  LXTEquipShopController.swift
//  FantasyGame
//
//  Created by ULDD on 2020/8/10.
//  Copyright © 2020 LXT. All rights reserved.
//

import UIKit

class LXTEquipShopController: LXTBaseController,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource {    
    let width = (kScreenWidth - 25) / 4
    let height = (kScreenWidth - 25) / 4 / 3 * 4
    let bookCellKey = "cellKey"
    var dataSource : Array<LXTEquipModel> = []
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())

    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = LXTEquipDBHelper.lxt_queryAllEquip()
        self.lxt_initSubView()
    }
    
    func lxt_initSubView() -> Void {
        self.collectionView.backgroundColor = .white
        self.collectionView.register(UICollectionViewCell.classForCoder(), forCellWithReuseIdentifier: "cell")
        self.collectionView.register(LXTEquipShopCell.classForCoder(), forCellWithReuseIdentifier: self.bookCellKey)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.view.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets(top: statusBarHeight + 44, left: 0, bottom: 0, right: 0))
        }
    }
    
    func lxt_buyAction(equipModel : LXTEquipModel) -> Void {
        var moneyEnough = false
        var buyStr = ""
        if equipModel.buyType == 1 {
            buyStr = "金币"
            moneyEnough = user.goldNum > equipModel.priceCount
        }else if(equipModel.buyType == 2){
            moneyEnough = user.ybNum > equipModel.priceCount
            buyStr = "元宝"
        }else if(equipModel.buyType == 3){
            buyStr = "材料"
        }
        
        if moneyEnough {
            let buyNum = equipModel.priceCount
            
            LXTAlertView.showInfo(info: "花费 \(buyNum) \(buyStr)购买", showCancel: true, completeTitle: "购买") {
                if equipModel.buyType == 1{
                    user.goldNum -= equipModel.priceCount
                }else if (equipModel.buyType == 2){
                    user.ybNum -= equipModel.priceCount
                }else if(equipModel.buyType == 3){
                    //扣除材料
                }
                
                LXTUserManager().lxt_saveUser(user: user)
                let goods = LXTGoodsModel()
                goods.name = equipModel.name
                goods.type = .equip
                goods.desc = "初级装备\(equipModel.name)"
                goods.count = 1
                //                    goods.relationID = equipModel.id
                let userEquip = LXTUserEquipModel()
                userEquip.equipID = equipModel.id
                goods.userEquip = userEquip
                let _ = LXTGoodsSQliteHelper.lxt_saveEquipGoods(goods: goods)
                LXTAlertView.showInfo(info: "获得装备 \(equipModel.name)", showCancel: false, completeTitle: "确定")
            }
            
            print("购买装备：\(equipModel.name)")
        }else{
            LXTAlertView.showInfo(info: "\(buyStr)不足，无法购买", showCancel: false, completeTitle: "确定")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : LXTEquipShopCell = collectionView.dequeueReusableCell(withReuseIdentifier: self.bookCellKey, for: indexPath) as! LXTEquipShopCell
        cell.equipModel = self.dataSource[indexPath.row]
        weak var weakSelf = self
        cell.buyBlock = { model in
            weakSelf?.lxt_buyAction(equipModel: model)
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
