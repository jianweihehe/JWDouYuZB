//
//  UIBarButtonItem+Extension.swift
//  JWDouYuZB
//
//  Created by dev@huaxi100.com on 2017/1/5.
//  Copyright © 2017年 简伟. All rights reserved.
//

import UIKit


extension UIBarButtonItem{

    class func createItem(imageName:String,highlightedImageName:String = "",size:CGSize = CGSize.zero) -> UIBarButtonItem{
        let btn = UIButton()
        btn.setImage(UIImage(named:imageName), for: .normal)
        if highlightedImageName != "" {
            btn.setImage(UIImage(named:highlightedImageName), for: .highlighted)
        }
        if size == CGSize.zero {
            btn.sizeToFit()
        }else{
            btn.frame = CGRect(origin: CGPoint.zero, size: size)
        }
        
        return UIBarButtonItem(customView: btn)
    }
    
    convenience init(imageName:String,highlightedImageName:String = "",size:CGSize = CGSize.zero) {
        let btn = UIButton()
        btn.setImage(UIImage(named:imageName), for: .normal)
        if highlightedImageName != "" {
            btn.setImage(UIImage(named:highlightedImageName), for: .highlighted)
        }
        if size == CGSize.zero {
            btn.sizeToFit()
        }else{
            btn.frame = CGRect(origin: CGPoint.zero, size: size)
        }
        self.init(customView:btn)
    }
}
