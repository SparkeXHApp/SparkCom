//
//  LFNavigationController.swift
//  SparkBase
//
//  Created by 李凌飞 on 2018/3/12.
//  Copyright © 2018年 李凌飞. All rights reserved.
//

import Lottie
import SVProgressHUD
import UIKit

extension UINavigationController {
    static var savetraitCollection: UITraitCollection?
    override open var traitCollection: UITraitCollection {
        if UINavigationController.savetraitCollection == nil {
            UINavigationController.savetraitCollection = super.traitCollection
        }
        return UINavigationController.savetraitCollection ?? super.traitCollection
    }
}

open class LFNavigationController: UINavigationController, UINavigationControllerDelegate {
    var pushing = false // 防止push多次
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13, *) {
            self.modalPresentationStyle = .fullScreen
        }
        /// 设置导航栏标题
        let navBar = UINavigationBar.appearance()
//        navBar.barStyle = UIBarStyle.default
        navBar.barTintColor = UIColor.white
//        navBar.tintColor = UIColor.white
        navBar.titleTextAttributes = [
            .foregroundColor: UIColor.hex_222222,
            .font: UIFont.systemFont(ofSize: 17, weight: .medium)
        ]
//      ios 9版本需要设置背景图，否则无法隐藏黑线
        navBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navBar.shadowImage = UIImage()
//        navBar.isTranslucent = true
//        self.extendedLayoutIncludesOpaqueBars = false
        
        if #available(iOS 15.0, *) {
            let bar = UINavigationBarAppearance()
            bar.backgroundColor = UIColor.white
            bar.titleTextAttributes = [
                .foregroundColor: UIColor.hex_222222,
                .font: UIFont.systemFont(ofSize: 17, weight: .medium)
            ]
            bar.shadowImage = UIImage()
            bar.backgroundImage = UIImage()
            self.navigationController?.navigationBar.scrollEdgeAppearance = bar
            self.navigationController?.navigationBar.standardAppearance = bar
        }
        
        self.delegate = self
    }
    
    // MARK: UINavigationControllerDelegate

    private func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        self.pushing = false
    }

    /**
     # 统一所有控制器导航栏左上角的返回按钮
     # 让所有push进来的控制器，它的导航栏左上角的内容都一样
     # 能拦截所有的push操作
     - parameter viewController: 需要压栈的控制器
     - parameter animated:       是否动画
     */
    open override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        /// 这时push进来的控制器viewController，不是第一个子控制器（不是根控制器）
//        guard !viewController.isKind(of: LFSearchViewController.self) else {
//            super.pushViewController(viewController, animated: false)
//            return;
//        }
        
        if self.pushing {
            return
        } else {
            self.pushing = true
            
            if viewControllers.count > 0 {
                // push 后隐藏 tabbar
                viewController.hidesBottomBarWhenPushed = true
                viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "nav_back.png")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(self.navigationBackClick))
                
                //            let leftbtn = UIButton(type:UIButtonType.custom)
                //            leftbtn.frame = CGRect(x: 0, y:0, width: 10, height:18)
                //            leftbtn.setImage(UIImage.init(named: "xf返回按钮.png"), for: UIControlState.normal)
                //            leftbtn.addTarget(self, action: #selector(navigationBackClick), for: UIControlEvents.touchUpInside)
                //            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: leftbtn)
            }
            super.pushViewController(viewController, animated: animated)
        }
    }

    /// 返回按钮
    @objc func navigationBackClick() {
        if SVProgressHUD.isVisible() {
            SVProgressHUD.dismiss()
        }
        if UIApplication.shared.isNetworkActivityIndicatorVisible {
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
        }
        popViewController(animated: true)
    }

    open override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    open override var shouldAutorotate: Bool {
        return self.topViewController!.shouldAutorotate
    }
    
    open override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return self.topViewController!.supportedInterfaceOrientations
    }

    open override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return self.topViewController!.preferredInterfaceOrientationForPresentation
    }

    open override var childViewControllerForStatusBarStyle: UIViewController? {
        return self.topViewController
    }
     
    open override var childViewControllerForStatusBarHidden: UIViewController? {
        return self.topViewController
    }
}
