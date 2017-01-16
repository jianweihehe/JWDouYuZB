//
//  FunnyViewModel.swift
//  JWDouYuZB
//
//  Created by dev@huaxi100.com on 2017/1/16.
//  Copyright © 2017年 简伟. All rights reserved.
//

import UIKit

class FunnyViewModel: BaseViewModel{

}

extension FunnyViewModel {

    func loadFunnyDataSource(finishedCallback: @escaping () -> ()){
        
        anchorData(isGroupData: false,URLString: "http://capi.douyucdn.cn/api/v1/getColumnRoom/3", pramars: ["limit" : 30, "offset" : 0], finishedCallBack: finishedCallback)
    }
}
