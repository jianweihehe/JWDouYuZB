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
fileprivate let normalItemHeight = itemWidth * 3 / 4
fileprivate let prettyItemHeight = itemWidth * 4 / 3
fileprivate let headerViewHeight:CGFloat = 50
fileprivate let normalCellID = "normalCellID"
fileprivate let prettyCellID = "prettyCellID"
fileprivate let headerViewID = "headerViewID"
fileprivate let CycleViewHeight = JWScreenWidth * 3 / 8
fileprivate let GameViewHeight:CGFloat = 90

class CommendViewController: BaseAnchorViewController {
    
    fileprivate lazy var commendVM: CommendViewModel = CommendViewModel()

    fileprivate lazy var cycleView: CommendCycleView = {
    
        let cycleView = CommendCycleView.commendCycleView()
        cycleView.frame = CGRect(x: 0, y: -CycleViewHeight-GameViewHeight, width: JWScreenWidth, height: CycleViewHeight)
        cycleView.backgroundColor = UIColor.red
        return cycleView
    }()
    
    fileprivate lazy var gameView: CommendGameView = {
    
        let gameView = CommendGameView.commendGameView()
        gameView.frame = CGRect(x: 0, y: -GameViewHeight, width: JWScreenWidth, height: GameViewHeight)
        gameView.backgroundColor = UIColor.red
        return gameView
    }()
    //系统回调
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK: - 设置UI界面
extension CommendViewController {

    override func setupUI() {
        
        super.setupUI()
        view.addSubview(collectionView)
        collectionView.addSubview(cycleView)
        collectionView.addSubview(gameView)
        collectionView.contentInset = UIEdgeInsets(top: CycleViewHeight+GameViewHeight, left: 0, bottom: 0, right: 0)
    }
}
// MARK: - 网络数据请求
extension CommendViewController{
    
    override func loadDataSource() {

        baseVM = commendVM
        
        commendVM.requestData {
            self.collectionView.reloadData()
            
            var groups = self.commendVM.anchorGropus
            groups.removeFirst()
            groups.removeFirst()
            //添加更多
            let mroeGroup = AnchorGroup()
            mroeGroup.tag_name = "更多"
            groups.append(mroeGroup)
            self.gameView.groups = groups
        }
        
        commendVM.requestCycleData {
            
            self.cycleView.cycleModels = self.commendVM.cycleModels
        }
    }
}

extension CommendViewController{

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: prettyCellID, for: indexPath) as! CollectionPrettyCell
            let group = baseVM.anchorGropus[indexPath.section]
            cell.anchor = group.anchors[indexPath.row]
            return cell
        }else{
        
            return super.collectionView(collectionView, cellForItemAt: indexPath)
        }
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 1 {

            return CGSize(width: itemWidth, height: prettyItemHeight)
        }
        
        return CGSize(width: itemWidth, height: normalItemHeight)
    }
}


