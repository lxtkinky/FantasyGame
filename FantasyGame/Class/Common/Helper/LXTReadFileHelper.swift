//
//  LXTReadFileHelper.swift
//  FantasyGame
//
//  Created by ULDD on 2020/9/4.
//  Copyright © 2020 LXT. All rights reserved.
//

import UIKit

//["1", "桃木剑", "1", "10", "10", "0", "0", "0", "1", "5", "100", "1", "0", "0", "0", "0", "0", "0", "0", "0", "0", "1", "100"]
//id name    level    attack    magic    enhance    reduce    skillID    type    maxStrongLevel    costStrongGold
//costStrongStone    speed    hp    mp    defense    magicDefense    doubleHit    hpRecovery    mpRecovery    sundriesType    buyType    priceCount

class LXTReadFileHelper: NSObject {
    class func lxt_readJsonFile(file : String) -> Any{
        let path = Bundle.main.path(forResource: file, ofType: "json")
        let url = URL(fileURLWithPath: path!)
        var jsonData : Any = []
        // 带throws的方法需要抛异常
        do {
            /*
             * try 和 try! 的区别
             * try 发生异常会跳到catch代码中
             * try! 发生异常程序会直接crash
             */
            let data = try Data(contentsOf: url)
            jsonData = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
        } catch {
            print("读取本地数据出现错误!",error)
        }
        return jsonData
    }
    
    class func lxt_loadEquipArray() -> Array<LXTEquipModel>{
        var modelArray = Array<LXTEquipModel>()
        let jsonArr = self.lxt_readJsonFile(file: "equipment") as! Array<Array<String>>
        for item in jsonArr {
            let model = LXTEquipModel()
            model.id = Int(item[0])!
            model.name = item[1]
            model.level = Int(item[2])!
            model.attack = Int(item[3])!
            model.magic = Int(item[4])!
            model.enhance = Int(item[5])!
            model.reduce = Int(item[6])!
            model.type = Int(item[8])!
            model.maxStrongLevel = Int(item[9])!
            model.costStrongGold = Int(item[10])!
            model.costStrongStone = Int(item[11])!
            model.speed = Int(item[12])!
            model.hp = Int(item[13])!
            model.mp = Int(item[14])!
            model.defense = Int(item[15])!
            model.magicDefense = Int(item[16])!
            model.doubleHit = Int(item[17])!
            model.hpRecovery = Int(item[18])!
            model.mpRecovery = Int(item[19])!
            model.sundriesType = SundriesType.init(rawValue: Int(item[20])!) ?? SundriesType.none
            model.buyType = Int(item[21])!
            model.priceCount = Int(item[22])!
            print("\(model.name) ,type = \(model.buyType), price = \(model.priceCount)")
            modelArray.append(model)
        }
        return modelArray
    }
    
    
    class func lxt_readEquipmentTxtFile() -> Array<LXTEquipModel>{
        var array = Array<Array<String>>()
        var modelArray = Array<LXTEquipModel>()
        let path = Bundle.main.path(forResource: "equipment", ofType: "txt")
        let cfEnc = CFStringEncodings.GB_18030_2000 //需要保存为GB18030格式的文件
        let enc = CFStringConvertEncodingToNSStringEncoding(CFStringEncoding(cfEnc.rawValue))
        do {
            let ret = try NSString.init(contentsOfFile: path!, encoding: enc)
            let datas = ret .components(separatedBy:"\r\n")//\r代表换行，通过换行分割成一条条的数据，放入数组
            for i in datas{
                let arrs =  i .components(separatedBy:"\t")
                array.append(arrs)
            }
            array.removeFirst()
            for item in array{
                let model = LXTEquipModel()
                model.id = Int(item[0])!
                model.name = item[1]
                model.level = Int(item[2])!
                model.attack = Int(item[3])!
                model.magic = Int(item[4])!
                model.enhance = Int(item[5])!
                model.reduce = Int(item[6])!
                model.type = Int(item[8])!
                model.maxStrongLevel = Int(item[9])!
                model.costStrongGold = Int(item[10])!
                model.costStrongStone = Int(item[11])!
                model.speed = Int(item[12])!
                model.hp = Int(item[13])!
                model.mp = Int(item[14])!
                model.defense = Int(item[15])!
                model.magicDefense = Int(item[16])!
                model.doubleHit = Int(item[17])!
                model.hpRecovery = Int(item[18])!
                model.mpRecovery = Int(item[19])!
                model.sundriesType = SundriesType.init(rawValue: Int(item[20])!) ?? SundriesType.none
                model.buyType = Int(item[21])!
                model.priceCount = Int(item[22])!
                print("\(model.name) ,type = \(model.buyType), price = \(model.priceCount)")
                modelArray.append(model)
            }
        }catch let error as NSError {
            print(error)
        }
        return modelArray
    }
    
    class func lxt_readSkillTxtFile() -> Array<LXTSkillModel>{
        var modelArray = Array<LXTSkillModel>()
        let stringArray = self.lxt_readTXTFile(file: "skill")
        for item in stringArray {
            let model = LXTSkillModel()
            model.id = Int(item[0])!
            modelArray.append(model)
        }
        return modelArray
    }
    
    class func lxt_readTXTFile(file : String) -> Array<Array<String>>{
        var array = Array<Array<String>>()
        let path = Bundle.main.path(forResource: file, ofType: "txt")
        let cfEnc = CFStringEncodings.GB_18030_2000 //需要保存为GB18030格式的文件
        let enc = CFStringConvertEncodingToNSStringEncoding(CFStringEncoding(cfEnc.rawValue))
        do {
            let ret = try NSString.init(contentsOfFile: path!, encoding: enc)
            //print(ret)
            let datas = ret .components(separatedBy:"\r\n")//\r代表换行，通过换行分割成一条条的数据，放入数组
            for i in datas{
                let arrs =  i .components(separatedBy:"\t")
                array.append(arrs)
            }
            array.removeFirst()
        }catch{
            print("读取TXT文件错误：\(error)")
        }
        return array
    }
    
    
        /*
     //读取不了
        class func lxt_readUTF8TXTFile(file : String){
            if let txtFile = Bundle.main.path(forResource: "test", ofType: "txt")
                //文件路径 txtFile为读取到的字符串路径
            {
                do {
                    let txtData = try Data(contentsOf: URL(fileURLWithPath: txtFile))// 读取数据，UTF-8格式的NSData
                    print("文件长度：\(txtData.count)")
                    print(txtData)
                    let txtContent = String(data: txtData, encoding: .utf8)
    //                String(data: txtData, encoding: String.Encoding.utf8)
                    // UTF-8格式的NSData转换成String
                    
                    print(txtContent as Any)
                    let strArray : [String] = txtContent?.components(separatedBy: "\r\n") ?? []
                    //print("\(myStringasArray)")
                    // String按照\r和\t分割成数组
                    print("==============================")
                    for item in strArray {
                        print(item)
                    }
                   print("==============================")
                    
                } catch {
                    
                }
            }
        }
     */
}
