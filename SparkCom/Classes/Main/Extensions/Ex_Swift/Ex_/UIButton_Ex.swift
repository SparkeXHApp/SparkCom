//
//  UIButton_Ex.swift
//  SFKit
//
//  Created by sfh on 2023/12/14.
//

import Foundation
import UIKit

/// button中图片的位置枚举
public enum ImagePosition {
    /// 图片在左
    case left
    /// 图片在右
    case right
    /// 图片在上
    case top
    /// 图片在下
    case bottom
}

public extension UIButton {

    /// 创建带图片的按钮
    ///
    /// - Parameters:
    ///   - title: 文字
    ///   - image: 图片
    ///   - state: 状态
    ///   - space: 图片与文字间距
    ///   - position: 图片的位置
    func imagePosition(title: String?, image: UIImage?, state: UIControl.State = .normal, space: CGFloat = 10, position: ImagePosition = .left) {
        self.imageView?.contentMode = .center
        self.setImage(image, for: state)
        self.titleLabel?.contentMode = .center
        self.setTitle(title, for: state)
        imageSpace(title: title ?? "", space: space, position: position)
    }
    
    /// 修改图片位置
    ///
    /// - Parameters:
    ///   - title: 文字
    ///   - space: 间距
    ///   - position: 图片的位置
    func imageSpace(title: String, space: CGFloat, position: ImagePosition) {
        guard let imageSize = self.imageView?.frame.size,
              let titleFont = self.titleLabel?.font else { return }
        let titleSize = title.size(withAttributes: [NSAttributedString.Key.font: titleFont])
        
        var titleInsets: UIEdgeInsets
        var imageInsets: UIEdgeInsets
        
        switch position {
            
        case .bottom:
            titleInsets = UIEdgeInsets(top: -(imageSize.height + titleSize.height + space),
                                       left: -(imageSize.width), bottom: 0, right: 0)
            imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -titleSize.width)
        case .top:
            titleInsets = UIEdgeInsets(top: (imageSize.height + titleSize.height + space),
                                       left: -(imageSize.width), bottom: 0, right: 0)
            imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -titleSize.width)
        case .right:
            titleInsets = UIEdgeInsets(top: 0, left: -(imageSize.width * 2), bottom: 0, right: 0)
            imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0,
                                       right: -(titleSize.width * 2 + space))
        case .left:
            titleInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -space)
            imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
        
        self.titleEdgeInsets = titleInsets
        self.imageEdgeInsets = imageInsets
    }
}


