//
//  AmuseViewController.swift
//  JWDouYuZB
//
//  Created by dev@huaxi100.com on 2017/1/12.
//  Copyright © 2017年 简伟. All rights reserved.
//

import UIKit

private let amuseMenuViewHeight:CGFloat = 200

class AmuseViewController: BaseAnchorViewController {
    

    //属性设置
    fileprivate lazy var amuseVM : AmuseViewModel = AmuseViewModel()

    fileprivate lazy var amuseMenuView: AmuseMenuView = {
    
        let amuseMenuView = AmuseMenuView.amuseMenuView()
        amuseMenuView.frame = CGRect(x: 0, y: -amuseMenuViewHeight, width: JWScreenWidth, height: amuseMenuViewHeight)
        return amuseMenuView
    }()
}

// MARK: - 设置UI界面
extension AmuseViewController{

    override func setupUI() {
        super.setupUI()
        collectionView.addSubview(amuseMenuView)
        collectionView.contentInset = UIEdgeInsets(top: amuseMenuViewHeight, left: 0, bottom: 0, right: 0)
    }
}

// MARK: - 数据请求
extension AmuseViewController{

    override func loadDataSource() {
        //给父类中数据赋值
        baseVM = amuseVM
        //请求数据
        amuseVM.loadAmuseData {
            
            self.collectionView.reloadData()
            
            var tempGroups = self.amuseVM.anchorGropus
            tempGroups.removeFirst()
            self.amuseMenuView.groups = tempGroups
        }
        
    }
}







