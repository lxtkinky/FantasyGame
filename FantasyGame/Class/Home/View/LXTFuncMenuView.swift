//
//  LXTFuncMenuView.swift
//  FantasyGame
//
//  Created by ULDD on 2020/8/28.
//  Copyright © 2020 LXT. All rights reserved.
//

import UIKit

class LXTFuncMenuView: UIView, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {

    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    let cellKey = "cellKey"
    var dataSource = Array<String>()
    var selectMenuBlock : ((_ index : Int) -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.lxt_initSubView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func lxt_initSubView() {
        self.collectionView.backgroundColor = .clear
        self.collectionView.register(UICollectionViewCell.classForCoder(), forCellWithReuseIdentifier: self.cellKey)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10))
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cellKey, for: indexPath)
        cell.contentView.layer.cornerRadius = 5
        cell.contentView.clipsToBounds = true
        cell.contentView.layer.borderColor = titleColor51.cgColor
        cell.contentView.layer.borderWidth = 1
        for subView in cell.contentView.subviews {
            subView.removeFromSuperview()
        }
        let label = UILabel()
        label.font = UIFont(name: PingFangSCRegular, size: 12)
        label.textColor = titleColor51
        label.text = self.dataSource[indexPath.row]
        cell.contentView.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 50, height: 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectMenuBlock?(indexPath.row)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }

}
