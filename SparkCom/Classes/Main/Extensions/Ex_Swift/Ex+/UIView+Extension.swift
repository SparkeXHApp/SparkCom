//
//  UIView+Extension.swift
//  SparkCom
//
//  Created by sfh on 2024/5/30.
//

import Foundation

struct AssociatedKeys {
    static var otherAttributeKey: String = "otherAttributeKey"
}

public extension UIView {
    public var otherAttribute: String? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.otherAttributeKey) as? String
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.otherAttributeKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}

public extension UIView {
    /// 将当前视图转为UIImage
    func asImage() -> UIImage {
//        let format = UIGraphicsImageRendererFormat()
//        format.scale = UIScreen.main.scale
//        let renderer = UIGraphicsImageRenderer(bounds: bounds, format: format)
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
        
    }
}
