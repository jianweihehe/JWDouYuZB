//
//  BaseGameModel.swift
//  JWDouYuZB
//
//  Created by dev@huaxi100.com on 2017/1/11.
//  Copyright © 2017年 简伟. All rights reserved.
//

import UIKit

class BaseGameModel: NSObject {

    var tag_name: String = ""
    var icon_url:String = ""
    override init() {
        
    }
    
    init(dict: [String: Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}
