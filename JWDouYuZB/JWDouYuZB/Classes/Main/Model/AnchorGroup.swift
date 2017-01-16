//
//  AnchorGroup.swift
//  JWDouYuZB
//
//  Created by dev@huaxi100.com on 2017/1/9.
//  Copyright © 2017年 简伟. All rights reserved.
//

import UIKit

class AnchorGroup: BaseGameModel {
    
    /// 该组中对应的房间信息
    var room_list : [[String : NSObject]]? {
        didSet {
            guard let room_list = room_list else { return }
            for dict in room_list {
                anchors.append(AnchorModel(dict: dict))
            }
        }
    }

    var icon_name : String = "home_header_normal"
    lazy var anchors : [AnchorModel] = [AnchorModel]()
    

}
