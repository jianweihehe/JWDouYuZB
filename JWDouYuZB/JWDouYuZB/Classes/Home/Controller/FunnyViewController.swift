//
//  FunnyViewController.swift
//  JWDouYuZB
//
//  Created by dev@huaxi100.com on 2017/1/16.
//  Copyright © 2017年 简伟. All rights reserved.
//

import UIKit

private let TopMargin: CGFloat = 8
class FunnyViewController: BaseAnchorViewController {

    fileprivate lazy var funnyVM: FunnyViewModel = FunnyViewModel()
}

// MARK: - 页面UI
extension FunnyViewController{

    override func setupUI() {
        super.setupUI()
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.headerReferenceSize = CGSize.zero
        collectionView.contentInset = UIEdgeInsets(top: TopMargin, left: 0, bottom: 0, right: 0)
    }
}

// MARK: - 获取数据源
extension FunnyViewController{

    override func loadDataSource() {
        
        baseVM = funnyVM
        funnyVM.loadFunnyDataSource {
            self.loadDataFinished()
            self.collectionView.reloadData()
        }
    }
}
