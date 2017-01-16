//
//  CommendCycleView.swift
//  JWDouYuZB
//
//  Created by dev@huaxi100.com on 2017/1/10.
//  Copyright © 2017年 简伟. All rights reserved.
//

import Foundation
import UIKit

fileprivate let cycleCellID = "cycleCellID"

class CommendCycleView: UIView {
    
    @IBOutlet var collectionView: UICollectionView!
    
    @IBOutlet var pageControl: UIPageControl!
    
    var cycleTimer: Timer?
    
    
    var cycleModels: [CycleModel]?{
    
        didSet{
        
            collectionView.reloadData()
            pageControl.numberOfPages = cycleModels?.count ?? 0
            let indexPath = IndexPath(item: (cycleModels?.count ?? 0) * 30, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .left, animated: false)
            
            // 4.添加定时器
            removeCycleTimer()
            addCycleTimer()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // 设置该控件不随着父控件的拉伸而拉伸
        autoresizingMask = UIViewAutoresizing()
        collectionView.register(UINib(nibName: "CollectionCycleCell", bundle: nil), forCellWithReuseIdentifier: cycleCellID)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = collectionView.bounds.size
    }
}

// MARK: - 提供一个快速创建View的类方法
extension CommendCycleView{
    
    class func commendCycleView() -> CommendCycleView {
    
        return Bundle.main.loadNibNamed("CommendCycleView", owner: nil, options: nil)?.first as! CommendCycleView
    }
}

// MARK: - 遵守UICollectionViewDataSource
extension CommendCycleView: UICollectionViewDataSource{

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (cycleModels?.count ?? 0) * 10000
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cycleCellID, for: indexPath) as! CollectionCycleCell
        cell.cycleModel = cycleModels![indexPath.item % cycleModels!.count]
        return cell
    }
}

// MARK: - 设置UICollectionViewDelegate
extension CommendCycleView: UICollectionViewDelegate{

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let offSetX = scrollView.contentOffset.x
        let currentIndex = Int(offSetX / scrollView.bounds.width + 0.5) % (cycleModels?.count ?? 1)
        pageControl.currentPage = currentIndex
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        removeCycleTimer()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        addCycleTimer()
    }
}

// MARK: - 对定时器的操作
extension CommendCycleView{

    fileprivate func addCycleTimer(){
    
        cycleTimer = Timer(timeInterval: 2.0, target: self, selector: #selector(self.scrollToNext), userInfo: nil, repeats: true)
        RunLoop.main.add(cycleTimer!, forMode: RunLoopMode.commonModes)
    }
    
    fileprivate func removeCycleTimer(){
        //从运行循环中移除
        cycleTimer?.invalidate()
        cycleTimer = nil
    }
    
    @objc fileprivate func scrollToNext() {
    
        // 1.获取滚动的偏移量
        let currentOffsetX = collectionView.contentOffset.x
        let offsetX = currentOffsetX + collectionView.bounds.width
        
        // 2.滚动该位置
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
    }
}

