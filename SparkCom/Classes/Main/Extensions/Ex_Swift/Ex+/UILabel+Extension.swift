//
//  UILabel+Extension.swift
//  SparkBase
//
//  Created by sfh on 2022/8/26.
//  Copyright © 2022 Spark. All rights reserved.
//

import Foundation
import UIKit

public extension UILabel {
    
    /** 白色背景、不指定文字和圆角 */
    convenience init(textColor: UIColor, font: CGFloat, weight: UIFont.Weight, aligment: NSTextAlignment) {
        
        self.init(bgColor: UIColor.white, textColor: textColor, font: font, weight: weight, aligment: aligment, radius: 0.0)
        
    }
    
    /** 白色背景、不指定圆角 */
    convenience init(text: String, textColor: UIColor, font: CGFloat, weight: UIFont.Weight, aligment: NSTextAlignment) {
        
        self.init(bgColor: UIColor.white, text: text, textColor: textColor, font: font, weight: weight, aligment: aligment, radius: 0.0)
        
    }

    /** 白色背景、不指定文字 */
    convenience init(textColor: UIColor, font: CGFloat, weight: UIFont.Weight, aligment: NSTextAlignment, radius: CGFloat) {
        
        self.init(bgColor: UIColor.white, textColor: textColor, font: font, weight: weight, aligment: aligment, radius: radius)
        
    }
    
    /** 不指定文字和圆角 */
    convenience init(bgColor: UIColor, textColor: UIColor, font: CGFloat, weight: UIFont.Weight, aligment: NSTextAlignment) {
        
        self.init(bgColor: bgColor, textColor: textColor, font: font, weight: weight, aligment: aligment, radius: 0.0)
        
    }
    
    /** 不指定圆角 */
    convenience init(bgColor: UIColor, text: String, textColor: UIColor, font: CGFloat, weight: UIFont.Weight, aligment: NSTextAlignment) {
        
        self.init(bgColor: bgColor, text: text, textColor: textColor, font: font, weight: weight, aligment: aligment, radius: 0.0)
        
    }
    
    /** 不指定文字 */
    convenience init(bgColor: UIColor, textColor: UIColor, font: CGFloat, weight: UIFont.Weight, aligment: NSTextAlignment, radius: CGFloat) {
        
        self.init(bgColor: bgColor, text: "", textColor: textColor, font: font, weight: weight, aligment: aligment, radius: radius)
        
    }
    
    /** 需要指定所有基本属性 */
    convenience init(bgColor: UIColor = .clear,
                     text: String = "",
                     textColor: UIColor = .black,
                     font: CGFloat = 14.0,
                     weight: UIFont.Weight = .regular,
                     aligment: NSTextAlignment = .center,
                     radius: CGFloat = 0.0) {
        
        // 便利构造方法必须依赖于指定构造方法!!!!!!!!!!!!!!
        self.init()
        
        self.backgroundColor = bgColor
        self.text = text
        self.textColor = textColor
        self.font = UIFont.systemFont(ofSize: font, weight: weight)
        self.textAlignment = aligment
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
        
    }
}
