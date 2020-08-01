//
//  AppDelegate.swift
//  FantasyGame
//
//  Created by ULDD on 2020/7/14.
//  Copyright © 2020 LXT. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow? = UIWindow(frame: UIScreen.main.bounds)
    var allowRotate = false

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window?.backgroundColor = .white
//        self.window?.rootViewController = ViewController.init()
        
//        LXTTableSQliteHelper.lxt_createTable(tableName: "user")
        LXTTableSQliteHelper.lxt_initTable()
        
        let tabBarVC = LXTTabBarController()
        let homeVC = LXTHomeController()
        homeVC.tabBarItem = UITabBarItem.init(title: "战斗", image: UIImage(named: "tabbar_home"), tag: 1001)
        
        let myVC = LXTRoleController()
        myVC.tabBarItem = UITabBarItem.init(title: "角色", image: UIImage(named: "tabbar_my"), tag: 1002)
        
        
        let trialAreaVC = LXTTrialAreaController()
        trialAreaVC.tabBarItem = UITabBarItem.init(title: "试炼", image: UIImage(named: "tabbar_my"), tag: 1003)
        
        let packageVC = LXTPackageController()
        packageVC.tabBarItem = UITabBarItem.init(title: "包裹", image: UIImage(named: "tabbar_my"), tag: 1004)
        
        tabBarVC.viewControllers = [homeVC, myVC, trialAreaVC, packageVC]
        self.window?.rootViewController = tabBarVC
        self.window?.makeKeyAndVisible()
        return true
    }
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        if self.allowRotate{
            return .all
        }else{
            return .portrait
        }
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        LXTRoleManager.lxt_saveArchiveDate()
        LXTUserManager().lxt_saveUser(user: user)
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        NotificationCenter.default.post(name: KNotificationAppActive, object: nil)
    }

    // MARK: UISceneSession Lifecycle

//    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
//        // Called when a new scene session is being created.
//        // Use this method to select a configuration to create the new scene with.
//        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
//    }
//
//    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
//        // Called when the user discards a scene session.
//        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
//        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
//    }


}

