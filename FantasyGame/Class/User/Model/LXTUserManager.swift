//
//  LXTUserManager.swift
//  FantasyGame
//
//  Created by ULDD on 2020/7/28.
//  Copyright © 2020 LXT. All rights reserved.
//

import UIKit

class LXTUserManager: NSObject {
    func lxt_saveUser(user : LXTUserModel) -> Void {
        let fileExists = FileManager().fileExists(atPath: documentPath! + "/data/user.data")
                if !fileExists {
                    do {
                        try FileManager().createDirectory(atPath: documentPath! + "/data/", withIntermediateDirectories: true, attributes: nil)
                        FileManager.default.createFile(atPath: documentPath! + "/data/user.data", contents: nil, attributes: nil)
                    } catch  {
                        print("创建文件失败")
                    }
                    
                }
                if let data = try? NSKeyedArchiver.archivedData(withRootObject: user, requiringSecureCoding: true){
        //            print("\(documentPath!)/data/role/hero.data")
                    if let _ = try? data.write(to: URL(fileURLWithPath: documentPath! + "/data/user.data")){
//                        print("保存user数据成功")
                    }else{
                        print("写入文件失败")
                    }
                }else{
                    print("失败1")
                }
    }
    
    func lxt_loadUser() -> LXTUserModel {
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: documentPath! + "/data/user.data"))
            let user = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? LXTUserModel
            return user ?? LXTUserModel()
        } catch  {
            print("解档文件失败\(error)")
        }
        return LXTUserModel()
    }
}
