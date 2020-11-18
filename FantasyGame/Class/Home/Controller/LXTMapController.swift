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
    var dataSource = Array<LXTMonsterModel>()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        self.dataSource = LXTHeroTableHelper.lxt_queryAllMonster()
        self.tableView.register(LXTMapCell.classForCoder(), forCellReuseIdentifier: "cell")
        self.tableView.separatorStyle = .none
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets(top: kNavigationBarHeight + 10, left: 0, bottom: 0, right: 0))
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let appDelegate : AppDelegate = (UIApplication.shared.delegate as? AppDelegate)!
        appDelegate.allowRotate = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        /*
         let appDelegate : AppDelegate = (UIApplication.shared.delegate as? AppDelegate)!
         appDelegate.allowRotate = false
        //判断退出时是否是横屏
        if UIApplication.shared.statusBarOrientation.isLandscape {
            //是横屏让变回竖屏
            setNewOrientation(fullScreen: false)
        }
         */
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return user.mapIndex
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : LXTMapCell = tableView.dequeueReusableCell(withIdentifier: "cell") as! LXTMapCell
        cell.monster = self.dataSource[indexPath.row]
        cell.selectionStyle = .none
        cell.hangUpLabel.isHidden = !(indexPath.row == user.mapIndex - 1)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        user.mapIndex = indexPath.row
        LXTUserManager().lxt_saveUser(user: user)
        self.changeMap(indexPath.row)
        self.dismiss(animated: true) {}
    }
    
    //MARK: - 分割线
    
    /*
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
 */

}
