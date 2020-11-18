//
//  LXTSchemeDB.swift
//  FantasyGame
//
//  Created by ULDD on 2020/10/28.
//  Copyright © 2020 LXT. All rights reserved.
//

import UIKit
import SQLite

class LXTSchemeDB: NSObject {
    class func lxt_createTable() {
        let table = Table("scheme")
        let id = Expression<Int>("id")
        let name = Expression<String>("name")
        let type = Expression<Int>("type")
        let relationId = Expression<Int>("relationId")
        let sundriesTypes = Expression<String>("sundriesTypes")
        let sundriesCounts = Expression<String>("sundriesCounts")
        let desc = Expression<String>("desc")
        
        do {
            try db!.run(table.create(temporary: false, ifNotExists: true, withoutRowid: false, block: { (builder) in
                builder.column(id, unique: true)
                builder.column(name, defaultValue: "未知图纸")
                builder.column(type, defaultValue: 0)
                builder.column(relationId, defaultValue: 0)
                builder.column(sundriesTypes, defaultValue: "0")
                builder.column(sundriesCounts, defaultValue: "0")
                builder.column(desc, defaultValue: "未知图纸")
            }))
        } catch {
            print("创建表失败：\(error)")
        }
        
        self.lxt_initData()
    }
    
    class func lxt_saveScheme(scheme : LXTSchemeModel){
        let table = Table("scheme")
        let id = Expression<Int>("id")
        let name = Expression<String>("name")
        let type = Expression<Int>("type")
        let relationId = Expression<Int>("relationId")
        let sundriesTypes = Expression<String>("sundriesTypes")
        let sundriesCounts = Expression<String>("sundriesCounts")
        let desc = Expression<String>("desc")
        
        do {
            let filter = table.filter(id == scheme.id)
            let count = try db!.scalar(filter.count)
            if count > 0 {
                let update = filter.update(name <- scheme.name,
                                           type <- scheme.type,
                                           relationId <- scheme.relationId,
                                           sundriesTypes <- scheme.sundriesTypes,
                                           sundriesCounts <- scheme.sundriesCounts,
                                           desc <- scheme.desc
                                           )
                let _ = try db!.run(update)
            }else{
                let insert = table.insert(id <- scheme.id,
                                          name <- scheme.name,
                                         type <- scheme.type,
                                         relationId <- scheme.relationId,
                                         sundriesTypes <- scheme.sundriesTypes,
                                         sundriesCounts <- scheme.sundriesCounts,
                                         desc <- scheme.desc)
                let _ = try db!.run(insert)
            }
        } catch {
            print(error)
        }
        
    }
    
    
    class func lxt_initData(){
        let array = LXTReadFileHelper.lxt_readSchemeJson()
        print("图纸：\(array[0].name)")
        for item in array {
            self.lxt_saveScheme(scheme: item)
        }
    }
    
    class func lxt_loadAllScheme() -> Array<LXTSchemeModel>{
        
        return LXTReadFileHelper.lxt_readSchemeJson()
        
    }
}
