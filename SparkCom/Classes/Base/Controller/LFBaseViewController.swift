
//
//  LFBaseViewController.swift
//  SparkBase
//
//  Created by 李凌飞 on 2018/3/12.
//  Copyright © 2018年 李凌飞. All rights reserved.
//

import UIKit
import SVProgressHUD
import FDFullscreenPopGesture

class LFBaseViewController: UIViewController {
    var nonetisShow = false
    /// 埋点功能或页面使用时长(单位:秒)，取时间戳差值
    var app_use_duration_start: TimeInterval = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 11.0, *) {
        } else {
            self.automaticallyAdjustsScrollViewInsets = false
        }
        if #available(iOS 13.0, *) {
//            UIApplication.shared.statusBarStyle = .darkContent
        }

        view.backgroundColor = .white
        navigationController?.fd_prefersNavigationBarHidden = true
        SVProgressHUD.setDefaultStyle(SVProgressHUDStyle.custom)
        SVProgressHUD.setMinimumDismissTimeInterval(1.0)
        SVProgressHUD.setBackgroundColor(UIColor(red: 0, green: 0, blue: 0, alpha: 0.5))
        SVProgressHUD.setForegroundColor(UIColor.white)
        // Do any additional setup after loading the view.
        // 全局网络提示
//        let Status = UserDefaults.standard.object(forKey: "NetStatus") as? String;
//        if Status == "None" {
        ////            Alert_Mes(title: "提示", message: "请检查网络", viewcontroll: self);
//            if nonetisShow == false{
//                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+1.0) {
//                    self.view.addSubview(self.hiddenView);
//                }
//            }
//        }
    }

    private lazy var hiddenView: SpaceStateView = {
        let hiddenView = SpaceStateView(frame: CGRect(x: 0, y: TopHeight, width: SCREENW, height: SCREENH - TopHeight))
        hiddenView.backgroundColor = LFStringColor(hex: "#ffffff", alpha: 1)
        let str = ""
        hiddenView.viewStyle(ktopH: 120 / 375 * SCREENW, imageName: "nonet.png", title: str, titleHidden: true, refrestitle: "", refreshHidden: false)
        return hiddenView
    }()
    
    /// 空白视图
    lazy var xh_noDataView: SparkEmptyView = {
        let view = SparkEmptyView(frame: CGRect(x: 0, y: TopHeight, width: SCREENW, height: SCREENH - TopHeight))
        return view
    }()
    
    /// 无网络
    lazy var xh_noNetView: SparkNoNetworkView = {
        let view = SparkNoNetworkView(frame: CGRect(x: 0, y: TopHeight, width: SCREENW, height: SCREENH - TopHeight))
        return view
    }()

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
