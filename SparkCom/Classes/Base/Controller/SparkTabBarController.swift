//
//  SparkTabBarController.swift
//  SparkBase
//
//  Created by sfh on 2023/12/22.
//  Copyright © 2023 Spark. All rights reserved.
//

import UIKit
import Kingfisher
import Lottie
import CYLTabBarController

@objc(SparkTabBarController)
open class SparkTabBarController: CYLTabBarController {

    open override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 13.0, *) {
            let line: UIView = UIView.init(frame: CGRect(x: 0, y: 0, width: SCREENW, height: 1))
            line.backgroundColor = .hex_F5F6F9
            self.tabBar.addSubview(line)
            self.tabBar.shadowImage = UIImage()
            self.tabBar.backgroundImage =  UIImage()
        } else {
            let view:UIView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: SCREENW, height: 1))
            view.backgroundColor = .hex_F5F6F9
            self.tabBar.shadowImage = GetImageFromView(view: view)
        }

        tabBar.unselectedItemTintColor = .hex_222222
        tabBar.backgroundColor = .white
        tabBar.tintColor = .hex_008AFF
        tabBar.isTranslucent = false
    }
    
    /// view转成image
    fileprivate func GetImageFromView(view: UIView) -> UIImage {
        UIGraphicsBeginImageContext(view.bounds.size)
        let ctx: CGContext = UIGraphicsGetCurrentContext()!
        view.layer.render(in: ctx)
        let img: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return img
    }
    

    //MARK: - 转屏相关
    
    open override var shouldAutorotate: Bool {
        return self.selectedViewController!.shouldAutorotate
    }
    
    open override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return self.selectedViewController?.supportedInterfaceOrientations ?? UIInterfaceOrientationMask.portrait
    }
 
    open override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return self.selectedViewController!.preferredInterfaceOrientationForPresentation
    }

}
