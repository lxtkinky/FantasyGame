//
//  LXTPackageController.swift
//  FantasyGame
//
//  Created by ULDD on 2020/7/18.
//  Copyright © 2020 LXT. All rights reserved.
//

import UIKit

class LXTPackageController: UIViewController,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource {
    var collectionView = UICollectionView.init(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    let cellKey = "cellKey"
    let goodsCellKey = "goodsCellKey"
    var dataSource : Array<LXTGoodsModel> = Array<LXTGoodsModel>()
    let goodsView = LXTGoodsView()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.lxt_initSubView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.dataSource = LXTGoodsSQliteHelper.lxt_getAllGoods()
        self.collectionView.reloadData()
    }
    
    func lxt_initSubView() {
        self.view.backgroundColor = .white
        
        self.collectionView.backgroundColor = .white
        self.collectionView.layer.cornerRadius = 5
        self.collectionView.layer.borderWidth = 1
        self.collectionView.layer.borderColor = titleColor51.cgColor
        self.collectionView.clipsToBounds = true
        self.collectionView.register(UICollectionViewCell.classForCoder(), forCellWithReuseIdentifier: self.cellKey)
        self.collectionView.register(LXTGoodsCell.classForCoder(), forCellWithReuseIdentifier: self.goodsCellKey)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.bounces = false
        self.collectionView.showsVerticalScrollIndicator = false
        self.view.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets(top: statusBarHeight + 20, left: 5, bottom: kBottomSafeHeight + 45 + 15, right: 5))
        }
        
        self.view.addSubview(self.goodsView)
        self.goodsView.isHidden = true
        weak var weakSelf = self
        self.goodsView.useBlock = { _ in
            weakSelf?.collectionView.reloadData()
        }
        self.goodsView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(statusBarHeight)
            make.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-kBottomSafeHeight - 45)
            make.left.equalToSuperview()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 120
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row < self.dataSource.count{
            let cell : LXTGoodsCell = collectionView.dequeueReusableCell(withReuseIdentifier: self.goodsCellKey, for: indexPath) as! LXTGoodsCell
            cell.goods = self.dataSource[indexPath.row]
//            cell.contentView.backgroundColor = rgba(255, 227, 150, 1)
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cellKey, for: indexPath)
        cell.backgroundColor = .white
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row < self.dataSource.count{
            self.goodsView.goodsModel = self.dataSource[indexPath.row]
            self.goodsView.isHidden = false
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let wh = (kScreenWidth - 10 - 20) / 6
        return CGSize(width: wh, height: wh)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }

}
