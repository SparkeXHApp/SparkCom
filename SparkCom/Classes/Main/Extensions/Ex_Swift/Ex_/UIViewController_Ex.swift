//
//  UIViewController_Ex.swift
//  SparkBase
//
//  Created by sfh on 2023/12/20.
//  Copyright © 2023 Spark. All rights reserved.
//

import Foundation
import UIKit

/// 添加扩展属性，用以接收协议跳转传递过来的数据
public extension UIViewController {
    private static let paramKey = UnsafeRawPointer(bitPattern: "paramKey".hashValue)!

    var xh_param: [String: Any] {
        get {
            var dic = objc_getAssociatedObject(self, Self.paramKey) as? [String: Any]
            if dic == nil {
                dic = [:]
                objc_setAssociatedObject(self, Self.paramKey, dic, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
            return dic!
        }
        set {
            objc_setAssociatedObject(self, Self.paramKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}
