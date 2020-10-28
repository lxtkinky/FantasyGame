//
//  LXTMemberController.swift
//  FantasyGame
//
//  Created by ULDD on 2020/10/16.
//  Copyright © 2020 LXT. All rights reserved.
//

import UIKit

class LXTMemberController: LXTBaseController,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource {
    var collectionView = UICollectionView.init(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    let cellKey = "cellKey"
    var dataSource : Array<LXTHeroModel> = Array(repeating: LXTHeroModel(), count: 10)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navTitleLabel.text = "成员列表"
        
        self.lxt_initSubView()
    }
    
    func lxt_initSubView() {
        self.view.backgroundColor = .white
        
        self.collectionView.backgroundColor = .white
        self.collectionView.layer.cornerRadius = 5
        self.collectionView.layer.borderWidth = 1
        self.collectionView.layer.borderColor = titleColor51.cgColor
        self.collectionView.clipsToBounds = true
        self.collectionView.register(LXTMemberCell.classForCoder(), forCellWithReuseIdentifier: self.cellKey)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.bounces = false
        self.collectionView.showsVerticalScrollIndicator = false
        self.view.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets(top: statusBarHeight + 44, left: 5, bottom: kBottomSafeHeight , right: 5))
        }
    }
    
    func lxt_applySect(sectId : Int) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : LXTMemberCell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cellKey, for: indexPath) as! LXTMemberCell
        let model = self.dataSource[indexPath.row]
        model.name = "成员\(indexPath.row + 1)"
        cell.model = model
        weak var weakSelf = self
        cell.applyAction = { sectId in
            weakSelf?.lxt_applySect(sectId: sectId)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: kScreenWidth - 20, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }

}
