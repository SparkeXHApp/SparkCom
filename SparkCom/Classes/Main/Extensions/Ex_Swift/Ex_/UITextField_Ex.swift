//
//  UITextField_Ex.swift
//  SFKit
//
//  Created by sfh on 2023/12/14.
//

import Foundation
import UIKit

/// 没有复制,粘贴,选择等的输入框
public class SFNoPasteTextField: UITextField {
    
    @IBInspectable public dynamic var perform: Bool = true
    
    override public func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        switch action {
        case #selector(paste(_:)), #selector(select(_:)), #selector(selectAll(_:)), #selector(cut(_:)):
            return perform
        default:
            return super.canPerformAction(action, withSender: sender)
        }
    }
}


