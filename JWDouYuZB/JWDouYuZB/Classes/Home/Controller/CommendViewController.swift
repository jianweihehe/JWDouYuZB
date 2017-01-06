//
//  CommendViewController.swift
//  JWDouYuZB
//
//  Created by dev@huaxi100.com on 2017/1/6.
//  Copyright © 2017年 简伟. All rights reserved.
//

import UIKit

fileprivate let itemMargin:CGFloat = 10
fileprivate let itemWidth = (JWScreenWidth - 3 * itemMargin) * 0.5
fileprivate let itemHeight = itemWidth * 3 / 4
fileprivate let headerViewHeight:CGFloat = 50
fileprivate let normalCellID = "normalCellID"
fileprivate let headerViewID = "headerViewID"
class CommendViewController: UIViewController {

    //属性设置
    fileprivate lazy var collectionView: UICollectionView = {[weak self] in
    
        //创建布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = itemMargin
        layout.headerReferenceSize = CGSize(width: (self?.view.bounds.size.width)!, height: headerViewHeight)
        layout.sectionInset = UIEdgeInsets(top: 0, left: itemMargin, bottom: 0, right: itemMargin)
        //创建UICollectionView
        let collectionView = UICollectionView(frame: (self?.view.bounds)!, collectionViewLayout: layout)
        collectionView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
        collectionView.backgroundColor = UIColor.white
        collectionView.dataSource = self as UICollectionViewDataSource?
        collectionView.register(UINib(nibName: "CollectionNormalCell", bundle: nil), forCellWithReuseIdentifier: normalCellID)
        collectionView.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerViewID)
        return collectionView
    }()
    
    //系统回调
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
}

// MARK: - 设置UI界面
extension CommendViewController {

    fileprivate func setupUI() {
        
        view.addSubview(collectionView)
    }
}

// MARK: - UICollectionViewDataSource
extension CommendViewController: UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 12
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if section == 0 {
            return 8
        }
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: normalCellID, for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerViewID, for: indexPath)
        return headerView
    }
}















