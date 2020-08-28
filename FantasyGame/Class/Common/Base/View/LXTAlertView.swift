//
//  LXTAlertView.swift
//  FantasyGame
//
//  Created by ULDD on 2020/8/3.
//  Copyright © 2020 LXT. All rights reserved.
//

import UIKit

class LXTAlertView: UIView {
    let boxView = UIView()
    let msgLabel = UILabel()
    var complete : (() -> Void)? = {}
    let completeButton = UIButton(type: .custom)
    override init(frame: CGRect) {
        super.init(frame: frame)
        
//        self.lxt_initSubView()
    }
    

    func lxt_initSubView(showCancel : Bool, completeTitle : String) {
        self.boxView.backgroundColor = .white
        self.boxView.layer.borderColor = titleColor51.cgColor
        self.boxView.layer.borderWidth = 1
        self.boxView.layer.cornerRadius = 5
        self.boxView.clipsToBounds = true
        self.addSubview(self.boxView)
        self.boxView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: kScreenWidth - 60, height: (kScreenWidth - 60) / 6 * 4))
        }
        
        self.msgLabel.font = UIFont(name: PingFangSCRegular, size: 14)
        self.msgLabel.textColor = titleColor51
        self.boxView.addSubview(self.msgLabel)
        self.msgLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        
        self.completeButton.setTitle(completeTitle, for: .normal)
        self.completeButton.addTarget(self, action: #selector(lxt_buttonClick), for: .touchUpInside)
        self.completeButton.setTitleColor(titleColor51, for: .normal)
        self.completeButton.titleLabel?.font = UIFont(name: PingFangSCRegular, size: 10)
        self.completeButton.layer.borderColor = UIColor.black.cgColor
        self.completeButton.layer.borderWidth = 1
        self.completeButton.layer.cornerRadius = 3
        self.completeButton.clipsToBounds = true
        self.boxView.addSubview(self.completeButton)
        self.completeButton.snp.makeConstraints { (make) in
            if !showCancel {
                make.centerX.equalToSuperview()
            }else{
                make.centerX.equalToSuperview().offset(60)
            }
            make.bottom.equalToSuperview().offset(-10)
            make.size.equalTo(CGSize(width: 60, height: 40))
        }
        
        if showCancel {
            let cancelButton = UIButton(type: .custom)
            cancelButton.setTitle("取消", for: .normal)
            cancelButton.addTarget(self, action: #selector(lxt_cancelButtonClick), for: .touchUpInside)
            cancelButton.setTitleColor(titleColor51, for: .normal)
            cancelButton.titleLabel?.font = UIFont(name: PingFangSCRegular, size: 10)
            cancelButton.layer.borderColor = UIColor.black.cgColor
            cancelButton.layer.borderWidth = 1
            cancelButton.layer.cornerRadius = 3
            cancelButton.clipsToBounds = true
            self.boxView.addSubview(cancelButton)
            cancelButton.snp.makeConstraints { (make) in
                make.centerX.equalToSuperview().offset(-60)
                make.bottom.equalToSuperview().offset(-10)
                make.size.equalTo(CGSize(width: 60, height: 40))
            }
        }
        
        
//        let closeButton = UIButton(type: .custom)
//        closeButton.setImage(UIImage(named: "close"), for: .normal)
//        self.addSubview(closeButton)
//        closeButton.snp.makeConstraints { (make) in
//            make.right.equalTo(self.boxView).offset(10)
//            make.top.equalTo(self.boxView).offset(-10)
//            make.size.equalTo(CGSize(width: 20, height: 20))
//        }
    }
    
    @objc func lxt_buttonClick() {
        if let completeBlock = self.complete {
            completeBlock()
        }
//        self.removeFromSuperview()
        self.lxt_cancelButtonClick()
    }
    
    @objc func lxt_cancelButtonClick() {
        self.removeFromSuperview()
    }

    
    class func showInfo(info : String, showCancel : Bool, completeTitle : String, complete : (() -> Void)? = nil){
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let alert = LXTAlertView()
        alert.lxt_initSubView(showCancel: showCancel, completeTitle: completeTitle)
        alert.complete = complete
        alert.msgLabel.text = info
        delegate.window?.addSubview(alert)
        alert.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
