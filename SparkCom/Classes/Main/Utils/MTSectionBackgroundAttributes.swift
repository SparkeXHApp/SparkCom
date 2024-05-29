//
//  MTSectionBackgroundAttributes.swift
//  SparkBase
//
//  Created by Apple on 2021/8/26.
//  Copyright © 2021 Spark. All rights reserved.
//

import UIKit

public class MTSectionBackgroundAttributes: UICollectionViewLayoutAttributes {

    //是否显示渐变背景
    var isShow:Bool!
    
    //section背景色
    var backgroundColor:UIColor!
    
    //section圆角
    var corners:UIRectCorner?
    
    //section圆角大小
    var cornerRadii:CGFloat?

}
