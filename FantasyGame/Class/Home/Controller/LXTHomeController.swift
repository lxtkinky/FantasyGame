//
//  LXTHomeController.swift
//  FantasyGame
//
//  Created by ULDD on 2020/7/14.
//  Copyright © 2020 LXT. All rights reserved.
//

import UIKit

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
    
    var showOfflineRevenue = true     //离线收益是否结算
    var offlineResult : String?
    let offlineResLabel = UILabel()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = self.dataSource[indexPath.row]
        cell?.selectionStyle = .none
        cell?.backgroundColor = .clear
        return cell!
    }
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.backButton.isHidden = true
        
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
        
        
        self.hero = self.lxt_loadHero()
        let heroView = LXTHeroView()
        self.heroView = heroView
        self.heroView?.role = self.hero
        self.view.addSubview(heroView)
        heroView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10)
            make.top.equalToSuperview().offset(100)
            make.size.equalTo(CGSize(width: kScreenWidth / 3, height: 8))
        }
        
        
        self.monster = LXTMonsterModel()
        self.monster?.level = self.hero!.mapLevel
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
        let mapBtn = UIButton.init(type: .custom)
        mapBtn.setTitle("map", for: .normal)
        mapBtn.layer.cornerRadius = 25
        mapBtn.clipsToBounds = true
        mapBtn.backgroundColor = kRandomColor()
        mapBtn.setTitleColor(.white, for: .normal)
        mapBtn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        mapBtn.addTarget(self, action: #selector(lxt_mapClick), for: .touchUpInside)
        self.view.addSubview(mapBtn)
        mapBtn.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-10)
            make.top.equalTo(self.monsterView!.snp_bottomMargin).offset(50)
            make.size.equalTo(CGSize(width: 50, height: 50))
        }
        
        let restBtn = UIButton.init(type: .custom)
        restBtn.setTitle("重置", for: .normal)
        restBtn.layer.cornerRadius = 25
        restBtn.clipsToBounds = true
        restBtn.backgroundColor = kRandomColor()
        restBtn.setTitleColor(.white, for: .normal)
        restBtn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        restBtn.addTarget(self, action: #selector(lxt_restHero), for: .touchUpInside)
        self.view.addSubview(restBtn)
        restBtn.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10)
            make.top.equalTo(self.monsterView!.snp_bottomMargin).offset(50)
            make.size.equalTo(CGSize(width: 50, height: 50))
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
            make.height.equalToSuperview().multipliedBy(0.5)
        }
        
        self.view.addSubview(self.expStrip)
        self.expStrip.hero = self.hero!
        self.expStrip.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalToSuperview().offset(statusBarHeight + 20)
            make.height.equalTo(10)
        }
        
    }
    
    @objc func lxt_restHero()  {
        self.hero?.attack = 10
        self.hero?.hp = 100
        self.hero?.currentHP = 100
        self.hero?.mapLevel = 1
        self.hero?.maxExp = 1000
        self.lxt_saveHero(hero: self.hero!)
    }
    
    @objc func lxt_mapClick() {
        let mapVC = LXTMapController()
        mapVC.changeMap = { mapLevel in
            self.hero?.mapLevel = mapLevel
            LXTRoleManager.lxt_saveHero(hero: self.hero!)
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
                if Int(arc4random()) % probability == 1 {
                    if arc4random() % 2 == 0 {
                        self.hero?.hp += 1
                        self.dataSource.append("战斗胜利，获得生命+1")
                    }else{
                        self.hero?.attack += 1
                        self.dataSource.append("战斗胜利，获得攻击+1")
                    }
                }else{
                    self.dataSource.append("战斗胜利，什么都没有")
                }
                self.hero?.currentExp += self.monster!.maxExp
                if self.hero!.currentExp > self.hero!.maxExp {
                    self.hero?.currentExp = self.hero!.currentExp - self.hero!.maxExp
                    self.hero?.level += 1
                }
                self.expStrip.hero = self.hero!
                self.lxt_saveHero(hero: self.hero!)
                NotificationCenter.default.post(name: NotificationNameUpdateHero, object: nil)
            }else{
                self.dataSource.append("战斗失败")
            }
            
            //初始化战斗
            self.playStatus = 0
            self.hero = LXTRoleManager.lxt_loadHero()
            self.monster = LXTMonsterModel()
            self.monster?.level = self.hero!.mapLevel
            self.heroView?.role = self.hero
            self.monsterView?.role = self.monster
        }else{
            if self.playStatus == 0 {
                self.playStatus = 1
                self.monster?.currentHP -= self.hero!.attack
                self.monsterView?.role = self.monster
                self.dataSource.append("轮子对阿呆使出了千年杀，造成\(self.hero!.attack)点伤害")
            }else{
                self.playStatus = 0
                self.hero?.currentHP -= self.monster!.attack
                self.heroView?.role = self.hero
                self.dataSource.append("阿呆对轮子使出了猴子偷桃，造成\(self.monster!.attack)点伤害")
            }
        }
        
        
        
        if self.dataSource.count >= 10 {
            self.dataSource.remove(at: 0)
        }
        
//        print("count = \(self.dataSource.count)")
        
        self.tableView.reloadData()
        if self.dataSource.count < 1000 {
            let indexPath = IndexPath(row: self.dataSource.count - 1, section: 0)
            self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
        }
    }
    
    func lxt_saveHero(hero : LXTHeroModel) -> Void {
        let fileExists = FileManager().fileExists(atPath: documentPath! + "/data/role/hero.data")
        if !fileExists {
            do {
                try FileManager().createDirectory(atPath: documentPath! + "/data/role/", withIntermediateDirectories: true, attributes: nil)
                FileManager.default.createFile(atPath: documentPath! + "/data/role/hero.data", contents: nil, attributes: nil)
            } catch  {
                print("创建文件失败")
            }
            
        }
        if let data = try? NSKeyedArchiver.archivedData(withRootObject: hero, requiringSecureCoding: true){
//            print("\(documentPath!)/data/role/hero.data")
            if let _ = try? data.write(to: URL(fileURLWithPath: documentPath! + "/data/role/hero.data")){
//                print("保存数据成功")
            }else{
                print("写入文件失败")
            }
        }else{
            print("失败1")
        }
    }
    
    func lxt_loadHero() -> LXTHeroModel {
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: documentPath! + "/data/role/hero.data"))
            let hero = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? LXTHeroModel
            return hero ?? LXTHeroModel.init()
        } catch  {
            print("解档文件失败")
        }
        return LXTHeroModel()
    }
    
}
