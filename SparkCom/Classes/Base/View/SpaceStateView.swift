//
//  SpaceStateView.swift
//  SparkBase
//
//  Created by xuzhichao on 2018/6/25.
//  Copyright © 2018年 李凌飞. All rights reserved.
// 显示到刷新button最低高度265   显示到标题最低高度200 单图片160

import UIKit

public class SpaceStateView: UIView {
    private let imgW: CGFloat = 150
    private let imgH: CGFloat = 150
    private var TopH: CGFloat = 0
    private let BottomH: CGFloat = 20
    private let KSize: CGFloat = 15

    var imgBGView: UIImageView!
    var titleLab: UILabel!
    var addBtn: UILabel!
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        loadSubView()
    }

    public func viewStyle(ktopH: CGFloat, imageName: String, title: String, titleHidden: Bool, refrestitle: String, refreshHidden: Bool) {
        TopH = ktopH

        let KW = bounds.size.width
        imgBGView.frame = CGRect(x: (KW-imgW)/2, y: TopH, width: imgW, height: imgH)
        imgBGView.image = UIImage(named: imageName)
        titleLab.frame = CGRect(x: 0, y: TopH+imgH+BottomH, width: KW, height: 15)
        titleLab.isHidden = titleHidden
        titleLab.text = title

        addBtn.frame = CGRect(x: 0, y: TopH+imgH+BottomH, width: KW, height: 20)
        addBtn.isHidden = refreshHidden
        addBtn.text = "暂无网络哦~"
    }

    public func viewStyle(ktopH: CGFloat, imageName: String, title: String, titleHidden: Bool, refrestitle: String, refreshHidden: Bool, imgW: CGFloat, imgH: CGFloat, titleFont: UIFont = UIFont.systemFont(ofSize: 15, weight: .regular)) {
        TopH = ktopH

        let KW = bounds.size.width
        imgBGView.frame = CGRect(x: (KW-imgW)/2, y: TopH, width: imgW, height: imgH)
        imgBGView.image = UIImage(named: imageName)
        titleLab.frame = CGRect(x: 0, y: TopH+imgH+BottomH, width: KW, height: 15)
        titleLab.isHidden = titleHidden
        titleLab.text = title
        titleLab.font = titleFont
        titleLab.textColor = LFStringColor(hex: "#222222", alpha: 1)
        addBtn.frame = CGRect(x: 0, y: TopH+imgH+BottomH, width: KW, height: 20)
        addBtn.isHidden = refreshHidden
        addBtn.text = "暂无网络哦~"
    }

    fileprivate func loadSubView() {
        let KW = bounds.size.width
        imgBGView = UIImageView(frame: CGRect(x: (KW-imgW)/2, y: TopH, width: imgW, height: imgH))
        addSubview(imgBGView)

        titleLab = UILabel(frame: CGRect(x: 0, y: TopH+imgH+BottomH, width: KW, height: 15))
        titleLab.font = UIFont.systemFont(ofSize: KSize)
        titleLab.textColor = LFStringColor(hex: "#C7CDD7", alpha: 1)
        titleLab.textAlignment = NSTextAlignment.center
        addSubview(titleLab)

        addBtn = UILabel(frame: CGRect(x: 0, y: TopH+imgH+BottomH, width: KW, height: 15))
        addBtn.font = UIFont.systemFont(ofSize: KSize)
        addBtn.textColor = LFStringColor(hex: "#999999", alpha: 1)
        addBtn.textAlignment = NSTextAlignment.center
        addSubview(addBtn)
        addBtn.isUserInteractionEnabled = true
        let userGesture = UITapGestureRecognizer(target: self, action: #selector(refreshData(_:)))
        addBtn.addGestureRecognizer(userGesture)
    }

    @objc func refreshData(_ sender: UIGestureRecognizer) {
        let Status = UserDefaults.standard.object(forKey: "NetStatus") as? String
        if Status == nil {
            removeFromSuperview()
            print("没有存到数据")
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "ConnetNet"), object: self, userInfo: nil)
        } else if Status == "None" {
            print("没有网络")

        } else {
            removeFromSuperview()
            print("有网络数据")
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "ConnetNet"), object: self, userInfo: nil)
        }
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func changeToAtr(str: String, repstr: String, size: Int, colorstr: String) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: str)
        let str2 = NSString(string: str)
        let theRange2 = str2.range(of: repstr)
        attributedString.addAttribute(NSAttributedStringKey.font, value: UIFont.systemFont(ofSize: CGFloat(size)), range: theRange2)
        attributedString.addAttribute(NSAttributedStringKey.foregroundColor, value: LFStringColor(hex: colorstr, alpha: 1), range: theRange2)
        return attributedString
    }
}
