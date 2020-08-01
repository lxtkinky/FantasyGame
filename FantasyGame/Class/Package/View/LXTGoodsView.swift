//
//  LXTGoodsView.swift
//  FantasyGame
//
//  Created by ULDD on 2020/7/28.
//  Copyright © 2020 LXT. All rights reserved.
//

import UIKit

class LXTGoodsView: UIView {
    let nameLabel = UILabel()
    let countLabel = UILabel()
    let descLabel = UILabel()
    let useButton = UIButton(type: .custom)
    var useBlock : ((_ model : LXTGoodsModel) -> Void) = {_ in }
    var goodsModel : LXTGoodsModel?{
        didSet{
            self.lxt_updateUIWithModel()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.lxt_initSubView()
    }
    
    func lxt_initSubView() -> Void {
        self.backgroundColor = .clear
        
        let boxView = UIView()
        boxView.backgroundColor = .white
        self.addSubview(boxView)
        boxView.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets(top: 20, left: 10, bottom: 20, right: 10))
        }
        
        let closeButton = UIButton(type: .custom)
//        closeButton.backgroundColor = kRandomColor()
        closeButton.setImage(UIImage(named: "close"), for: .normal)
        closeButton.addTarget(self, action: #selector(lxt_closeClick), for: .touchUpInside)
        boxView.addSubview(closeButton)
        closeButton.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-10)
            make.top.equalToSuperview().offset(10)
            make.size.equalTo(CGSize(width: 40, height: 40))
        }
        
        self.nameLabel.font = UIFont(name: PingFangSCMedium, size: 14)
        self.nameLabel.textColor = .black
        boxView.addSubview(self.nameLabel)
        self.nameLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10)
            make.top.equalToSuperview().offset(10)
        }
        
        self.countLabel.font = UIFont(name: PingFangSCRegular, size: 12)
        self.countLabel.textColor = .black
        boxView.addSubview(self.countLabel)
        self.countLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.nameLabel)
            make.top.equalTo(self.nameLabel.snp.bottom).offset(5)
        }
        
        self.descLabel.font = UIFont(name: PingFangSCRegular, size: 12)
        boxView.addSubview(self.descLabel)
        self.descLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
            make.right.equalToSuperview().offset(-10)
        }
        
        self.useButton.setTitle("使用", for: .normal)
        self.useButton.addTarget(self, action: #selector(lxt_useClick), for: .touchUpInside)
        self.useButton.layer.borderColor = kRandomColor().cgColor
        self.useButton.isHidden = true
        self.useButton.setTitleColor(rgb(51, 51, 51), for: .normal)
        self.useButton.titleLabel?.font = UIFont(name: PingFangSCRegular, size: 12)
        self.useButton.layer.borderWidth = 1.0
        self.useButton.layer.cornerRadius = 3.0
        self.useButton.clipsToBounds = true
        boxView.addSubview(self.useButton)
        self.useButton.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-10)
            make.top.equalTo(closeButton.snp.bottom).offset(30)
            make.size.equalTo(CGSize(width: 40, height: 20))
        }
        
    }
    
    func lxt_updateUIWithModel() -> Void {
        self.nameLabel.text = self.goodsModel?.name
        self.countLabel.text = String(self.goodsModel!.count)
        self.descLabel.text = self.goodsModel?.desc
        self.useButton.isHidden = !self.goodsModel!.useable
    }
    
    @objc func lxt_useClick(){
        if self.goodsModel!.count > 0 {
            self.goodsModel?.count -= 1
            let _ = LXTGoodsSQliteHelper.lxt_updateGoods(model: self.goodsModel!)
            self.useBlock(self.goodsModel!)
            self.lxt_updateUIWithModel()
        }
        
        
    }
    
    @objc func lxt_closeClick() -> Void {
//        self.removeFromSuperview()
        self.isHidden = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

}
