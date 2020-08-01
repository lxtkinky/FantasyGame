//
//  LXTBaseController.swift
//  FantasyGame
//
//  Created by ULDD on 2020/7/14.
//  Copyright © 2020 LXT. All rights reserved.
//

import UIKit

class LXTBaseController: UIViewController {
    let backButton = UIButton.init(type: .custom)
    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.backButton.setImage(UIImage(named: "close"), for: .normal)
        self.backButton.addTarget(self, action: #selector(lxt_backClick), for: .touchUpInside)
        self.view.addSubview(self.backButton)
        self.backButton.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-10)
            make.top.equalToSuperview().offset(statusBarHeight)
            make.height.equalTo(44)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.view.bringSubviewToFront(self.backButton)
    }
    

    @objc func lxt_backClick() {
        self.dismiss(animated: false) {}
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
