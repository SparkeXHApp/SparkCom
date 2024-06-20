//
//  MESlider.swift
//  SparkBase
//
//  Created by Apple on 2021/7/7.
//  Copyright © 2021 Spark. All rights reserved.
//

import UIKit

public class MESlider: UISlider {

    public override func thumbRect(forBounds bounds: CGRect, trackRect rect: CGRect, value: Float) -> CGRect {
        let newRect = CGRect(x: rect.origin.x - 10, y: rect.origin.y, width: rect.size.width + 20, height: rect.size.height)
           
        return  super.thumbRect(forBounds: bounds, trackRect: newRect, value: value).insetBy(dx: 10, dy: 10)
    }
    
    // 禁止拖动
    public override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        return false
    }

}
