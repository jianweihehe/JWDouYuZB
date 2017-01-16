//
//  GameViewController.swift
//  JWDouYuZB
//
//  Created by dev@huaxi100.com on 2017/1/11.
//  Copyright © 2017年 简伟. All rights reserved.
//

import UIKit
private let EdgeMargin: CGFloat = 10
private let ItemW: CGFloat = (JWScreenWidth - 2*EdgeMargin) / 3
private let ItemH: CGFloat = ItemW * 6 / 5
private let HeaderViewHeight:CGFloat = 50
private let GameViewHeight:CGFloat = 90

private let GameViewCellID = "GameViewCellID"
private let headerViewID = "headerViewID"

class GameViewController: BaseViewController {
    
    fileprivate lazy var gameVM: GameViewModel = GameViewModel()
    
    fileprivate lazy var topHeaderView: CollectionHeaderView = {
    
        let headerView = CollectionHeaderView.collectionHeaderView()
        headerView.frame = CGRect(x: 0, y: -HeaderViewHeight-GameViewHeight, width: JWScreenWidth, height: HeaderViewHeight)
        headerView.iconImageView.image = UIImage(named: "Img_orange")
        headerView.titleLabel.text = "常见"
        headerView.moreBtn.isHidden = true
        return headerView
    }()
    
    fileprivate lazy var gameView: CommendGameView = {
    
        let gameView = CommendGameView.commendGameView()
        gameView.frame = CGRect(x: 0, y: -GameViewHeight, width: JWScreenWidth, height: GameViewHeight)
        return gameView
    }()
    fileprivate lazy var collectionView: UICollectionView = {[unowned self] in
    
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: ItemW, height: ItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: EdgeMargin, bottom: 0, right: EdgeMargin)
        layout.headerReferenceSize = CGSize(width: JWScreenWidth, height: HeaderViewHeight)
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.dataSource = self as UICollectionViewDataSource?
        
        collectionView.register(UINib(nibName: "CollectionGameCell", bundle: nil), forCellWithReuseIdentifier: GameViewCellID)
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
extension GameViewController{

    override func setupUI(){
        
        view.addSubview(collectionView)
        collectionView.addSubview(topHeaderView)
        collectionView.addSubview(gameView)
        collectionView.contentInset = UIEdgeInsets(top: HeaderViewHeight+GameViewHeight, left: 0, bottom: 0, right: 0)
        baseContentView = collectionView
        super.setupUI()
    }
}

// MARK: - 请求数据源
extension GameViewController{

    fileprivate func loadDataSource() {
    
        gameVM.loadAllGameSource {
            self.loadDataFinished()
            self.collectionView.reloadData()
            self.gameView.groups = Array(self.gameVM.games[0..<10])
        }
    }
}

// MARK: - 遵守UICollectionViewDataSource
extension GameViewController: UICollectionViewDataSource{

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gameVM.games.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GameViewCellID, for: indexPath) as! CollectionGameCell
        cell.game = gameVM.games[indexPath.item]
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerViewID, for: indexPath) as! CollectionHeaderView
        headerView.titleLabel.text = "全部"
        headerView.iconImageView.image = UIImage(named: "Img_orange")
        headerView.moreBtn.isHidden = true
        return headerView
    }
}
