//
//  NetWorkingTools.swift
//  JWDouYuZB
//
//  Created by dev@huaxi100.com on 2017/1/9.
//  Copyright © 2017年 简伟. All rights reserved.
//

import UIKit
import Alamofire

enum MethodType {
    case get
    case post
}

class NetWorkingTools {
    
    class func requestData(type:MethodType,URLString:String,parameters:[String: Any]? = nil,finishedCallBack:@escaping (_ request:Any)->()) {
        
        let method = type == .get ? HTTPMethod.get : HTTPMethod.post
        
        Alamofire.request(URLString, method: method, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            
            guard let result = response.result.value else{
            
                print("错误输出：\(response.result.error)")
                return
            }
            
            finishedCallBack(result)
        }
    }
}
