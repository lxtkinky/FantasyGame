//
//  LXTStringHelper.swift
//  FantasyGame
//
//  Created by ULDD on 2020/8/27.
//  Copyright © 2020 LXT. All rights reserved.
//

import UIKit
import CoreText

class LXTStringHelper: NSObject {

//    let font = UIFont(name: PingFangSCRegular, size: 12)
//    let frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: 1000)
//    let text = "8月27日08:30巴西杯 维多利亚 vs 赛阿拉 中超 青岛黄海 vs 河北华夏，8月27日 08:30 巴西杯 维多利亚 vs 赛阿拉 20:00 中超 青岛黄海 vs 河北华夏河北 巴西杯 维多利亚 vs 赛阿拉 20:00 中超 青岛黄海 vs 河北华夏河北"
//    let strArr = LXTStringHelper.lxt_getLinesArrayOfStringInLabel(text: text, font: font!, rect: frame)
    
    /// 获取每一行的文字
    /// - Parameters:
    ///   - text: 文本
    ///   - font: 字体
    ///   - rect: 文本宽高,尽量大一点
    /// - Returns: 每一行的文字数组
    class func lxt_getLinesArrayOfStringInLabel(text : String, font : UIFont, rect : CGRect) -> Array<String>{

        let myFont = CTFontCreateWithName(font.fontName as CFString, font.pointSize, nil)
        let attStr = NSMutableAttributedString(string: text)
        attStr.addAttribute(.font, value: myFont, range: NSRange(location: 0, length: attStr.length))
        let frameSetter = CTFramesetterCreateWithAttributedString(attStr)
        let path = CGMutablePath()
        path.addRect(CGRect(x: 0, y: 0, width: rect.size.width, height: 10000))
        let frame = CTFramesetterCreateFrame(frameSetter, CFRange(location: 0, length: 0), path, nil)
        let lines = CTFrameGetLines(frame) as! Array<Any>
        var linesArray = Array<String>()
        for line in lines {
            let lineRange = CTLineGetStringRange(line as! CTLine)
            let startIndex = text.index(text.startIndex, offsetBy: lineRange.location)
            let endIndex = text.index(text.startIndex, offsetBy: lineRange.location + lineRange.length)
            let lineString = String(text[startIndex..<endIndex])
            CFAttributedStringSetAttribute(attStr, lineRange, kCTKernAttributeName, 0.0 as CFTypeRef)
            CFAttributedStringSetAttribute(attStr, lineRange, kCTKernAttributeName, 0.0 as CFTypeRef)
            linesArray.append(lineString)
        }
        return linesArray
    }
    
//    + (NSArray *)getLinesArrayOfStringInLabel:(UILabel *)label{
//        NSString *text = [label text];
//        UIFont *font = [label font];
//        CGRect rect = [label frame];
//
//        CTFontRef myFont = CTFontCreateWithName(( CFStringRef)([font fontName]), [font pointSize], NULL);
//        NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:text];
//        [attStr addAttribute:(NSString *)kCTFontAttributeName value:(__bridge  id)myFont range:NSMakeRange(0, attStr.length)];
//        CFRelease(myFont);
//        CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString(( CFAttributedStringRef)attStr);
//        CGMutablePathRef path = CGPathCreateMutable();
//        CGPathAddRect(path, NULL, CGRectMake(0,0,rect.size.width,100000));
//        CTFrameRef frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, 0), path, NULL);
//        NSArray *lines = ( NSArray *)CTFrameGetLines(frame);
//        NSMutableArray *linesArray = [[NSMutableArray alloc]init];
//        for (id line in lines) {
//            CTLineRef lineRef = (__bridge  CTLineRef )line;
//            CFRange lineRange = CTLineGetStringRange(lineRef);
//            NSRange range = NSMakeRange(lineRange.location, lineRange.length);
//            NSString *lineString = [text substringWithRange:range];
//            CFAttributedStringSetAttribute((CFMutableAttributedStringRef)attStr, lineRange, kCTKernAttributeName, (CFTypeRef)([NSNumber numberWithFloat:0.0]));
//            CFAttributedStringSetAttribute((CFMutableAttributedStringRef)attStr, lineRange, kCTKernAttributeName, (CFTypeRef)([NSNumber numberWithInt:0.0]));
//            //NSLog(@"''''''''''''''''''%@",lineString);
//            [linesArray addObject:lineString];
//        }
//
//        CGPathRelease(path);
//        CFRelease( frame );
//        CFRelease(frameSetter);
//        return (NSArray *)linesArray;
//    }
}
