//
//  AmuseViewModel.swift
//  JWDouYuZB
//
//  Created by dev@huaxi100.com on 2017/1/12.
//  Copyright © 2017年 简伟. All rights reserved.
//

import UIKit

class AmuseViewModel: BaseViewModel{

}

extension AmuseViewModel{

    
    func loadAmuseData(finishedCallback:@escaping ()->()) {
    
        anchorData(URLString: "http://capi.douyucdn.cn/api/v1/getHotRoom/2", finishedCallBack: finishedCallback)
    }
}
