//
//  UINavigationController_Ex.swift
//  appcommon_Example
//
//  Created by sfh on 2023/12/26.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import UIKit

public extension UINavigationController {
    
    func removeCenterVC() {
        if let first = self.viewControllers.first,
           let last = self.viewControllers.last {
            self.viewControllers = [first, last]
        }
    }
}
