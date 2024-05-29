//
//  UIView_Ex.swift
//  SFKit
//
//  Created by sfh on 2023/12/4.
//

import Foundation
import UIKit

public extension UIView {
    
    /// 返回该view所在VC
    var superVC: UIViewController? {
        for view in sequence(first: self.superview, next: { $0?.superview }) {
            if let responder = view?.next {
                if responder.isKind(of: UIViewController.self) {
                    return responder as? UIViewController
                }
            }
        }
        return nil
    }
    
    /// 返回该view所在的父view
    func superView<T: UIView>(of: T.Type) -> T? {
        for view in sequence(first: self.superview, next: { $0?.superview }) {
            if let father = view as? T {
                return father
            }
        }
        return nil
    }
    
    /// 删除所有的子视图
    func removeAllSubviews() {
        while self.subviews.count > 0 {
            self.subviews.last?.removeFromSuperview()
        }
    }
    
    /// 添加点击事件
    func addTarget(_ target: Any?, action: Selector?) {
        self.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: target, action: action)
        self.addGestureRecognizer(tap)
    }
    
    /// 设置阴影
    func makeShadow(_ cornerRadius: CGFloat = 5,
                    color: UIColor? = UIColor(red: 0, green: 0, blue: 0, alpha: 0.21),
                    offset: CGSize = CGSize.zero,
                    opacity: Float = 1)
    {
        self.layer.cornerRadius = cornerRadius
        self.layer.shadowColor = color?.cgColor
        self.layer.shadowOffset = offset
        self.layer.shadowOpacity = opacity
        self.layer.shadowRadius = cornerRadius
    }
    
    /// 设置颜色渐变
    func makeGradient(_ colors: [CGColor], 
                      locations: [NSNumber],
                      startPoint: CGPoint,
                      endPoint: CGPoint) 
    {
        let bgLayer = CAGradientLayer()
        bgLayer.colors = colors
        bgLayer.locations = locations
        bgLayer.frame = self.bounds
        bgLayer.startPoint = startPoint
        bgLayer.endPoint = endPoint
        self.layer.addSublayer(bgLayer)
    }
    
    /// 设置圆角
    func makeCornerRadius(corners: UIRectCorner, radius: CGFloat) {
        let cornerSize = CGSize(width: radius, height: radius)
        let maskPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: cornerSize)
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.path = maskPath.cgPath
        self.layer.addSublayer(maskLayer)
        self.layer.mask = maskLayer
    }
    
    /// 画带圆角的边框 - 并不会切圆角
    /// - Parameters:
    ///   - fillColor: 填充色
    ///   - strokeColor: 描边色
    ///   - lineWith: 线宽
    ///   - lineLength: 虚线单位长度
    ///   - lineSpacing: 虚线单位间距
    ///   - side: 要画线的边
    ///   - topLeft: 左上圆角
    ///   - topRight: 右上圆角
    ///   - bottomLeft: 左下圆角
    ///   - bottomRight: 右下圆角
    ///   - isDash: true虚线 false实线
    func drawLineWithRadius(fillColor: UIColor,
                            strokeColor: UIColor,
                            lineWith: CGFloat = 1,
                            lineLength: Int = 10,
                            lineSpacing: Int = 5,
                            rectSide: UIRectSides,
                            topLeft: CGFloat = 0.0,
                            topRight: CGFloat = 0.0,
                            bottomLeft: CGFloat = 0.0,
                            bottomRight: CGFloat = 0.0,
                            isDash: Bool = false)
    {
        let shapeLayer = CAShapeLayer()
        shapeLayer.bounds = self.bounds
        shapeLayer.anchorPoint = CGPoint(x: 0, y: 0)
        shapeLayer.fillColor = fillColor.cgColor
        shapeLayer.strokeColor = strokeColor.cgColor
        shapeLayer.lineWidth = lineWith
        shapeLayer.lineJoin = "round"
        // 每一段虚线长度和每两段虚线之间的间隔
        if isDash {
            shapeLayer.lineDashPattern = [NSNumber(value: lineLength), NSNumber(value: lineSpacing)]
        }
        
        let minX = CGRectGetMinX(self.bounds)
        let minY = CGRectGetMinY(self.bounds)
        let maxX = CGRectGetMaxX(self.bounds)
        let maxY = CGRectGetMaxY(self.bounds)
        
        let path = CGMutablePath()
        if rectSide.contains(.left) {
            path.move(to: CGPointMake(minX, maxY - bottomLeft))
            path.addLine(to: CGPointMake(minX, topLeft))
            path.addQuadCurve(to: CGPointMake(topLeft, minY), control: CGPointMake(minX, minY))
        }
        if rectSide.contains(.top) {
            path.move(to: CGPointMake(topLeft, minY))
            path.addLine(to: CGPointMake(maxX - topRight, minY))
            path.addQuadCurve(to: CGPointMake(maxX, topRight), control: CGPointMake(maxX, minY))
        }
        if rectSide.contains(.right) {
            path.move(to: CGPointMake(maxX, topRight))
            path.addLine(to: CGPointMake(maxX, maxY - bottomRight))
            path.addQuadCurve(to: CGPointMake(maxX - bottomRight, maxY), control: CGPointMake(maxX, maxY))
        }
        if rectSide.contains(.bottom) {
            path.move(to: CGPointMake(maxX - bottomRight, maxY))
            path.addLine(to: CGPointMake(bottomLeft, maxY))
            path.addQuadCurve(to: CGPointMake(minX, maxY - bottomLeft), control: CGPointMake(minX, maxY))
        }
        
        shapeLayer.path = path
        self.layer.addSublayer(shapeLayer)
    }
    
