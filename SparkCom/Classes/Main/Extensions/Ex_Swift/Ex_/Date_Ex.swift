//
//  Date_Ex.swift
//  appcommon_Example
//
//  Created by sfh on 2023/12/26.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import Foundation

public extension Date {
    /// 获取当前年
    var nowYear: Int {
        let curCalendar: Calendar = Calendar.current
        let year: Int = curCalendar.component(.year, from: self)
        return year
    }
    
    /// 获取当前月
    var nowMonth: Int {
        let curCalendar: Calendar = Calendar.current
        let month: Int = curCalendar.component(.month, from: self)
        return month
    }
    
    /// 获取当前日
    var nowDay: Int {
        let curCalendar: Calendar = Calendar.current
        let day: Int = curCalendar.component(.day, from: self)
        return day
    }
    
    /// 时间转换成年月
    var yearMonth: String {
        dateFormatter.locale = Locale.current
        dateFormatter.dateFormat = "yyyy-MM"
        return dateFormatter.string(from: self)
    }
}
