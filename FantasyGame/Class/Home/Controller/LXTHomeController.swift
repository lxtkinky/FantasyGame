//
//  LXTHomeController.swift
//  FantasyGame
//
//  Created by ULDD on 2020/7/14.
//  Copyright © 2020 LXT. All rights reserved.
//

import UIKit

//var nextMonster : LXTMonsterModel?
var nextCopy : LXTCopyModel?
var currentCopy : LXTCopyModel?
var copyCount = 0

class LXTHomeController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var heroView : LXTHeroView?
    var monsterView : LXTMonsterView?
    var hero : LXTHeroModel?
    var monster : LXTMonsterModel?
    var playStatus = 0
    var playTimer : Timer?
    var dataSource = [""]
    var tableView = UITableView()
//    var expLabel = UILabel()
    let expStrip = LXTExpStripView()
    let goldLabel = UILabel()
    let ybLabel = UILabel()
    
    var showOfflineRevenue = true     //离线收益是否结算
    var offlineResult : String?
    let offlineResLabel = UILabel()
    var pkCount = 1           //回合
    
    let menuView = LXTFuncMenuView()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        var titleLabel : UILabel?
        if cell?.contentView.subviews.count == 0 {
            titleLabel = UILabel()
            titleLabel?.textColor = titleColor51
            titleLabel?.font = UIFont(name: PingFangSCRegular, size: 12)
            titleLabel?.numberOfLines = 0
            titleLabel?.tag = 1001
            cell?.contentView.addSubview(titleLabel!)
            titleLabel?.snp.makeConstraints({ (make) in
                make.left.equalToSuperview().offset(10)
                make.right.equalToSuperview().offset(-10)
                make.top.equalToSuperview().offset(3)
                make.bottom.equalToSuperview().offset(-3)
            })
        }else{
            titleLabel = cell?.contentView.viewWithTag(1001) as? UILabel
        }
        titleLabel?.text = self.dataSource[indexPath.row]
        cell?.selectionStyle = .none
        cell?.backgroundColor = .clear
        return cell!
    }
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
//        self.backButton.isHidden = true
//        print("\(user.userName) 编号 : \(user.userID)")
        
        self.lxt_registerNotification()
        
//        print("Int.max = \(Int.max)")
//        print("Int64.max = \(Int64.max)")
        
        if showOfflineRevenue {
            self.offlineResult = LXTRoleManager.lxt_offlineRevenue()
//            self.offlineRevenue = false
            if let result = self.offlineResult{
                self.offlineResLabel.text = result
                self.offlineResLabel.textColor = .green
                self.offlineResLabel.textAlignment = .center
                self.offlineResLabel.isHidden = true
                self.offlineResLabel.frame = CGRect(x: 0, y: kScreenHeight - 200, width: kScreenWidth, height: 20)
                self.view.addSubview(self.offlineResLabel)
//                self.offlineResLabel.snp.makeConstraints { (make) in
//                    make.centerX.equalToSuperview()
//                    make.bottom.equalToSuperview().offset(-200)
//                }
            }
        }
        
        
//        self.hero = LXTRoleManager.lxt_loadHero()
//        var skillArray = Array<LXTHeroSkillModel>(repeating: LXTHeroSkillModel(), count: 6)
//        for item in LXTHeroSkillDBHelper.lxt_queryHeroSkillByHeroID(heroID: self.hero!.heroID, battle: true) {
//            skillArray[item.index - 1] = item
//        }
//        self.hero?.skills = skillArray
        self.hero = heroArray[0]
        let heroView = LXTHeroView()
        self.heroView = heroView
        self.heroView?.role = self.hero
        self.view.addSubview(heroView)
        heroView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10)
            make.top.equalToSuperview().offset(100)
            make.size.equalTo(CGSize(width: kScreenWidth / 3, height: 8))
        }
        
        
        self.monster = monsterArray[user.mapIndex].copy() as? LXTMonsterModel
