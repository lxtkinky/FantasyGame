//
//  LXTRoleController.swift
//  FantasyGame
//
//  Created by ULDD on 2020/7/17.
//  Copyright © 2020 LXT. All rights reserved.
//

import UIKit

class LXTRoleController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var hero = LXTHeroModel()
    let hpLabel = UILabel()
    let attackLabel = UILabel()
    let tableView = UITableView()
    let cellKey = "cellKey"
    var dataSource : Array<String> = []
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.lxt_updateUIWithData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        self.lxt_initSubView()
        
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(lxt_updateUIWithData), name: NotificationNameUpdateHero, object: nil)
    }
    
    func lxt_initSubView() {
//        self.view.addSubview(self.hpLabel)
//        self.hpLabel.snp.makeConstraints { (make) in
//            make.left.equalToSuperview().offset(10)
//            make.top.equalToSuperview().offset(100)
//        }
//
//        self.view.addSubview(self.attackLabel)
//        self.attackLabel.snp.makeConstraints { (make) in
//            make.left.equalTo(self.hpLabel)
//            make.top.equalTo(self.hpLabel.snp.bottom).offset(10)
//        }
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.bounces = false
        self.tableView.separatorStyle = .none
        self.tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: self.cellKey)
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets(top: statusBarHeight + 20, left: 0, bottom: 0, right: 0))
        }
    }
    
    @objc func lxt_updateUIWithData() {
        self.hero = LXTRoleManager.lxt_loadHero()
        self.dataSource.removeAll()
        self.dataSource.append("生命：\(self.hero.hp)")
        self.dataSource.append("等级：\(self.hero.level)")
        self.dataSource.append("攻击：\(self.hero.attack)")
        self.dataSource.append("魔法：\(self.hero.mp)")
//        self.dataSource.append("攻击：\(self.hero.attack)")
//        self.dataSource.append("攻击：\(self.hero.attack)")
//        self.dataSource.append("攻击：\(self.hero.attack)")
        self.tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellKey)
        cell?.textLabel?.text = self.dataSource[indexPath.row]
        cell?.selectionStyle = .none
        return cell!
    }
}
