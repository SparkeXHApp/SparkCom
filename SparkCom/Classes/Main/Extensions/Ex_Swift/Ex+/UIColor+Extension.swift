//
//  UIColor+Extension.swift
//  SparkBase
//
//  Created by sfh on 2022/8/26.
//  Copyright © 2022 Spark. All rights reserved.
//

import Foundation


private func LFHexColor(hex: String, alpha:CGFloat) -> UIColor {
    // 去除空格等
    var cString: String = hex.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines).uppercased()
    // 去除#
    if (cString.hasPrefix("#")) {
        cString = (cString as NSString).substring(from: 1)
    }
    // 必须为6位
    if (cString.count != 6) {
        return UIColor.gray
    }
    // 红色的色值
    let rString = (cString as NSString).substring(to: 2)
    let gString = ((cString as NSString).substring(from: 2) as NSString).substring(to: 2)
    let bString = ((cString as NSString).substring(from: 4) as NSString).substring(to: 2)
    // 字符串转换
    var r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0
    Scanner(string: rString).scanHexInt32(&r)
    Scanner(string: gString).scanHexInt32(&g)
    Scanner(string: bString).scanHexInt32(&b)
    return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: alpha)
}
  
public extension UIColor {
    
    /** 222222 */
    class var hex_222222 : UIColor {
        return LFHexColor(hex: "222222", alpha: 1.0)
    }
    
    /** AFB3BF */
    class var hex_AFB3BF : UIColor {
        return LFHexColor(hex: "AFB3BF", alpha: 1.0)
    }
    
    /** C4CBDE */
    class var hex_C4CBDE : UIColor {
        return LFHexColor(hex: "C4CBDE", alpha: 1.0)
    }
    
    /** FFC800 */
    class var hex_FFC800 : UIColor {
        return LFHexColor(hex: "FFC800", alpha: 1.0)
    }
    
    /** F5F6F9 */
    class var hex_F5F6F9 : UIColor {
        return LFHexColor(hex: "F5F6F9", alpha: 1.0)
    }
    
    /** F9FAFC */
    class var hex_F9FAFC : UIColor {
        return LFHexColor(hex: "F9FAFC", alpha: 1.0)
    }
    
    /** F5F5F9 */
    class var hex_F5F5F9 : UIColor {
        return LFHexColor(hex: "F5F5F9", alpha: 1.0)
    }
    
    /** FFEA00 */
    class var hex_FFEA00 : UIColor {
        return LFHexColor(hex: "FFEA00", alpha: 1.0)
    }
    
    /** FFF2EB */
    class var hex_FFF2EB : UIColor {
        return LFHexColor(hex: "FFF2EB", alpha: 1.0)
    }
    
    /** 008AFF*/
    class var hex_008AFF : UIColor {
        return LFHexColor(hex: "008AFF", alpha: 1.0)
    }
    
    /** E7F4FF */
    class var hex_E7F4FF : UIColor {
        return LFHexColor(hex: "E7F4FF", alpha: 1.0)
    }
    
    /** 32D2FF */
    class var hex_32D2FF : UIColor {
        return LFHexColor(hex: "32D2FF", alpha: 1.0)
    }
    
    /** 62CA00 */
    class var hex_62CA00 : UIColor {
        return LFHexColor(hex: "62CA00", alpha: 1.0)
    }
    
    /** DFFADC */
    class var hex_DFFADC : UIColor {
        return LFHexColor(hex: "DFFADC", alpha: 1.0)
    }
    
    /** FF2E00 */
    class var hex_FF2E00 : UIColor {
        return LFHexColor(hex: "FF2E00", alpha: 1.0)
    }
    
    /** FFE6E0 */
    class var hex_FFE6E0 : UIColor {
        return LFHexColor(hex: "FFE6E0", alpha: 1.0)
    }
    
    /** FF3B00 */
    class var hex_FF3B00 : UIColor {
        return LFHexColor(hex: "FF3B00", alpha: 1.0)
    }
    
    /** FF5200 */
    class var hex_FF5200 : UIColor {
        return LFHexColor(hex: "FF5200", alpha: 1.0)
    }
    
    /** FFAF00 */
    class var hex_FFAF00 : UIColor {
        return LFHexColor(hex: "FFAF00", alpha: 1.0)
    }
    
    /** FFFAC8 */
    class var hex_FFFAC8 : UIColor {
        return LFHexColor(hex: "FFFAC8", alpha: 1.0)
    }
    
    /** FF7800 */
    class var hex_FF7800 : UIColor {
        return LFHexColor(hex: "FF7800", alpha: 1.0)
    }
    