//    var size: CGSize {
//        get {
//            return self.frame.size
//        }
//        set {
//            self.width = newValue.width
//            self.height = newValue.height
//        }
//    }
//    
//    var width: CGFloat {
//        get {
//            return self.frame.size.width
//        }
//        set {
//            self.frame.size.width = newValue
//        }
//    }
//    
//    var height: CGFloat {
//        get {
//            return self.frame.size.height
//        }
//        set {
//            self.frame.size.height = newValue
//        }
//    }
//    
//    var x: CGFloat {
//        get {
//            return self.frame.origin.x
//        }
//        set {
//            var tempFram: CGRect = self.frame
//            tempFram.origin.x = newValue
//            self.frame = tempFram
//        }
//    }
//
//    var y: CGFloat {
//        get {
//            return self.frame.origin.y
//        }
//        set {
//            var tempFram: CGRect = self.frame
//            tempFram.origin.y = newValue
//            self.frame = tempFram
//        }
//    }
//
//    var centerX: CGFloat {
//        get {
//            return self.center.x
//        }
//        set {
//            var tempCenter: CGPoint = self.center
//            tempCenter.x = newValue
//            self.center = tempCenter
//        }
//    }
//
//    var centerY: CGFloat {
//        get {
//            return self.center.y
//        }
//        set {
//            var tempCenter: CGPoint = self.center
//            tempCenter.y = newValue
//            self.center = tempCenter
//        }
//    }
}

/// 方法
public extension UIView {
    /// 画虚线边框
    func drawDashLine(fillColor: UIColor, strokeColor: UIColor, lineWith: CGFloat = 1, lineLength: Int = 10, lineSpacing: Int = 5, corners: UIRectSides) {
        let shapeLayer = CAShapeLayer()
        shapeLayer.bounds = self.bounds
        shapeLayer.anchorPoint = CGPoint(x: 0, y: 0)
        shapeLayer.fillColor = fillColor.cgColor
        shapeLayer.strokeColor = strokeColor.cgColor
        shapeLayer.lineWidth = lineWith
        shapeLayer.lineJoin = kCALineJoinRound
        // 每一段虚线长度和每两段虚线之间的间隔
        shapeLayer.lineDashPattern = [NSNumber(value: lineLength), NSNumber(value: lineSpacing)]
        
        let path = CGMutablePath()
        if corners.contains(.left) {
            path.move(to: CGPoint(x: 0, y: self.layer.bounds.height))
            path.addLine(to: CGPoint(x: 0, y: 0))
        }
        if corners.contains(.top) {
            path.move(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: self.layer.bounds.width, y: 0))
        }
        if corners.contains(.right) {
            path.move(to: CGPoint(x: self.layer.bounds.width, y: 0))
            path.addLine(to: CGPoint(x: self.layer.bounds.width, y: self.layer.bounds.height))
        }
        if corners.contains(.bottom) {
            path.move(to: CGPoint(x: self.layer.bounds.width, y: self.layer.bounds.height))
            path.addLine(to: CGPoint(x: 0, y: self.layer.bounds.height))
        }
        
