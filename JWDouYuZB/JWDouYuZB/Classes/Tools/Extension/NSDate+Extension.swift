//
//  NSDate+Extension.swift
//  JWDouYuZB
//
//  Created by dev@huaxi100.com on 2017/1/9.
//  Copyright © 2017年 简伟. All rights reserved.
//

import Foundation
extension Date {
    static func getCurrentTime() -> String {
        let nowDate = Date()
        
        let interval = Int(nowDate.timeIntervalSince1970)
        
        return "\(interval)"
    }
}