    /** FFF6E3 */
    class var hex_FFF6E3 : UIColor {
        return LFHexColor(hex: "FFF6E3", alpha: 1.0)
    }
    
    /** 15D25F */
    class var hex_15D25F : UIColor {
        return LFHexColor(hex: "15D25F", alpha: 1.0)
    }
    
    /** E6FFF0 */
    class var hex_E6FFF0 : UIColor {
        return LFHexColor(hex: "E6FFF0", alpha: 1.0)
    }
    
    /** 000000 */
    class var hex_000000 : UIColor {
        return LFHexColor(hex: "000000", alpha: 1.0)
    }
    
    /** FFFFFF */
    class var hex_FFFFFF : UIColor {
        return LFHexColor(hex: "FFFFFF", alpha: 1.0)
    }
    
    /** EDEFF0 */
    class var hex_EDEFF0 : UIColor {
        return LFHexColor(hex: "EDEFF0", alpha: 1.0)
    }
    
    /** EFF8FF */
    class var hex_EFF8FF : UIColor {
        return LFHexColor(hex: "#EFF8FF", alpha: 1.0)
    }
    
    /** FF9400 */
    class var hex_FF9400 : UIColor {
        return LFHexColor(hex: "#FF9400", alpha: 1.0)
    }
    
    /** D8D8D8 */
    class var hex_D8D8D8 : UIColor {
        return LFHexColor(hex: "#D8D8D8", alpha: 1.0)
    }
    
    /** 9397A6 */
    class var hex_9397A6 : UIColor {
        return LFHexColor(hex: "#9397A6", alpha: 1.0)
    }
    
    //TODO: 考研一体课用到的色值，后续可能有变更导致命名与色值不一致
    
    /** 1A1C1F */
    class var hex_1A1C1F_bg1 : UIColor {
        return LFHexColor(hex: "#1A1C1F", alpha: 1.0)
    }
    
    /** 1F2124 */
    class var hex_1F2124_bg2 : UIColor {
        return LFHexColor(hex: "#1F2124", alpha: 1.0)
    }
    
    /** 26282B */
    class var hex_26282B_bg3 : UIColor {
        return LFHexColor(hex: "#26282B", alpha: 1.0)
    }
    
    /** 62656F */
    class var hex_62656F_tx1 : UIColor {
        return LFHexColor(hex: "#62656F", alpha: 1.0)
    }
    
    /** 7A7E8C */
    class var hex_7A7E8C_tx2 : UIColor {
        return LFHexColor(hex: "#7A7E8C", alpha: 1.0)
    }
    
    /** B8BCC6 */
    class var hex_B8BCC6_tx3 : UIColor {
        return LFHexColor(hex: "#B8BCC6", alpha: 1.0)
    }
    
    /** CBCFDB */
    class var hex_CBCFDB_tx4 : UIColor {
        return LFHexColor(hex: "#CBCFDB", alpha: 1.0)
    }

    /** 8D95A1 */
    class var hex_8D95A1 : UIColor {
        return LFHexColor(hex: "#8D95A1", alpha: 1.0)
    }
    /** E6E6E6 */
    class var hex_E6E6E6 : UIColor {
        return LFHexColor(hex: "#E6E6E6", alpha: 1.0)
    }
    /**FFF2E0**/
    class var hex_FFF2E0 : UIColor{
        return LFHexColor(hex: "#FFF2E0", alpha: 1.0)
    }
    /**E6F0FF**/
    class var hex_E6F0FF : UIColor{
        return LFHexColor(hex: "#E6F0FF", alpha: 1.0)
    }
    /**5467FF**/
    class var hex_5467FF : UIColor{
        return LFHexColor(hex: "#5467FF", alpha: 1.0)
    }
    /**E8EBFF**/
    class var hex_E8EBFF : UIColor{
        return LFHexColor(hex: "#E8EBFF", alpha: 1.0)
    }
    /**CACACA**/
    class var hex_CACACA : UIColor{
        return LFHexColor(hex: "#CACACA", alpha: 1.0)
    }
    
    /**37C200**/
    class var hex_37C200 : UIColor{
        return LFHexColor(hex: "#37C200", alpha: 1.0)
    }
    
    /**00CA0D**/
    class var hex_00CA0D : UIColor{
        return LFHexColor(hex: "#00CA0D", alpha: 1.0)
    }
    
    /**F3F3F3**/
    class var hex_F3F3F3 : UIColor{
        return LFHexColor(hex: "#F3F3F3", alpha: 1.0)
    }
    
    /**E8E8F3**/
    class var hex_E8E8F3 : UIColor{
        return LFHexColor(hex: "#E8E8F3", alpha: 1.0)
    }

}
