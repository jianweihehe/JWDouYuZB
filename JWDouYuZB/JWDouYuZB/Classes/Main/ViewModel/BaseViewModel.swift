//
//  BaseViewModel.swift
//  JWDouYuZB
//
//  Created by dev@huaxi100.com on 2017/1/13.
//  Copyright © 2017年 简伟. All rights reserved.
//

import UIKit

class BaseViewModel{

    lazy var anchorGropus:[AnchorGroup] = [AnchorGroup]()
}

extension BaseViewModel{

    func anchorData(URLString:String, pramars:[String:Any]? = nil, finishedCallBack: @escaping ()->()) {
        NetWorkingTools.requestData(type: .get, URLString: URLString,parameters: pramars) { (respose) in
            // 1.获取到数据
            guard let resultDict = respose as? [String : Any] else { return }
            guard let dataArray = resultDict["data"] as? [[String : Any]] else { return }
            
            for dict in dataArray{
                
                self.anchorGropus.append(AnchorGroup(dict: dict))
            }
            
            finishedCallBack()
        }
    }
}
