//
//  SparkKit.swift
//  SparkBase
//
//  Created by sfh on 2023/12/20.
//  Copyright © 2023 Spark. All rights reserved.
//

import Foundation
import UIKit

public enum SPARK {
    /// WINDOW
    public static var WINDOW: UIWindow? {
        if #available(iOS 13.0, *) {
            if let window = UIApplication.shared.delegate?.window {
                return window
            }
            let sence = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene
            let window = sence?.windows.first(where: { $0.isKeyWindow })
            return window ?? UIWindow()
        } else {
            return UIApplication.shared.keyWindow
        }
    }

    /// SCREEN_BOUNDS
    public static var SCREEN_BOUNDS: CGRect { UIScreen.main.bounds }
    /// SCREEN_SIZE
    public static var SCREEN_SIZE: CGSize { SCREEN_BOUNDS.size }
    /// SCREEN_WIDTH
    public static var SCREEN_WIDTH: CGFloat { SCREEN_BOUNDS.size.width }
    /// SCREEN_HEIGHT
    public static var SCREEN_HEIGHT: CGFloat { SCREEN_BOUNDS.size.height }
    /// SCREEN_SCALE
    public static var SCREEN_SCALE: CGFloat { UIScreen.main.scale }
    /// SCREEN_CENTER
    public static var SCREEN_CENTER: CGPoint { CGPoint(x: SCREEN_WIDTH / 2, y: SCREEN_HEIGHT / 2) }
    /// 状态栏高度
    public static var statusBarHeight: CGFloat { WINDOW?.safeAreaInsets.top ?? 0 }
    /// 导航栏高度
    public static var navBarHeight: CGFloat { 44.0 }
    /// 顶部高度 = 状态栏高度 + 导航栏高度
    public static var topFullHeight: CGFloat { statusBarHeight + navBarHeight }
    /// 底部安全区高度
    public static var safeAreaHeight: CGFloat { WINDOW?.safeAreaInsets.bottom ?? 0 }
    /// tabbar高度
    public static var tabBarHeight: CGFloat { 49.0 }
    /// 底部高度 = 底部安全区高度 + tabbar高度
    public static var BotFullHeight: CGFloat { safeAreaHeight + tabBarHeight }
}

// MARK: - 获取当前显示的控制器

public extension SPARK {
    weak static var visibleVC: UIViewController? {
        weak var vc = WINDOW?.rootViewController
        while true {
            if vc?.isKind(of: UITabBarController.self) ?? false {
                vc = (vc as? UITabBarController)?.selectedViewController
            } else if vc?.isKind(of: UINavigationController.self) ?? false {
                vc = (vc as? UINavigationController)?.visibleViewController
            } else if vc?.presentedViewController != nil {
                vc = vc?.presentedViewController
            } else {
                break
            }
        }
        return vc
    }
    
    weak static var topVC: UIViewController? {
        func topVC(_ vc: UIViewController? = nil) -> UIViewController? {
            let vc = vc ?? WINDOW?.rootViewController
            if let nv = vc as? UINavigationController, !nv.viewControllers.isEmpty {
                return topVC(nv.topViewController)
            }
            if let tb = vc as? UITabBarController, let select = tb.selectedViewController {
                return topVC(select)
            }
            if let _ = vc?.presentedViewController, let nvc = visibleVC?.navigationController {
                return topVC(nvc)
            }
            return vc
        }
        let vc = WINDOW?.rootViewController
        return topVC(vc)
    }
}

// MARK: - 简便方法

public extension SPARK {
    
    /// 在主线程调佣
    static func mainThread(_ work: @escaping @convention(block) () -> Void) {
        DispatchQueue.main.async(execute: work)
    }
    
    /// 延迟调用
    static func delay(second: Double, work: @escaping @convention(block) () -> Void) {
        DispatchQueue.global().asyncAfter(deadline: .now() + second, execute: work)
    }
}
