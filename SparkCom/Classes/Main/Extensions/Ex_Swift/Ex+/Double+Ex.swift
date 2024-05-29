//
//  Double+Ex.swift
//  SparkBase
//
//  Created by sfh on 2023/7/26.
//  Copyright © 2023 Spark. All rights reserved.
//

import Foundation

public extension Double {
    
    public func roundTo(places: Int) -> Double {
        let divesor = pow(10.0, Double(places))
        return (self * divesor).rounded() / divesor
    }
}
