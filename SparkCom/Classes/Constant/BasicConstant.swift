//
//  BasicConstant.swift
//  SparkBasic
//
//  Created by sfh on 2024/6/20.
//

import Foundation

/// 断网提示
public let noNetworkNotice = "您的网络好像出了点问题\n请前往 设置-无线局域网/蜂窝网络 检查网络是否开启\n或者检查是否授予APP网络使用权限"

// MARK: - 常量

/** Appkey */
let SparkAppKey = "210951669544977408"

// MARK: 小程序ID

/** 星火网课小程序id */
let WxMini_NetCourseID: String = "gh_e874065f7ff7"

/** 虐耳精听小程序id */
let WxMini_HardListenID: String = "gh_d130a7da2d28"

/** 背单词小程序id */
let WxMini_RemeberWordID: String = "gh_3ae78e7839cc"

// MARK: 首页金刚区类型ID

/** 图书配套 10016003909571888000 */
let MenuType_BookSetID: String = "10016003909571888000"

/** 普通网课 10016003909571888001 */
let MenuType_NetCourseID: String = "10016003909571888001"

/** 分学段网课 10016003909571888011 */
let MenuType_GradeNetCourseID: String = "10016003909571888011"

/** 活动 10016003909571888002 */
let MenuType_ActivityID: String = "10016003909571888002"

/** 小程序 10016003909571888003 */
let MenuType_WxMiniID: String = "10016003909571888003"

/** 备考干货 10016003909571888004 */
let MenuType_PrepareStuffID: String = "10016003909571888004"

/** 智能模考 10016003909571888005 */
let MenuType_AIExamID: String = "10016003909571888005"

/** 优惠专区 10016003909571888006 */
let MenuType_CouponID: String = "10016003909571888006"

/** 智能题库 10016003909571888006 */
let MenuType_SmartBankID: String = "10016003847171888006"

/** 口袋题库 99338629033601428 */
let MenuType_MiniQueBankID: String = "99338629033601428"

/** 敬请期待 10016003909571888007 */
let MenuType_StayTunedID: String = "10016003909571888007"

/** 四六级口语模考 10016003874571888000 */
let MenuType_SpokenExamID: String = "10016003874571888000"

/** 积分商城 10016003909571888012 */
let MenuType_IntegralShopID: String = "10016003909571888012"

/** 听力列表 18666079857982055403 */
let MenuType_ListenresID: String = "18666079857982055403"

/** 切换到书城 18666079857982055404 */
let MenuType_ToBookShopID: String = "18666079857982055404"

/** 巧计单词 18666079857982055405 */
let MenuType_SkillMemoryWordID: String = "18666079857982055405"

// MARK: 第三方注册参数（友盟、微信、QQ、新浪）

/** 友盟AppKey */
let UMAppKey = "5785f13ae0f55ad296003ae4"

/** 极光AppKey */
let JVAppkey = "698be8ff956a7e8f2ea10073"

/** 微信AppKey */
let weChatAppKey = "wx35bdc73a79e2a430"

/** 微信Secret */
let weChatSecret = "79e8f9668072517e643a860c458ac169"

/** QQAppKey */
let QQAppKey = "1105474912"

/** 新浪微博AppKey */
let WBAppKey = "3240568197"

/** 新浪微博Secret */
let WBSecret = "7d0161ac53ca6082d22d85726c5f881e"

// MARK: 学段ID

/** 四级 532648787350438272 */
let CET4 = "532648787350438272"

/** 六级 532648976328999296 */
let CET6 = "532648976328999296"

/** 专四 532649491725076608 */
let TEM4 = "532649491725076608"

/** 专八 532649586214355328 */
let TEM8 = "532649586214355328"

/** 考研 532649680703635840 */
let NETM = "532649680703635840"

/** ABClass 789964478543590784 */
let ABClass = "789964478543590784"

/** 三级 789964478543590785 */
let ThirdClass = "789964478543590785"

/** 专升本 789964478543590786 */
let UpgradeFromJunior = "789964478543590786"

// MARK: 巧计单词缓存路径

/**
 * 巧计单词功能，特训模块，听写模式的设置数据的存储路径
 */
let listenSettingUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("listenSetting.json")

/**
 * 巧计单词功能，特训模块，速刷模式的设置数据的存储路径
 */
let quickSettingUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("quickSetting.json")

/**
 * 巧计单词功能，特训模块，随身听模式的设置数据的存储路径
 */
let bySelfSettingUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("bySelfSetting.json")

// MARK: - 颜色

/** RGBA */
func LFColor(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) -> UIColor {
    return UIColor(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: a)
}

/** hex */
public func LFStringColor(hex: String, alpha: CGFloat) -> UIColor {
    // 去除空格等
    var cString: String = hex.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines).uppercased()
    // 去除#
    if cString.hasPrefix("#") {
        cString = (cString as NSString).substring(from: 1)
    }
    // 必须为6位
    if cString.count != 6 {
        return UIColor.gray
    }
    // 红色的色值
    let rString = (cString as NSString).substring(to: 2)
    let gString = ((cString as NSString).substring(from: 2) as NSString).substring(to: 2)
    let bString = ((cString as NSString).substring(from: 4) as NSString).substring(to: 2)
    // 字符串转换
    var r: CUnsignedInt = 0, g: CUnsignedInt = 0, b: CUnsignedInt = 0
    Scanner(string: rString).scanHexInt32(&r)
    Scanner(string: gString).scanHexInt32(&g)
    Scanner(string: bString).scanHexInt32(&b)
    return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: alpha)
}

// MARK: - 尺寸、系统判断

/** 屏幕的宽 */
let SCREENW: CGFloat = UIDevice.getScreenWith()
/** 屏幕的高 */
let SCREENH: CGFloat = UIDevice.getScreenHeight()
/** 顶部StatusBar高度 */
let TopStatusBar: CGFloat = UIDevice.statusBarHeight()
/** 顶部StatusBar+Nav的高度判断 */
let TopHeight: CGFloat = UIDevice.navBarAndStatusBarHeight()
/** 底部安全区域高度 */
let SoftHeight: CGFloat = UIDevice.bottomSafeAreaHeight()
/** 底部tabbar+soft的高度判断 */
let BottomHeight: CGFloat = UIDevice.tabBarAndBottomSafeAreaHeight()

/** iPhone 5 */
let isIPhone5 = SCREENH == 568 ? true : false
/** iPhone 6 */
let isIPhone6 = SCREENH == 667 ? true : false
/** iPhone 6P */
let isIPhone6P = SCREENH == 736 ? true : false
/** iPhone X */
let isIPhoneX = iPhoneX() ? true : false
/** iPad */
let isIPad = iPad() ? true : false

/** 判断是不是全面屏iPhone */
func iPhoneX() -> Bool {
    if UIDevice.statusBarHeight() > 20 && UIDevice.current.userInterfaceIdiom == .phone {
        return true
    }
    return false
}

/** 判断是不是iPad */
func iPad() -> Bool {
    if UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad {
        return true
    }
    return false
}

/** 判断是不是全面屏iPad */
func iPadX() -> Bool {
    if UIDevice.bottomSafeAreaHeight() > 0 && UIDevice.current.userInterfaceIdiom == .pad {
        return true
    }
    return false
}
