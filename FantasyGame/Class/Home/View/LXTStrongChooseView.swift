//
//  LXTStrongChooseView.swift
//  FantasyGame
//
//  Created by ULDD on 2020/8/28.
//  Copyright © 2020 LXT. All rights reserved.
//

import UIKit

class LXTStrongChooseView: UIView, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    let cellKey = "cellKey"
    var selectBlock : ((_ model : LXTGoodsModel) -> Void)?
    var dataSource : Array<LXTGoodsModel> = []{
        didSet{
            self.collectionView.reloadData()
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
        self.backgroundColor = .clear
        
        let boxView = UIView()
        boxView.backgroundColor = .white
        boxView.layer.cornerRadius = 5
        boxView.layer.borderColor = titleColor51.cgColor
        boxView.layer.borderWidth = 1
        boxView.clipsToBounds = true
        self.addSubview(boxView)
        boxView.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets(top: kNavigationBarHeight + 30, left: 30, bottom: 50, right: 30))
        }
        
        self.collectionView.backgroundColor = .white
        self.collectionView.register(UICollectionViewCell.classForCoder(), forCellWithReuseIdentifier: self.cellKey)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        boxView.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets(top: 10, left: 0, bottom: 80, right: 0))
        }
        
        let closeButton = UIButton(type: .custom)
        closeButton.layer.cornerRadius = 5
        closeButton.layer.borderColor = titleColor51.cgColor
        closeButton.layer.borderWidth = 1
        closeButton.clipsToBounds = true
        closeButton.addTarget(self, action: #selector(lxt_closepClick), for: .touchUpInside)
        closeButton.setTitle("关闭", for: .normal)
        closeButton.setTitleColor(titleColor51, for: .normal)
        closeButton.titleLabel?.font = UIFont(name: PingFangSCRegular, size: 12)
        boxView.addSubview(closeButton)
        closeButton.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-20)
            make.size.equalTo(CGSize(width: 40, height: 30))
        }
    }
    
    @objc func lxt_closepClick() {
        self.isHidden = true
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cellKey, for: indexPath)
        var titleLabel : UILabel?
        if cell.contentView.subviews.count == 0 {
            cell.contentView.layer.cornerRadius = 5
            cell.contentView.layer.borderColor = titleColor51.cgColor
            cell.contentView.layer.borderWidth = 1
            cell.contentView.clipsToBounds = true
            titleLabel = UILabel()
            titleLabel?.textColor = titleColor51
            titleLabel?.font = UIFont(name: PingFangSCRegular, size: 12)
            titleLabel?.numberOfLines = 0
            titleLabel?.tag = 1001
            cell.contentView.addSubview(titleLabel!)
            titleLabel?.snp.makeConstraints({ (make) in
                make.left.equalToSuperview().offset(10)
                make.right.equalToSuperview().offset(-10)
                make.top.equalToSuperview().offset(3)
                make.bottom.equalToSuperview().offset(-3)
            })
        }else{
            titleLabel = cell.contentView.viewWithTag(1001) as? UILabel
        }
        titleLabel?.text = self.dataSource[indexPath.row].name
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: kScreenWidth - 80, height: 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectBlock?(self.dataSource[indexPath.row])
        self.isHidden = true
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

}