//        self.monster?.level = self.hero!.mapLevel
        let monsterView = LXTMonsterView()
        self.monsterView = monsterView
        self.monsterView?.role = self.monster
        self.view.addSubview(monsterView)
        monsterView.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-10)
            make.top.equalToSuperview().offset(100)
            make.size.equalTo(CGSize(width: kScreenWidth / 3, height: 8))
        }
        
       
        self.lxt_initSubView()

        self.playTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true
            , block: { (timer) in
                self.lxt_pk()
        })
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.lxt_animateOfflineResult()
    }
    
    func lxt_animateOfflineResult() {
        if showOfflineRevenue{
            DispatchQueue(label: "com.lxt.offline").asyncAfter(deadline: .now() + .seconds(1)) {
                DispatchQueue.main.async {
                    var frame = self.offlineResLabel.frame
                    self.offlineResLabel.isHidden = false
                    frame.origin.y -= 300
                    UIView.animate(withDuration: 2, animations: {
                        self.offlineResLabel.frame = frame
                    }) { (finish) in
                        self.offlineResLabel.isHidden = true
                        self.showOfflineRevenue = false
                    }
                }
            }
        }
    }
    
    func lxt_initSubView(){
        
        weak var weakSelf = self
        self.menuView.dataSource = ["地图", "藏书阁", "装备店", "强化", "宗门"]
        self.view.addSubview(self.menuView)
        self.menuView.selectMenuBlock = { index in
            weakSelf?.lxt_menuAction(index: index)
        }
        self.menuView.snp.makeConstraints { (make) in
            make.top.equalTo(self.heroView!.snp.bottom).offset(20)
            make.left.right.equalToSuperview()
            make.height.equalTo(120)
        }
        
        let backColor = UIColor.black.withAlphaComponent(0.3)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.backgroundColor = backColor
        self.tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "cell")
        self.view.addSubview(self.tableView)
        self.tableView.separatorStyle = .none
        self.tableView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-55)
//            make.height.equalToSuperview().multipliedBy(0.5)
//            make.top.equalTo(self.menuView.snp.bottom)
            make.height.equalTo(kScreenHeight * 0.5 - 55)
        }
        
