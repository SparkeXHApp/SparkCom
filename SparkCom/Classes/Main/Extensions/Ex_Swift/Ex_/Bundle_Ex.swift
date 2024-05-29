//
//  Bundle_Ex.swift
//  SparkBase
//
//  Created by sfh on 2023/12/20.
//  Copyright © 2023 Spark. All rights reserved.
//

import Foundation

public extension Bundle {
    /// 版本号
    var app_version: String { return self.infoDictionary?["CFBundleShortVersionString"] as? String ?? "" }
    /// 构建号
    var app_build: String { return self.infoDictionary?["CFBundleVersion"] as? String ?? "" }
    /// 名字
    var app_name: String {
        return self.infoDictionary?["CFBundleDisplayName"] as? String ?? (Bundle.main.infoDictionary?["CFBundleName"] as? String ?? "")
    }
    /// 唯一标识
    var app_bundleId: String { return self.infoDictionary?["CFBundleIdentifier"] as? String ?? "" }
    /// 命名空间
    var app_namespace: String { return self.infoDictionary?["CFBundleName"] as? String ?? "" }
}
