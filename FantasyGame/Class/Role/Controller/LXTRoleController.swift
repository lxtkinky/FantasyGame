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
    let skillCellKey = "skillCellKey"
    var dataSource : Array<String> = []
    var skillArray : Array<LXTHeroSkillModel> = Array<LXTHeroSkillModel>(repeating: LXTHeroSkillModel(), count: 6)
    let heroView = LXTHeroSimpleInfoView()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.lxt_initData()
        self.lxt_updateUIWithData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.lxt_initData()

        self.lxt_initSubView()
        
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(lxt_updateUIWithData), name: NotificationNameUpdateHero, object: nil)
    }
    
    func lxt_initData() {
//        self.hero = LXTRoleManager.lxt_loadHero()
//        self.skillArray = Array<LXTHeroSkillModel>(repeating: LXTHeroSkillModel(), count: 6)
//        for model in LXTHeroSkillDBHelper.lxt_queryHeroSkillByHeroID(heroID: 1, battle: true) {
//            self.skillArray[model.index - 1] = model
//            print("上阵技能：\(model.skill?.name ?? "未知技能")")
//        }
//        self.hero.skills = self.skillArray
//        let equipArray = LXTGoodsSQliteHelper.lxt_getAllEquipGoods(paramHeroID: self.hero.id, paramEquipType: .all)
//        for item in equipArray {
//            self.hero.equipArray[item.equipModel.type - 1] = item
//        }
        self.hero = heroArray[0]
        LXTRoleManager.lxt_updateHeroEquip()
        LXTRoleManager.lxt_updateHeroSkill()
        self.heroView.hero = self.hero
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
//        self.tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: self.cellKey)
//        self.tableView.register(LXTHeroSkillTableCell.classForCoder(), forCellReuseIdentifier: self.skillCellKey)
//        self.tableView.bounces = false
//        self.tableView.separatorStyle = .none
//        self.tableView.delegate = self
//        self.tableView.dataSource = self
//        self.view.addSubview(self.tableView)
//        self.tableView.snp.makeConstraints { (make) in
//            make.edges.equalTo(UIEdgeInsets(top: statusBarHeight + 20, left: 0, bottom: 0, right: 0))
//        }
        
        self.view.addSubview(self.heroView)
        weak var weakSelf = self
        self.heroView.skillBlock = {
            weakSelf?.lxt_chooseSkill()
        }
        self.heroView.equipBlock = {type in
            weakSelf?.lxt_chooseEquip(type: type)
        }
        self.heroView.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets(top: statusBarHeight + 20, left: 0, bottom: 0, right: 0))
        }
        
        let studyButton = UIButton(type: .custom)
        studyButton.setTitle("学习", for: .normal)
        studyButton.setTitleColor(titleColor51, for: .normal)
        studyButton.layer.cornerRadius = 3.0
        studyButton.clipsToBounds = true
        studyButton.layer.borderColor = rgba(17, 61, 104, 1).cgColor
        studyButton.layer.borderWidth = 1.0
        studyButton.addTarget(self, action: #selector(lxt_studyClick), for: .touchUpInside)
        self.view.addSubview(studyButton)
        studyButton.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-10)
            make.top.equalTo(self.heroView).offset(30)
            make.size.equalTo(CGSize(width: 50, height: 30))
        }
    }
    
    func lxt_chooseSkill() {
        let chooseVC = LXTChooseSkillController()
        chooseVC.modalPresentationStyle = .fullScreen
        self.present(chooseVC, animated: true) {}
    }
    
    func lxt_chooseEquip(type : Int) {
        let chooseVC = LXTEquipChooseController()
        chooseVC.modalPresentationStyle = .fullScreen
        chooseVC.hero = self.hero
        chooseVC.type = type + 1
        self.present(chooseVC, animated: true) {}
    }
    
    @objc func lxt_studyClick() -> Void {
        let studySkillVC = LXTStudySkillController()
        studySkillVC.modalPresentationStyle = .fullScreen
        studySkillVC.hero = LXTHeroTableHelper.lxt_queryAllHero().first
        self.present(studySkillVC, animated: true) {}
    }
    
    @objc func lxt_updateUIWithData() {
        self.hero = LXTRoleManager.lxt_loadHero()
        self.dataSource.removeAll()
        self.dataSource.append("生命：\(self.hero.hp)")
        self.dataSource.append("等级：\(self.hero.level)")
        self.dataSource.append("攻击：\(self.hero.attack)")
        self.dataSource.append("魔法：\(self.hero.mp)")
        self.dataSource.append("金币：\(user.goldNum)")
        self.dataSource.append("元宝：\(user.ybNum)")
        self.tableView.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return section == 0 ? self.dataSource.count : 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 40
        }else{
            return (kScreenWidth - 35) / 6
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 1 {
            let cell : LXTHeroSkillTableCell = tableView.dequeueReusableCell(withIdentifier: self.skillCellKey) as! LXTHeroSkillTableCell
            cell.skillArray = self.skillArray
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellKey)
        cell?.textLabel?.text = self.dataSource[indexPath.row]
        cell?.selectionStyle = .none
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            let chooseVC = LXTChooseSkillController()
            chooseVC.modalPresentationStyle = .fullScreen
            self.present(chooseVC, animated: true) {}
        }
    }
}
