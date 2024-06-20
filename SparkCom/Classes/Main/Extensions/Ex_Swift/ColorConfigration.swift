//
//  ColorConfigration.swift
//  SparkBase
//
//  Created by Apple on 2021/8/19.
//  Copyright © 2021 Spark. All rights reserved.
//

import UIKit

//MARK: 颜色相关
public enum CommonColorType: String {
    /**
     #222222
     */
    case TEXT_MAIN
    /**
     #AFB3BF
     */
    case TEXT_ASSIST
    /**
     #C4CBDE
     */
    case TEXT_UNOPEN
    /**
     #FFC800
     */
    case TEXT_YELLOW
    /**
     #000000
     */
    case COVER_MAIN
    /**
     #FFFFFF
     */
    case BACKGROUND_WHITE
    /**
     #F5F6F9
     */
    case BACKGROUND_MAIN
    /**
     #F9FAFC
     */
    case BACKGROUND_BODER
    /**
     #F5F5F9
     */
    case BACKGROUND_BODER_DEEP
    /**
     #FFEA00
     */
    case BACKGROUND_BLOCK
    /**
     #FFF2EB
     */
    case BACKGROUND_BLOCK_DEEP
    /**
     #EDEFF0
     */
    case SEPARATE_LINE
    /**
     #008AFF
     */
    case THEME_MAIN
    /**
     #E7F4FF
     */
    case THEME_MAIN_BACKGROUND
    /**
     #32D2FF
     */
    case THEME_ASSIST
    /**
     #62CA00
     */
    case RES_RIGHT
    /**
     #DFFADC
     */
    case RES_RIGHT_BACKGROUND
    /**
     #FF2E00
     */
    case RES_WRONG
    /**
     #FFE6E0
     */
    case RES_WRONG_BACKGROUND
    /**
     #FF3B00
     */
    case PRICE_MAIN
    /**
     #FF5200
     */
    case PRICE_PIECE_TOGETHER
    /**
     #FFAF00
     */
    case NOTICE_MAIN
    /**
     #FFFAC8
     */
    case NOTICE_BACKGROUND
    /**
     #FF7800
     */
    case ERROR_MAIN
    /**
     #FFF6E3
     */
    case ERROR_BACKGROUND
    /**
     #15D25F
     */
    case FINISH_MAIN
    /**
     #E6FFF0
     */
    case FINISH_BACKGROUND
    
}

public func ConfigColor(withType: CommonColorType) -> UIColor {
    ConfigColor(withType: withType, alpha: 1)
}

public func ConfigColor(withType: CommonColorType, alpha: CGFloat) -> UIColor {
    var colorStr: String!
    
    switch withType {
    case .TEXT_MAIN:
        colorStr = "#222222"
        break;
    case .TEXT_ASSIST:
        colorStr = "#AFB3BF"
        break;
    case .TEXT_UNOPEN:
        colorStr = "#C4CBDE"
        break;
    case .TEXT_YELLOW:
        colorStr = "#FFC800"
        break;
    case .COVER_MAIN:
        colorStr = "#000000"
        break;
    case .BACKGROUND_WHITE:
        colorStr = "#FFFFFF"
        break;
    case .BACKGROUND_MAIN:
        colorStr = "#F5F6F9"
        break;
    case .BACKGROUND_BODER:
        colorStr = "#F9FAFC"
        break;
    case .BACKGROUND_BODER_DEEP:
        colorStr = "#F5F5F9"
        break;
    case .BACKGROUND_BLOCK:
        colorStr = "#FFEA00"
        break;
    case .BACKGROUND_BLOCK_DEEP:
        colorStr = "#FFF2EB"
        break;
    case .SEPARATE_LINE:
        colorStr = "#EDEFF0"
        break;
    case .THEME_MAIN:
        colorStr = "#008AFF"
        break;
    case .THEME_MAIN_BACKGROUND:
        colorStr = "#E7F4FF"
        break;
    case .THEME_ASSIST:
        colorStr = "#32D2FF"
        break;
    case .RES_RIGHT:
        colorStr = "#62CA00"
        break;
    case .RES_RIGHT_BACKGROUND:
        colorStr = "#DFFADC"
        break;
    case .RES_WRONG:
        colorStr = "#FF2E00"
        break;
    case .RES_WRONG_BACKGROUND:
        colorStr = "#FFE6E0"
        break;
    case .PRICE_MAIN:
        colorStr = "#FF3B00"
        break;
    case .PRICE_PIECE_TOGETHER:
        colorStr = "#FF5200"
        break;
    case .NOTICE_MAIN:
        colorStr = "#FFAF00"
        break;
    case .NOTICE_BACKGROUND:
        colorStr = "#FFFAC8"
        break;
    case .ERROR_MAIN:
        colorStr = "#FF7800"
        break;
    case .ERROR_BACKGROUND:
        colorStr = "#FFF6E3"
        break;
    case .FINISH_MAIN:
        colorStr = "#15D25F"
        break;
    case .FINISH_BACKGROUND:
        colorStr = "#E6FFF0"
        break;
    }
    
    return LFStringColor(hex: colorStr, alpha: alpha)
}


public extension UIColor {
    
    static func wx_random() -> UIColor {
        return UIColor(
           red:   .wx_random(),
           green: .wx_random(),
           blue:  .wx_random(),
           alpha: 1.0
        )
    }
}

public extension CGFloat {
    static func wx_random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}
