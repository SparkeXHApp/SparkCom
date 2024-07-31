//
//  UIDevice+Ex.swift
//  SparkBase
//
//  Created by sfh on 2023/3/2.
//  Copyright © 2023 Spark. All rights reserved.
//

import Foundation

public extension UIDevice {
    
    /** 屏幕的宽度 */
    @objc static func getScreenWith() -> CGFloat {
        return UIScreen.main.bounds.size.width
    }
    
    /** 屏幕的高度 */
    @objc static func getScreenHeight() -> CGFloat {
        return UIScreen.main.bounds.size.height
    }
    
    /** 顶部安全区高度 */
    @objc static func topSafeAreaHeight() -> CGFloat {
        if #available(iOS 13.0, *) {
            let scene = UIApplication.shared.connectedScenes.first
            guard let windowScene = scene as? UIWindowScene else {
                return 0
            }
            guard let window = windowScene.windows.first else {
                return 0
            }
            return window.safeAreaInsets.top
        } else if #available(iOS 11.0, *) {
            guard let window = UIApplication.shared.windows.first else {
                return 0
            }
            return window.safeAreaInsets.top
        }
        
        return 0
    }
    
    /** 底部安全区高度 */
    @objc static func bottomSafeAreaHeight() -> CGFloat {
        if #available(iOS 13.0, *) {
            let scene = UIApplication.shared.connectedScenes.first
            guard let windowScene = scene as? UIWindowScene else {
                return 0
            }
            guard let window = windowScene.windows.first else {
                return 0
            }
            return window.safeAreaInsets.bottom
        } else if #available(iOS 11.0, *) {
            guard let window = UIApplication.shared.windows.first else {
                return 0
            }
            return window.safeAreaInsets.bottom
        }
        
        return 0
    }
    
    /** 顶部状态栏高度(包括安全区) */
    @objc static func statusBarHeight() -> CGFloat {
        var statusBarHeight: CGFloat = 0.0
        if #available(iOS 13.0, *) {
            let scene = UIApplication.shared.connectedScenes.first
            guard let windowScene = scene as? UIWindowScene else {
                return 0
            }
            //i0S14后不准确
//            guard let statusBarManager = windowScene.statusBarManager else {
//                return 0
//            }
//            statusBarHeight = statusBarManager.statusBarFrame.height
            guard let window = windowScene.windows.first else {
                return 0
            }
            return window.safeAreaInsets.top
        } else  {
            statusBarHeight = UIApplication.shared.statusBarFrame.height
        }
        
        return statusBarHeight
    }
    
    /** 顶部导航栏高度 */
    @objc static func topNavBarHeight() -> CGFloat {
        return isIPad ? 50.0 : 44.0
    }
    
    /** 导航栏 + 状态栏的高度 */
    @objc static func navBarAndStatusBarHeight() -> CGFloat {
        return UIDevice.topNavBarHeight() + UIDevice.statusBarHeight()
    }
    
    /** 底部导航栏高度 */
    @objc static func bottomTabBarHeight() -> CGFloat {
        return 49.0
    }
    
    /** 底部导航栏 + 底部安全区的高度 */
    @objc static func tabBarAndBottomSafeAreaHeight() -> CGFloat {
        return UIDevice.bottomTabBarHeight() + UIDevice.bottomSafeAreaHeight()
    }
}