//        self.view.addSubview(self.expStrip)
//        self.expStrip.hero = self.hero!
//        self.expStrip.snp.makeConstraints { (make) in
//            make.left.equalToSuperview()
//            make.right.equalToSuperview()
//            make.top.equalToSuperview().offset(statusBarHeight + 20)
//            make.height.equalTo(10)
//        }
        
        self.goldLabel.font = UIFont(name: PingFangSCRegular, size: 12)
        self.goldLabel.textColor = titleColor51
        self.goldLabel.text = "金币：\(user.goldNum)"
        self.view.addSubview(self.goldLabel)
        self.goldLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10)
            make.top.equalToSuperview().offset(statusBarHeight + 20)
        }
        
        self.ybLabel.font = UIFont(name: PingFangSCRegular, size: 12)
        self.ybLabel.textColor = titleColor51
        self.ybLabel.text = "金币：\(user.ybNum)"
        self.view.addSubview(self.ybLabel)
        self.ybLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(100)
            make.top.equalToSuperview().offset(statusBarHeight + 20)
        }
    }
    
    func lxt_registerNotification() -> Void {
        NotificationCenter.default.addObserver(self, selector: #selector(lxt_appActive), name: KNotificationAppActive, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(lxt_heroSkillChange), name: KNotificationHeroSkillChange, object: nil)
    }
    
    func lxt_menuAction(index : Int) {
        if index == 0 {
            self.lxt_mapClick()
        }else if(index == 1){
            let skillVC = LXTSikllLibController()
            skillVC.modalPresentationStyle = .fullScreen
            self.present(skillVC, animated: false) {}
        }else if(index == 2){
            self.lxt_equipShopClick()
        }else if(index == 3){
            let strongVC = LXTStrongController()
            strongVC.modalPresentationStyle = .fullScreen
            self.present(strongVC, animated: false) {}
        }
    }
    
    @objc func lxt_appActive() -> Void {
        self.showOfflineRevenue = true
    }
    
    @objc func lxt_heroSkillChange(){
        var skillArray = Array<LXTHeroSkillModel>(repeating: LXTHeroSkillModel(), count: 6)
        for item in LXTHeroSkillDBHelper.lxt_queryHeroSkillByHeroID(heroID: self.hero!.heroID, battle: true) {
            skillArray[item.index - 1] = item
        }
        self.hero?.skills = skillArray
    }
    
    @objc func lxt_restHero()  {
    }
    
    @objc func lxt_equipShopClick()  {
        let shopVC = LXTEquipShopController()
        shopVC.modalPresentationStyle = .fullScreen
        self.present(shopVC, animated: false) {}
    }
    
    @objc func lxt_mapClick() {
        let mapVC = LXTMapController()
        mapVC.modalPresentationStyle = .fullScreen
        mapVC.changeMap = { mapLevel in
//            self.hero?.mapLevel = mapLevel
//            self.monster?.level = mapLevel
//            LXTRoleManager.lxt_saveHero(hero: self.hero!)
//            self.monster = LXTHeroTableHelper.lxt_queryAllMonster()[mapLevel]
        }
        self.present(mapVC, animated: false) {}
        
//        DispatchQueue(label: "com.lxt.xxx").async {
//            var count = 0
//            for _ in 1...365 * 24 * 60 * 60 / 5 {
//                if arc4random() % 100 == 1{
//                    if arc4random() % 1000 == 1 {
//                        count += 1
//                    }
//                }
//            }
//            print("一年增加\(count)")
//        }
    }
    
    @objc func lxt_pk() -> Void {
        if self.hero!.currentHP <= 0 || self.monster!.currentHP <= 0 {
            //计算战斗结果
            if self.monster!.currentHP <= 0 {
                if currentCopy != nil {
                    for item in currentCopy!.sundries {
                        let _ = LXTGoodsSQliteHelper.lxt_addGoods(goods: item)
                    }
                    
                    if currentCopy!.isTrailCopy {
                        user.trialCount += 1
                    }
                    
                }else{
                    if Int(arc4random()) % probability == 1 {
                        if arc4random() % 5 == 1 {
                            self.hero?.attack += 1
                            self.dataSource.append("战斗胜利，获得攻击+1")
                        }else{
                            self.hero?.hp += 1
                            self.dataSource.append("战斗胜利，获得生命+1")
                        }
                    }else{
                        self.dataSource.append("战斗胜利，什么都没有")
                    }
                    user.goldNum += 1
                    self.goldLabel.text = "金币：\(user.goldNum)"
                    //TODO:经验值获取修改
                    self.hero?.currentExp += self.monster!.maxExp * 100
                    if self.hero!.currentExp > self.hero!.maxExp {
                        self.hero?.currentExp = self.hero!.currentExp - self.hero!.maxExp
                        self.hero?.level += 1
                    }
                }
                
                
                self.expStrip.hero = self.hero!
                LXTRoleManager.lxt_saveHero(hero: self.hero!)
                LXTUserManager().lxt_saveUser(user: user)
                NotificationCenter.default.post(name: NotificationNameUpdateHero, object: nil)
                self.pkCount = 1
                LXTHeroSkillDBHelper.lxt_updateHeroSkillExp(exp: 1)
            }else{
                self.dataSource.append("战斗失败")
                self.pkCount = 1
            }
            
            //初始化战斗
            self.playStatus = 0
            self.hero?.currentHP = self.hero!.hp
            self.hero?.currentMP = self.hero!.mp
            self.heroView?.role = self.hero
            
//            self.monster = LXTMonsterModel()
//            self.monster?.level = self.hero!.mapLevel
            if copyCount > 0 , let _ = nextCopy {
                self.monster = nextCopy!.monster.copy() as? LXTMonsterModel
                self.monsterView?.role = self.monster
                currentCopy = nextCopy!
                copyCount -= 1
                if copyCount == 0 {
                    nextCopy = nil
                }
            }else{
//                print(user.mapIndex)
                currentCopy = nil
                self.monster = monsterArray[user.mapIndex].copy() as? LXTMonsterModel
                self.monsterView?.role = self.monster
            }
            
        }else{
            if self.playStatus == 0 {
                self.playStatus = 1
                let index = (self.pkCount - 1) % 6;
                let heroSkill = self.hero?.skills[index]
                if heroSkill!.id > 0 {
                    let attackNum = Int(Double(self.hero!.totalAttack * heroSkill!.damage) / 100.0)
                    self.monster?.currentHP -= attackNum
                    self.dataSource.append("\(self.hero!.name)对\(self.monster!.name)使出了\(heroSkill!.skill!.name)，造成\(attackNum)点伤害")
                }else{
                    self.monster?.currentHP -= self.hero!.totalAttack
                    self.dataSource.append("\(self.hero!.name)对\(self.monster!.name)使用普通攻击，造成\(self.hero!.totalAttack)点伤害")
                }
                
                self.monsterView?.role = self.monster
                
            }else{
                self.playStatus = 0
                self.hero?.currentHP -= self.monster!.attack
                self.heroView?.role = self.hero
                self.dataSource.append("\(self.monster!.name)对\(self.hero!.name)使用普通攻击，造成\(self.monster!.attack)点伤害")
                //回合加一
                self.pkCount += 1
            }
            
            if self.pkCount >= 20 {
                self.playStatus = 0
                self.hero?.currentHP = self.hero!.hp
                self.hero?.currentMP = self.hero!.mp
                self.heroView?.role = self.hero
                
                currentCopy = nil
                self.monster = LXTMonsterModel()
                self.monster?.level = self.hero!.mapLevel
                self.monster?.currentHP = self.monster!.hp
                self.monsterView?.role = self.monster
            }
        }
        
        
        
        if self.dataSource.count >= 100 {
            self.dataSource.remove(at: 0)
        }
        
//        print("count = \(self.dataSource.count)")
        
        self.tableView.reloadData()
        if self.dataSource.count < 1000 {
            let indexPath = IndexPath(row: self.dataSource.count - 1, section: 0)
            self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: false)
        }
    }
    
}
