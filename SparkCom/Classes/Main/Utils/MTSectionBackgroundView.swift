//
//  MTSectionBackgroundView.swift
//  SparkBase
//
//  Created by Apple on 2021/8/26.
//  Copyright © 2021 Spark. All rights reserved.
//

import UIKit

public class MTSectionBackgroundView: UICollectionReusableView {
        
    public override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
        if layoutAttributes.isKind(of: MTSectionBackgroundAttributes.self) {
            let attr = layoutAttributes as? MTSectionBackgroundAttributes
            
            if attr!.isShow != nil {
                var colors:[CGColor] = []
                
                if attr!.isShow {
                    let view = UIView.init(frame: CGRect.init(x: 0, y: 0, width: self.bounds.size.width, height: 50))
                    view.tag = 111
                    self.addSubview(view)
                    colors = [UIColor.hex_F9FAFC.cgColor, UIColor.hex_F5F6F9.cgColor]
                    let gradient:CAGradientLayer = CAGradientLayer.init()
                    gradient.colors = colors
                    gradient.locations = [0.0, 1.0]
                    gradient.startPoint = CGPoint.init(x: 0.5, y: 0)
                    gradient.endPoint = CGPoint.init(x: 0.5, y: 1)
                    gradient.frame = view.bounds
                    view.layer.insertSublayer(gradient, at: 0)
                } else {
                    for view in self.subviews {
                        if view.tag == 111 {
                            view.removeFromSuperview()
                            break
                        }
                    }
                }
                
                
            }
            
            
            if attr!.backgroundColor != nil {
                self.backgroundColor = attr!.backgroundColor
            }
            
            
            if attr!.corners != nil {
                var radius:CGFloat = 12
                if attr!.cornerRadii != nil {
                    radius = attr!.cornerRadii!
                }
                
                self.clipRectCorner(direction: attr!.corners!, cornerRadius: radius)
            }
        }
    }
}
