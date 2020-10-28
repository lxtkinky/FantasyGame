//
//  LXTSectLibController.swift
//  FantasyGame
//
//  Created by ULDD on 2020/10/19.
//  Copyright © 2020 LXT. All rights reserved.
//

import UIKit

class LXTSectLibController: LXTBaseController,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource {
    var collectionView = UICollectionView.init(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    let cellKey = "cellKey"
    var dataSource : Array<String> = Array()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.lxt_initSubView()
    }
    
    func lxt_initSubView() {
        self.view.backgroundColor = .white
        self.navTitleLabel.text = ""

        
        self.collectionView.backgroundColor = .white
        self.collectionView.layer.cornerRadius = 5
        self.collectionView.isScrollEnabled = false
        self.collectionView.layer.borderWidth = 1
        self.collectionView.layer.borderColor = titleColor51.cgColor
        self.collectionView.clipsToBounds = true
        self.collectionView.register(UICollectionViewCell.classForCoder(), forCellWithReuseIdentifier: self.cellKey)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.bounces = false
        self.collectionView.showsVerticalScrollIndicator = false
        self.view.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets(top: statusBarHeight + 44, left: 5, bottom: kBottomSafeHeight , right: 5))
        }
    }
    
    func lxt_memberButtonClick() {
        let memberVC = LXTMemberController()
        memberVC.modalPresentationStyle = .fullScreen
        self.present(memberVC, animated: false) {}
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cellKey, for: indexPath)
        var titleLabel = cell.contentView.viewWithTag(1001) as? UILabel
        if cell.contentView.subviews.count == 0 {
            titleLabel = UILabel()
            titleLabel?.tag = 1001
            lxt_setupLabel(label: titleLabel! , textColor: titleColor51, fontName: PingFangSCRegular, fontSize: 14)
            lxt_borderCornerView(view: titleLabel!, borderWidth: 1, borderColor: titleColor51, cornerRadius: 5)
            cell.contentView.addSubview(titleLabel!)
            titleLabel!.snp.makeConstraints({ (make) in
                make.center.equalToSuperview()
                make.size.equalTo(CGSize(width: kScreenWidth / 2, height: 50))
            })
        }
        titleLabel?.text = self.dataSource[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            self.lxt_memberButtonClick()
        default:
            print("===")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: kScreenWidth - 20, height: 60)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
}
