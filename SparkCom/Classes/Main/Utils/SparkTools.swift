//
//  SparkTools.swift
//  SparkBase
//
//  Created by sfh on 2023/12/20.
//  Copyright © 2023 Spark. All rights reserved.
//

import Foundation
import UIKit

public extension SPARK {
    static var tools: SparkTools.Type {
        return SparkTools.self
    }
}

public enum SparkTools {
    /// UserDefaults非空校验，若取不到返回空字符串
    ///
    /// - Parameter: 缓存的key
    public static func getUserDefValue(_ key: String) -> String {
        if let value = UserDefaults.standard.object(forKey: key) as? String {
            return value
        } else {
            return ""
        }
    }
    
    /// 跳转应用商城
    ///
    /// - Parameters:
    ///   - appId: 应用的id
    ///   - completion: 回调的闭包
    public static func goAppStore(appId: String, completion: ((Bool) -> Void)? = nil) {
        let urlString = "https://itunes.apple.com/cn/app/id" + appId + "?mt=12"
        if let url = URL(string: urlString) {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: completion)
            }
        }
    }
    
    /// 获得请求参数集合
    /// - Parameters:
    ///   - query: 参数字符串
    /// - Returns: 参数集合
    public static func getQueryParams(query: String) -> [String: Any]? {
        if let query = query.removingPercentEncoding {
            if query.contains("=") {
                var res: [String: Any] = [:]
                if query.contains("&") {
                    let arr = query.components(separatedBy: "&")
                    for item in arr {
                        let key = item.components(separatedBy: "=").first ?? ""
                        var value = item.components(separatedBy: "=").last ?? ""
                        if value.contains("http") {
                            value = value.removingPercentEncoding ?? ""
                        }
                        res.updateValue(value, forKey: key)
                    }
                    return res
                } else {
                    let key = query.components(separatedBy: "=").first ?? ""
                    var value = query.components(separatedBy: "=").last ?? ""
                    if value.contains("http") {
                        value = value.removingPercentEncoding ?? ""
                    }
                    res.updateValue(value, forKey: key)
                    return res
                }
            } else {
                return nil
            }
        }
        return nil
    }
    
    /// 通过字符串获取控制器类型
    /// - Parameters:
    ///   - vcName: 控制器字符串
    /// - Returns: 控制器类型
    public static func getVCClassFromString(vcName: String) -> UIViewController.Type? {
        let bundleName = Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as? String
        if let ctrlClass = NSClassFromString((bundleName ?? "") + "." + vcName) as? UIViewController.Type {
            return ctrlClass
        } else {
            return nil
        }
    }
    
    /// 通过deeplink协议打开页面
    /// - Parameters:
    ///   - url: 协议链接
    /// - Returns: Bool
    public static func openDeepLinkUrl(url: URL) -> Bool {
        // 协议："spark://com.spark.SparkOnline.hs.act.XXXXXXVC?key=24680&name=name&act=push"
        // "com.spark.SparkOnline.hs.act.XXXXXXVC"
        let host = url.host ?? ""
        // "key=24680&name=name&act=push"
        let query = url.query ?? ""
        // 参数
        let param: [String: Any] = getQueryParams(query: query) ?? [:]
        if host.components(separatedBy: ".").last != nil {
            let vcStr = host.components(separatedBy: ".").last!
            
            let currentVC = SPARK.visibleVC
            if let vcCls = getVCClassFromString(vcName: vcStr) {
                let vc = vcCls.init()
                vc.xh_param = param
                if let act = param["needLogin"] as? String, act == "true" {
                    // 需要校验登录状态的通知
                    NotificationCenter.default.post(name: NSNotification.Name("SparkNeedLoginStatus"), object: self, userInfo: nil)
                    return true
                }
                
                if let act = param["actType"] as? String, act == "push" {
                    currentVC?.navigationController?.pushViewController(vc, animated: true)
                } else {
                    if let needNav = param["needNav"] as? String, needNav == "true" {
                        // MARK: LFNavigationController
                        let nav = UINavigationController(rootViewController: vc)
                        nav.modalPresentationStyle = .fullScreen
                        currentVC?.present(nav, animated: true)
                    } else {
                        vc.modalPresentationStyle = .fullScreen
                        currentVC?.present(vc, animated: true)
                    }
                }
                return true
            } else {
                // 字符串转换类型失败的通知
                NotificationCenter.default.post(name: NSNotification.Name("SparkChangeStringToVCFailed"), object: self, userInfo: nil)
                return false
            }
        } else {
            // 协议不合法的通知
            NotificationCenter.default.post(name: NSNotification.Name("SparkSchemeFailed"), object: self, userInfo: nil)
            return false
        }
    }
    
    public static func pushLoginVc() {
//        let Status = UserDefaults.standard.object(forKey: "NetStatus") as? String
//        if Status == "None" {
//            SVProgressHUD.showInfo(withStatus: "暂无网络")
//        } else {
//            let preLoginCode = UserDefaults.standard.object(forKey: "preLoginCode") as? String ?? ""
//            let isFreeLogin = UserDefaults.standard.object(forKey: "isFreeLogin") as? String ?? ""
//            if preLoginCode == "7000", isFreeLogin == "1", JVERIFICATIONService.checkVerifyEnable() {
//                customFullScreenUI(objc: self) { btn, view in
//                    btn.addTarget(weakSelf, action: #selector(self.rightButtonClick), for: .touchUpInside)
//                    weakSelf?.customV = view
//                }
//            } else {
//                let loginVC = NewLoginViewController()
//                let navigation = LFNavigationController(rootViewController: loginVC)
//                getSuperVC(objc: self).present(navigation, animated: true, completion: nil)
//            }
//        }
    }
}
