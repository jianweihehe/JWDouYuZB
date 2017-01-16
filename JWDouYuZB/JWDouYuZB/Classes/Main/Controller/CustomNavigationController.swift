//
//  CustomNavigationController.swift
//  JWDouYuZB
//
//  Created by dev@huaxi100.com on 2017/1/16.
//  Copyright © 2017年 简伟. All rights reserved.
//

import UIKit

class CustomNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        //获取系统pop手势
        guard let systemGes = interactivePopGestureRecognizer else { return }
        //获取手势添加到的view中
        guard let gesView = systemGes.view else { return }
        //获取target/action
        /** 利用运行时机制查看所有的属性名称
         var count:UInt32 = 0
         let ivars = class_copyIvarList(UIGestureRecognizer.self, &count)
         for i in 0..<count {
         let ivar = ivars?[Int(i)]
         let name = ivar_getName(ivar)
         print(String(cString: name!))
         }
         */
        let targets = systemGes.value(forKey: "_targets") as? [NSObject]
        guard let targetsObjc = targets?.first else { return }
        guard let target = targetsObjc.value(forKey: "target") else { return }
        let action = Selector(("handleNavigationTransition:"))
        let panGes = UIPanGestureRecognizer(target: target, action: action)
        gesView.addGestureRecognizer(panGes)
        
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        viewController.hidesBottomBarWhenPushed = true
        super.pushViewController(viewController, animated: animated)
    }

}
