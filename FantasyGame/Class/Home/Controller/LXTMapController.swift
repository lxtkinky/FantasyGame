//
//  LXTMapController.swift
//  FantasyGame
//
//  Created by ULDD on 2020/7/15.
//  Copyright © 2020 LXT. All rights reserved.
//

import UIKit

class LXTMapController: LXTBaseController,UITableViewDelegate,UITableViewDataSource {
    
    let tableView = UITableView()
    var changeMap : (Int) -> Void = {mapLevel in}

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white

        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "cell")
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets(top: 64, left: 0, bottom: 0, right: 0))
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let appDelegate : AppDelegate = (UIApplication.shared.delegate as? AppDelegate)!
        appDelegate.allowRotate = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let appDelegate : AppDelegate = (UIApplication.shared.delegate as? AppDelegate)!
        appDelegate.allowRotate = false
        
        //判断退出时是否是横屏
        if UIApplication.shared.statusBarOrientation.isLandscape {
            //是横屏让变回竖屏
            setNewOrientation(fullScreen: false)
        }
    }
    
    //横竖屏
    func setNewOrientation(fullScreen: Bool) {
        if fullScreen { //横屏
            let resetOrientationTargert = NSNumber(integerLiteral: UIInterfaceOrientation.unknown.rawValue)
            UIDevice.current.setValue(resetOrientationTargert, forKey: "orientation")
            
            let orientationTarget = NSNumber(integerLiteral: UIInterfaceOrientation.landscapeLeft.rawValue)
            UIDevice.current.setValue(orientationTarget, forKey: "orientation")
            
        }else { //竖屏
            let resetOrientationTargert = NSNumber(integerLiteral: UIInterfaceOrientation.unknown.rawValue)
            UIDevice.current.setValue(resetOrientationTargert, forKey: "orientation")
            
            let orientationTarget = NSNumber(integerLiteral: UIInterfaceOrientation.portrait.rawValue)
            UIDevice.current.setValue(orientationTarget, forKey: "orientation")
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = "map \(indexPath.row + 1)"
        cell?.selectionStyle = .none
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.changeMap(indexPath.row + 1)
        self.dismiss(animated: true) {}
    }

}
