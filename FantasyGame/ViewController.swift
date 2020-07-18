//
//  ViewController.swift
//  FantasyGame
//
//  Created by ULDD on 2020/7/14.
//  Copyright © 2020 LXT. All rights reserved.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    var heroView : LXTHeroView?
    var monsterView : LXTMonsterView?
    var hero : LXTHeroModel?
    var monster : LXTMonsterModel?
    var playStatus = 0
    var playTimer : Timer?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hero = self.lxt_loadHero()
        let heroView = LXTHeroView()
        self.heroView = heroView
        self.heroView?.role = self.hero
        self.view.addSubview(heroView)
        heroView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10)
            make.top.equalToSuperview().offset(100)
            make.size.equalTo(CGSize(width: kScreenWidth / 3, height: 5))
        }
        
        
        self.monster = LXTMonsterModel()
        let monsterView = LXTMonsterView()
        self.monsterView = monsterView
        self.monsterView?.role = self.monster
        self.view.addSubview(monsterView)
        monsterView.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-10)
            make.top.equalToSuperview().offset(100)
            make.size.equalTo(CGSize(width: kScreenWidth / 3, height: 5))
        }
        
//        let pkButton = UIButton()
//        pkButton.setTitle("start", for: .normal)
//        pkButton.addTarget(self, action: #selector(ViewController.lxt_pk), for: .touchUpInside)
//        pkButton.layer.cornerRadius = 25
//        pkButton.clipsToBounds = true
//        pkButton.backgroundColor = kRandomColor()
//        self.view.addSubview(pkButton)
//        pkButton.snp.makeConstraints { (make) in
//            make.center.equalToSuperview()
//            make.size.equalTo(CGSize(width: 100, height: 50))
//        }
        
        self.playTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true
            , block: { (timer) in
                self.lxt_pk()
        })
    }

    @objc func lxt_pk() -> Void {
        if self.hero!.currentHP <= 0 || self.monster!.currentHP <= 0 {
            self.playStatus = 0
            self.hero = self.lxt_loadHero()
            self.monster = LXTMonsterModel()
            self.heroView?.role = self.hero
            self.monsterView?.role = self.monster
        }else{
            if self.playStatus == 0 {
                self.playStatus = 1
                self.monster?.currentHP -= self.hero!.attack
                self.monsterView?.role = self.monster
            }else{
                self.playStatus = 0
                self.hero?.currentHP -= self.monster!.attack
                self.heroView?.role = self.hero
            }
            
            if self.hero!.currentHP <= 0 || self.monster!.currentHP <= 0{
                if arc4random() % 2 == 0 {
                    self.hero?.hp += 1
                }else{
                    self.hero?.attack += 1
                }
                
                self.lxt_saveHero(hero: self.hero!)
            }
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
            print("\(documentPath!)/data/role/hero.data")
            if let _ = try? data.write(to: URL(fileURLWithPath: documentPath! + "/data/role/hero.data")){
                print("保存数据成功")
            }else{
                print("写入文件失败")
            }
        }else{
            print("失败1")
        }
    }
    
    func lxt_loadHero() -> LXTHeroModel {
//        if let data = try? Data(contentsOf: URL(fileURLWithPath: documentPath! + "/data/role/hero.data")){
//            let hero = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? LXTHeroModel
//            return hero ?? LXTHeroModel.init()
//        }else{
//            return LXTHeroModel.init()
//        }
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

