//
//  CommendViewModel.swift
//  JWDouYuZB
//
//  Created by dev@huaxi100.com on 2017/1/9.
//  Copyright © 2017年 简伟. All rights reserved.
//

import UIKit

class CommendViewModel: BaseViewModel{

    lazy var cycleModels : [CycleModel] = [CycleModel]()
    fileprivate lazy var prettyGroup : AnchorGroup = AnchorGroup()
    fileprivate lazy var bigDataGroup : AnchorGroup = AnchorGroup()
}

// MARK: - 发送网络请求
extension CommendViewModel{

    func requestData(_ finishCallback : @escaping () -> ()) {
        
        // 定义参数
        let parameters = ["limit" : "4", "offset" : "0", "time" : Date.getCurrentTime()]
        
        let netWorkingGroup = DispatchGroup()
        netWorkingGroup.enter()
        //请求推荐数据
        NetWorkingTools.requestData(type: .get, URLString: "http://capi.douyucdn.cn/api/v1/getbigDataRoom", parameters: parameters) { (result) in

            // 1.将result转成字典类型
            guard let resultDict = result as? [String : NSObject] else { return }
            
            // 2.根据data该key,获取数组
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else { return }
            
            self.bigDataGroup.tag_name = "热门"
            self.bigDataGroup.icon_name = "home_header_hot"
            for dict in dataArray{
                
                let anchor = AnchorModel(dict: dict)
                self.bigDataGroup.anchors.append(anchor)
            }
            netWorkingGroup.leave()
        }
        //请求颜值数据
        netWorkingGroup.enter()
        NetWorkingTools.requestData(type: .get, URLString: "http://capi.douyucdn.cn/api/v1/getVerticalRoom", parameters: parameters) { (result) in

            // 1.将result转成字典类型
            guard let resultDict = result as? [String : NSObject] else { return }
            
            // 2.根据data该key,获取数组
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else { return }
            
            self.prettyGroup.tag_name = "颜值"
            self.prettyGroup.icon_name = "home_header_phone"
            for dict in dataArray{
            
                let anchor = AnchorModel(dict: dict)
                self.prettyGroup.anchors.append(anchor)
            }
            netWorkingGroup.leave()
        }
        //请求游戏数据
        netWorkingGroup.enter()
        anchorData(isGroupData: true,URLString: "http://capi.douyucdn.cn/api/v1/getHotCate", pramars: parameters) {
            
            netWorkingGroup.leave()
        }
        netWorkingGroup.notify(queue: DispatchQueue.main) { 
            self.anchorGropus.insert(self.prettyGroup, at: 0)
            self.anchorGropus.insert(self.bigDataGroup, at: 0)
            finishCallback()
        }
    }
    
//     请求无线轮播的数据
    func requestCycleData(_ finishCallback : @escaping () -> ()) {
        
        NetWorkingTools.requestData(type: .get, URLString: "http://www.douyutv.com/api/v1/slide/6", parameters: ["version" : "2.300"]) { (result) in
            // 1.获取整体字典数据
            guard let resultDict = result as? [String : NSObject] else { return }
            
            // 2.根据data的key获取数据
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else { return }
            
            // 3.字典转模型对象
            for dict in dataArray {
                self.cycleModels.append(CycleModel(dict: dict))
            }
            
            finishCallback()
        }
    }
}
