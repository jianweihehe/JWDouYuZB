//
//  GameViewModel.swift
//  JWDouYuZB
//
//  Created by dev@huaxi100.com on 2017/1/11.
//  Copyright © 2017年 简伟. All rights reserved.
//

import Foundation

class GameViewModel: NSObject {
    
    lazy var games:[GameModel] = [GameModel]()
    
}

extension GameViewModel{

    func loadAllGameSource(finishedCallBack: @escaping ()->()){
        NetWorkingTools.requestData(type: .get, URLString: "http://capi.douyucdn.cn/api/v1/getColumnDetail", parameters: ["shortName" : "game"]) { (respose) in
            // 1.获取到数据
            guard let resultDict = respose as? [String : Any] else { return }
            guard let dataArray = resultDict["data"] as? [[String : Any]] else { return }
            
            // 2.字典转模型
            for dict in dataArray {
            
               self.games.append(GameModel(dict: dict))
            }
            
            finishedCallBack()
        }
    }
}
