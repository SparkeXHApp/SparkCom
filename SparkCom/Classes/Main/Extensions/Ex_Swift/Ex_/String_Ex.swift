//
//  String_Ex.swift
//  SFKit
//
//  Created by sfh on 2023/12/4.
//

import Foundation
import UIKit

public let dateFormatter = DateFormatter()

public extension String {
    /// 时间戳 转 0000-00-00 00:00:00
    ///
    /// - Parameter timeStamp: 时间戳
    /// - Returns: 年月日时分秒
    var timeStampToData: String {
        let timeSta: TimeInterval = (self as NSString).doubleValue
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = Date(timeIntervalSince1970: timeSta)
        return dateFormatter.string(from: date)
    }
    
    /// 去掉空格
    var noSpace: String {
        let whitespace = CharacterSet.whitespacesAndNewlines
        return self.trimmingCharacters(in: whitespace)
    }
    
    /// 判断字符串是否是手机号
    var isPhone: Bool {
        let regex = "^1[3|4|5|6|7|8|9][0-9]{9}$"
        let test = NSPredicate(format: "SELF MATCHES %@", regex)
        return test.evaluate(with: self)
    }
    
    /// 获取指定位置和长度的字符串
    ///
    /// - Parameters:
    ///   - start: 起始位置
    ///   - length: 长度, 默认到结束
    /// - Returns: 字符串
    func subString(start: Int, length: Int = -1) -> String? {
        if self.count < start + length { return nil }
        var len = length
        if len == -1 {
            len = self.count - start
        }
        let st = self.index(self.startIndex, offsetBy: start)
        let en = self.index(st, offsetBy: len)
        let range = st..<en
        return String(self[range])
    }
    
    /// 获取指定位置的字符串
    func subStringWith(_ index: Int) -> String? {
        if self.count <= index { return nil }
        let index = self.index(self.startIndex, offsetBy: index)
        return String(self[index])
    }
    
    /// 计算文本高度
    /// - Parameters:
    ///   - font: 字体
    ///   - width: 宽度
    /// - Returns: 文本高度
    func height(font: UIFont, width: CGFloat) -> CGFloat {
        self.boundingRect(with: CGSize(width: width, height: CGFloat(MAXFLOAT)),
                          options: .usesLineFragmentOrigin,
                          attributes: [.font: font],
                          context: nil).size.height
    }
    
    /// html字符串转NSAttributedString富文本
    /// - Parameters:
    ///   - font: 给定的字体
    ///   - lineHeight: 给定的行高
    ///   - isFit: 是否按给定的字号和行高展示富文本
    /// - Returns: NSMutableAttributedString富文本
    func htmlAttributedString(font: UIFont = UIFont.systemFont(ofSize: 15, weight: .regular), lineHeight: CGFloat = 21, isFit: Bool = false) -> NSMutableAttributedString? {
        guard let data = self.data(using: String.Encoding.utf8, allowLossyConversion: false) else { return nil }
        
        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            NSAttributedString.DocumentReadingOptionKey.characterEncoding: String.Encoding.utf8.rawValue,
            NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html,
        ]
        
        let htmlString = try? NSMutableAttributedString(data: data, options: options, documentAttributes: nil)
        
        let paraStyle = NSMutableParagraphStyle()
        paraStyle.lineBreakMode = .byWordWrapping
        paraStyle.maximumLineHeight = lineHeight
        paraStyle.minimumLineHeight = lineHeight
        if isFit {
            htmlString?.addAttributes([
                .paragraphStyle: paraStyle,
                .baselineOffset: (lineHeight - font.lineHeight) / 4,
                .font: font,
            ], range: NSMakeRange(0, htmlString?.length ?? 0))
        } else {
            htmlString?.addAttributes([
                .paragraphStyle: paraStyle,
            ], range: NSMakeRange(0, htmlString?.length ?? 0))
        }
        
        return htmlString
    }
    
    func encoding() -> String {
        if (self.isEmpty) {
            return ""
        }
        return self.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
    }
    
    func urlReplacing() -> String {
        if (self.isEmpty) {
            return ""
        }
        return self.addingPercentEncoding(withAllowedCharacters: .alphanumerics)!
    }
    
    // 正则表达式除去字符串指定的内容
    func deleteSpecialCharacters(pattern: String) -> String {
//        let pattern: String = "[^a-zA-Z0-9'´]"
        let express = try! NSRegularExpression(pattern: pattern, options: .caseInsensitive)
        return express.stringByReplacingMatches(in: self, options: [], range: NSMakeRange(0, self.count), withTemplate: "")
    }
    
    func htmlToAttributedString() -> NSMutableAttributedString {
        guard let data = data(using: .utf8) else { return NSMutableAttributedString() }
        do {
            return try NSMutableAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return NSMutableAttributedString()
        }
    }
}
