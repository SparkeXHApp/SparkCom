//
//  UIAlertController_Ex.swift
//  appcommon_Example
//
//  Created by sfh on 2023/12/26.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import UIKit

public extension UIAlertController {
    
    /// 系统弹窗封装
    func show(parent: UIViewController?, title: String?, message: String?, cancelTitle: String?, confirmTitle: String?, cancelComplete: (() -> Void)?, confirmComplete: (() -> Void)?) {
        weak var parent = parent
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        if let cancelTitle = cancelTitle {
            let ac = UIAlertAction(title: cancelTitle, style: .default) { (_) in
                cancelComplete?()
            }
            alert.addAction(ac)
        }
        if let confirmTitle = confirmTitle {
            let ac = UIAlertAction(title: confirmTitle, style: .default) { (_) in
                confirmComplete?()
            }
            alert.addAction(ac)
        }
        parent?.present(alert, animated: true, completion: nil)
    }
    
    func hidden(delay: TimeInterval, block: (() -> Void)? = nil) {
        SPARK.delay(second: delay) {
            SPARK.mainThread { [weak self] in
                self?.dismiss(animated: true, completion: block)
            }
        }
    }

}
