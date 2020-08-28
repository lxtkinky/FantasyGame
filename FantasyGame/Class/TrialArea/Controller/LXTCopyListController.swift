//
//  LXTCopyListController.swift
//  FantasyGame
//
//  Created by ULDD on 2020/8/17.
//  Copyright © 2020 LXT. All rights reserved.
//

import UIKit

class LXTCopyListController: LXTBaseController,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    var collectionView = UICollectionView.init(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    let cellKey = "cellKey"
    var dataSource : Array<String> = []
    override func viewDidLoad() {
        super.viewDidLoad()
        self.lxt_initData()
        self.lxt_initSubView()
    }
    
    func lxt_initSubView() {
        self.view.backgroundColor = .white
        
        self.collectionView.backgroundColor = .white
        self.collectionView.register(UICollectionViewCell.classForCoder(), forCellWithReuseIdentifier: self.cellKey)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.bounces = false
        self.collectionView.showsVerticalScrollIndicator = false
        self.view.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets(top: statusBarHeight + 20, left: 0, bottom: kBottomSafeHeight, right: 0))
        }
    }
    
    func lxt_initData() {
        self.dataSource.append("经验副本")
        self.dataSource.append("材料副本")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cellKey, for: indexPath)
//        cell.backgroundColor = kRandomColor()
        for label in cell.contentView.subviews {
            label.removeFromSuperview()
        }
        let label = UILabel()
        cell.contentView.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }

        label.text = self.dataSource[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: kScreenWidth, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.tabBarController?.selectedIndex = 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if section == 0{
            return 1
        }
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
}
