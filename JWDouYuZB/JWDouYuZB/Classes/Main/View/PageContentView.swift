//
//  PageContentView.swift
//  JWDouYuZB
//
//  Created by dev@huaxi100.com on 2017/1/5.
//  Copyright © 2017年 简伟. All rights reserved.
//

import UIKit

protocol PageContentViewDelegate : class {
    func pageContentView(_ contentView : PageContentView, progress : CGFloat, sourceIndex : Int, targetIndex : Int)
}

fileprivate let contentID = "contentID"

class PageContentView: UIView {
    
    fileprivate var contents:[UIViewController]
    fileprivate weak var parentViewController: UIViewController?
    fileprivate var startContentOffsetX: CGFloat = 0
    fileprivate var isForbidScrollDelegate: Bool = false
    weak var delegate: PageContentViewDelegate?
    fileprivate lazy var conllectionView: UICollectionView = { [weak self] in
    
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = (self?.bounds.size)!
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.dataSource = self
        collectionView.delegate = self as UICollectionViewDelegate?
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: contentID)
        return collectionView
    }()

    init(frame:CGRect, contents: [UIViewController],parentViewController:UIViewController){
        self.contents = contents
        self.parentViewController = parentViewController
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - 设置UI
extension PageContentView{

    fileprivate func setupUI() {
    
        //将所有的子控制器添加到父控制器中
        for childVC in contents {
        
            parentViewController!.addChildViewController(childVC)
        }
        
        addSubview(conllectionView)
        conllectionView.frame = bounds
        
    }
}

//MARK: -  UICollectionViewDataSource
extension PageContentView: UICollectionViewDataSource{

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return contents.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: contentID, for: indexPath)
        for view in cell.contentView.subviews{
        
            view.removeFromSuperview()
        }
        let childVC = contents[indexPath.item]
        childVC.view.backgroundColor = UIColor.randomColor()
        childVC.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVC.view)
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension PageContentView: UICollectionViewDelegate{
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        isForbidScrollDelegate = false
        startContentOffsetX = scrollView.contentOffset.x
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {

        // 0.判断是否是点击事件
        if isForbidScrollDelegate { return }
        
        var progress : CGFloat = 0
        var sourceIndex : Int = 0
        var targetIndex : Int = 0
        let currentOffsetX = scrollView.contentOffset.x
        let scrollViewWidth = scrollView.bounds.width
        if currentOffsetX > startContentOffsetX {//向左滑动
            progress = currentOffsetX / scrollViewWidth - floor(currentOffsetX / scrollViewWidth)
            sourceIndex = Int(currentOffsetX / scrollViewWidth)
            targetIndex = sourceIndex + 1
            if targetIndex >= contents.count {
                targetIndex = contents.count - 1
            }
            //如果完全划过去
            if currentOffsetX - startContentOffsetX == scrollViewWidth {
                progress = 1
                targetIndex = sourceIndex
            }
        }else{//向右滑动
            progress = 1 - (currentOffsetX / scrollViewWidth - floor(currentOffsetX / scrollViewWidth))
            targetIndex = Int(currentOffsetX / scrollViewWidth)
            sourceIndex = targetIndex + 1
            if sourceIndex >= contents.count {
                sourceIndex = contents.count - 1
            }
        }
        self.delegate?.pageContentView(self, progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}


// MARK: 对外暴露的方法
extension PageContentView{

    func setCurrentIndex(currentIndex:Int) {
        
        isForbidScrollDelegate = true
        
        let offSetX = CGFloat(currentIndex) * conllectionView.frame.width
        conllectionView.setContentOffset(CGPoint(x: offSetX, y: 0), animated: false)
    }
}









