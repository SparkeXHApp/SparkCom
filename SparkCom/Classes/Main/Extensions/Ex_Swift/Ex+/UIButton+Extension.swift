//
//  UIButton+Extension.swift
//  SparkBase
//
//  Created by sfh on 2022/8/29.
//  Copyright © 2022 Spark. All rights reserved.
//

import Foundation

public extension UIButton {
    
    convenience init(bgColor: UIColor, text: String, textColor: UIColor, font: UIFont, img: UIImage) {
        // 便利构造方法必须依赖于指定构造方法!!!!!!!!!!!!!!
        self.init()
        
        self.backgroundColor = bgColor
        self.setTitle(text, for: .normal)
        self.setTitleColor(textColor, for: .normal)
        self.titleLabel?.font = font
        self.setImage(img, for: .normal)
    }
}