        shapeLayer.path = path
        self.layer.addSublayer(shapeLayer)
    }
    
    /// 画实线边框
    func drawLine(fillColor: UIColor, strokeColor: UIColor, lineWidth: CGFloat = 1, corners: UIRectSides) {
        if corners == UIRectSides.all {
            self.layer.borderWidth = lineWidth
            self.layer.borderColor = strokeColor.cgColor
        } else {
            let shapeLayer = CAShapeLayer()
            shapeLayer.bounds = self.bounds
            shapeLayer.anchorPoint = CGPoint(x: 0, y: 0)
            shapeLayer.fillColor = fillColor.cgColor
            shapeLayer.strokeColor = strokeColor.cgColor
            shapeLayer.lineWidth = lineWidth
            shapeLayer.lineJoin = kCALineJoinRound
            
            let path = CGMutablePath()
            if corners.contains(.left) {
                path.move(to: CGPoint(x: 0, y: self.layer.bounds.height))
                path.addLine(to: CGPoint(x: 0, y: 0))
            }
            if corners.contains(.top) {
                path.move(to: CGPoint(x: 0, y: 0))
                path.addLine(to: CGPoint(x: self.layer.bounds.width, y: 0))
            }
            if corners.contains(.right) {
                path.move(to: CGPoint(x: self.layer.bounds.width, y: 0))
                path.addLine(to: CGPoint(x: self.layer.bounds.width, y: self.layer.bounds.height))
            }
            if corners.contains(.bottom) {
                path.move(to: CGPoint(x: self.layer.bounds.width, y: self.layer.bounds.height))
                path.addLine(to: CGPoint(x: 0, y: self.layer.bounds.height))
            }
            
            shapeLayer.path = path
            self.layer.addSublayer(shapeLayer)
        }
    }
    
    /// 清空所有的CAShapeLayer
    func clearAllShapLayers() {
        if let subLayers = self.layer.sublayers {
            let removeLayers = subLayers.filter {
                $0.isKind(of: CAShapeLayer.classForCoder())
            }
            removeLayers.forEach { item in
                item.removeFromSuperlayer()
            }
        }
    }
    
    /// 裁剪 view 的圆角
    func clipRectCorner(direction: UIRectCorner, cornerRadius: CGFloat) {
        let cornerSize = CGSize(width: cornerRadius, height: cornerRadius)
        let maskPath = UIBezierPath(roundedRect: bounds, byRoundingCorners: direction, cornerRadii: cornerSize)
        let maskLayer = CAShapeLayer()
        maskLayer.frame = bounds
        maskLayer.path = maskPath.cgPath
        layer.addSublayer(maskLayer)
        layer.mask = maskLayer
    }
    
    /// 裁剪 view 的圆角
    func addCorner(conrners: UIRectCorner, radius: CGFloat) {
        let maskPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: conrners, cornerRadii: CGSize(width: radius, height: radius))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.path = maskPath.cgPath
        self.layer.mask = maskLayer
    }
    
    /// 添加顶部Border
    func addTopBorder(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: width)
        self.layer.addSublayer(border)
    }
    
    func addLeftBorder(color: UIColor, width: CGFloat, height: CGFloat = 0) {
        let leftBorder = CALayer()
        leftBorder.backgroundColor = color.cgColor
        leftBorder.frame = CGRect(x: 0, y: 0, width: width, height: self.frame.height == 0 ? height : self.frame.height)
           
        self.layer.addSublayer(leftBorder)
    }
    
    func addRightBorder(color: UIColor, width: CGFloat) {
        let rightBorder = CALayer()
        rightBorder.backgroundColor = color.cgColor
        var x: CGFloat = 0.0
        x = CGFloat(self.frame.width - width)
        rightBorder.frame = CGRect(x: x, y: 0, width: width, height: self.frame.height)
           
        self.layer.addSublayer(rightBorder)
    }
    
    func addBottomBorder(color: UIColor, height: CGFloat, viewHeight: CGFloat = 0) {
        let bottomBorder = CALayer()
        bottomBorder.backgroundColor = color.cgColor
        bottomBorder.frame = CGRect(x: 0, y: viewHeight > 0 ? viewHeight : self.frame.height - height, width: self.frame.width, height: height)
        self.layer.addSublayer(bottomBorder)
    }
    
    func addTopLeftBorderWithCorner(startPoint: CGPoint, radius: CGFloat, strokeColor: UIColor) {
        let path = UIBezierPath()

        // 移动到起点
        path.move(to: startPoint)

        // 绘制线段
        path.addLine(to: CGPoint(x: 0.0, y: radius))

        // 移动画笔到圆弧起点，否则会有一条多余的斜线
        path.move(to: CGPoint(x: 0.0, y: radius))
        
        // 绘制终点圆角
        path.addArc(withCenter: CGPoint(x: radius, y: radius), radius: radius, startAngle: -CGFloat(Double.pi), endAngle: -CGFloat(Double.pi * 0.5), clockwise: true)
        
        // 移动画笔到圆弧终点，否则会有一条多余的斜线
        path.move(to: CGPoint(x: radius, y: 0.0))

        // 关闭路径
        path.close()

        // 将路径添加到CAShapeLayer上并显示
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.strokeColor = strokeColor.cgColor
        shapeLayer.fillColor = UIColor.clear.cgColor
        self.layer.addSublayer(shapeLayer)
    }
    
    func addTopRightBorderWithCorner(startPoint: CGPoint, radius: CGFloat, strokeColor: UIColor) {
        let path = UIBezierPath()

        // 移动到起点
        path.move(to: startPoint)

        // 绘制线段
        path.addLine(to: CGPoint(x: startPoint.x, y: radius))

        // 移动画笔到圆弧起点，否则会有一条多余的斜线
        // path.move(to: CGPoint(x: startPoint.x, y: radius))
        
        // 绘制终点圆角
        path.addArc(withCenter: CGPoint(x: self.bounds.width - radius, y: radius), radius: radius, startAngle: 0, endAngle: -CGFloat(Double.pi * 0.5), clockwise: false)
        
        // 移动画笔到圆弧终点，否则会有一条多余的斜线
        path.move(to: CGPoint(x: self.bounds.width - radius, y: 0.0))

        // 关闭路径
        path.close()

        // 将路径添加到CAShapeLayer上并显示
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.strokeColor = strokeColor.cgColor
        shapeLayer.fillColor = UIColor.clear.cgColor
        self.layer.addSublayer(shapeLayer)
    }
    
    func addBottomLeftBorderWithCorner(startPoint: CGPoint, radius: CGFloat, strokeColor: UIColor) {
        /*
         let path = UIBezierPath()

         // 移动到起点
         path.move(to: startPoint)

         // 绘制线段
         path.addLine(to: CGPoint(x: 0.0, y: radius))

         // 移动画笔到圆弧起点，否则会有一条多余的斜线
         path.move(to: CGPoint(x: 0.0, y: radius))
        
         // 绘制终点圆角
         path.addArc(withCenter: CGPoint(x: radius, y: radius), radius: radius, startAngle: -CGFloat(Double.pi * 1.5), endAngle: 0, clockwise: true)
        
         // 移动画笔到圆弧终点，否则会有一条多余的斜线
         path.move(to: CGPoint(x: radius, y: 0.0))

         // 关闭路径
         path.close()

         // 将路径添加到CAShapeLayer上并显示
         let shapeLayer = CAShapeLayer()
         shapeLayer.path = path.cgPath
         shapeLayer.strokeColor = strokeColor.cgColor
         shapeLayer.fillColor = UIColor.clear.cgColor
         self.layer.addSublayer(shapeLayer)
          */
    }
    
    func addBottomRightBorderWithCorner(startPoint: CGPoint, radius: CGFloat, strokeColor: UIColor) {
        /* let path = UIBezierPath()

         // 移动到起点
         path.move(to: startPoint)

         // 绘制线段
         path.addLine(to: CGPoint(x:startPoint.x, y: radius))

         // 移动画笔到圆弧起点，否则会有一条多余的斜线
         //path.move(to: CGPoint(x: startPoint.x, y: radius))
        
         // 绘制终点圆角
         path.addArc(withCenter: CGPoint(x: self.bounds.width - radius, y: radius), radius: radius, startAngle: 0, endAngle: -CGFloat(Double.pi * 0.5), clockwise: false)
        
         // 移动画笔到圆弧终点，否则会有一条多余的斜线
         path.move(to: CGPoint(x: self.bounds.width - radius, y: 0.0))

         // 关闭路径
         path.close()

         // 将路径添加到CAShapeLayer上并显示
         let shapeLayer = CAShapeLayer()
         shapeLayer.path = path.cgPath
         shapeLayer.strokeColor = strokeColor.cgColor
         shapeLayer.fillColor = UIColor.clear.cgColor
         self.layer.addSublayer(shapeLayer)
         */
    }
}

/// 边框结构体
public struct UIRectSides: OptionSet {
    public let rawValue: Int
    
    public static let left = UIRectSides(rawValue: 1 << 0)
    
    public static let top = UIRectSides(rawValue: 1 << 1)
    
    public static let right = UIRectSides(rawValue: 1 << 2)
    
    public static let bottom = UIRectSides(rawValue: 1 << 3)
    
    public static let all: UIRectSides = [.top, .right, .left, .bottom]
    
    public init(rawValue: Int) {
        self.rawValue = rawValue
    }
}
