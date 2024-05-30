//
//  UIView+Extension.swift
//  SparkCom
//
//  Created by sfh on 2024/5/30.
//

import Foundation

extension UIView {
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
