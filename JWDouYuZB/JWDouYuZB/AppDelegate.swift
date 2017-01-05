//
//  AppDelegate.swift
//  JWDouYuZB
//
//  Created by dev@huaxi100.com on 2017/1/5.
//  Copyright © 2017年 简伟. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
     
        UITabBar.appearance().tintColor = UIColor.orange
        
        return true
    }

}

