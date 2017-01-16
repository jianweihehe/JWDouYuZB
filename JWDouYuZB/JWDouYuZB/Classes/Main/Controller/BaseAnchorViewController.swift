//
//  BaseAnchorViewController.swift
//  JWDouYuZB
//
//  Created by dev@huaxi100.com on 2017/1/13.
//  Copyright © 2017年 简伟. All rights reserved.
//

import UIKit

fileprivate let itemMargin:CGFloat = 10
fileprivate let itemWidth = (JWScreenWidth - 3 * itemMargin) * 0.5
fileprivate let normalItemHeight = itemWidth * 3 / 4
fileprivate let prettyItemHeight = itemWidth * 4 / 3
fileprivate let headerViewHeight:CGFloat = 50

fileprivate let normalCellID = "normalCellID"
fileprivate let prettyCellID = "prettyCellID"
fileprivate let headerViewID = "headerViewID"

class BaseAnchorViewController: UIViewController {

    //定义属性
    var baseVM: BaseViewModel!
    
    lazy var collectionView: UICollectionView = {[weak self] in
        
        //创建布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: itemWidth, height: normalItemHeight)
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = itemMargin
        layout.headerReferenceSize = CGSize(width: (self?.view.bounds.size.width)!, height: headerViewHeight)
        layout.sectionInset = UIEdgeInsets(top: 0, left: itemMargin, bottom: 0, right: itemMargin)
        //创建UICollectionView
        let collectionView = UICollectionView(frame: (self?.view.bounds)!, collectionViewLayout: layout)
        collectionView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
        collectionView.backgroundColor = UIColor.white
        collectionView.dataSource = self as UICollectionViewDataSource?
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "CollectionNormalCell", bundle: nil), forCellWithReuseIdentifier: normalCellID)
        collectionView.register(UINib(nibName: "CollectionPrettyCell", bundle: nil), forCellWithReuseIdentifier: prettyCellID)
        collectionView.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerViewID)
        return collectionView
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        
        loadDataSource()
    }

}

// MARK: - 设置UI
extension BaseAnchorViewController{
    
    func setupUI() {
        
        view.addSubview(collectionView)
    }
}

// MARK: - 数据请求
extension BaseAnchorViewController{
    
    func loadDataSource() {
        
        
    }
}

// MARK: - UICollectionViewDataSource
extension BaseAnchorViewController: UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return baseVM.anchorGropus.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return baseVM.anchorGropus[section].anchors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: normalCellID, for: indexPath) as! CollectionNormalCell
        let group = baseVM.anchorGropus[indexPath.section]
        cell.anchor = group.anchors[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerViewID, for: indexPath) as! CollectionHeaderView
        //取出模型
        headerView.group = baseVM.anchorGropus[indexPath.section]
        return headerView
    }
}

// MARK: - UICollectionViewDelegate
extension BaseAnchorViewController:UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        
//        if indexPath.section == 1 {
//            
//            return CGSize(width: itemWidth, height: prettyItemHeight)
//        }
        
        return CGSize(width: itemWidth, height: normalItemHeight)
    }
}

