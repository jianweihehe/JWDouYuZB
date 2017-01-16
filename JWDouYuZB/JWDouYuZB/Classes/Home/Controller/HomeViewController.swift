//
//  HomeViewController.swift
//  JWDouYuZB
//
//  Created by dev@huaxi100.com on 2017/1/5.
//  Copyright © 2017年 简伟. All rights reserved.
//

import UIKit
private let JWTitleViewHeight: CGFloat = 40

class HomeViewController: UIViewController {
    
    //MARK: - 懒加载属性
    
    fileprivate lazy var pageTitleView:PageTitleView = { [weak self] in
    
        let titleViewFrame = CGRect(x: 0, y: JWStatusBarHeight+JWNavigationBarHeight, width: JWScreenWidth, height: JWTitleViewHeight)
        let titles = ["推荐","游戏","娱乐","趣玩"]
        let titlesView = PageTitleView(frame: titleViewFrame, titles: titles)
        titlesView.delegate = self as PageTitleViewDelegate?
        return titlesView
    }()
    
    fileprivate lazy var pageContentView: PageContentView = { [weak self] in
        
        let contentHeight = JWScreenHeight - JWStatusBarHeight - JWNavigationBarHeight - JWTitleViewHeight - 44
        let contentFrame = CGRect(x: 0, y: JWStatusBarHeight + JWNavigationBarHeight + JWTitleViewHeight, width: JWScreenWidth, height: contentHeight)
    
        var childVCs = [UIViewController]()
        childVCs.append(CommendViewController())
        childVCs.append(GameViewController())
        childVCs.append(AmuseViewController())
        childVCs.append(FunnyViewController())
        let pageContentView = PageContentView(frame: contentFrame, contents: childVCs, parentViewController: self!)
        pageContentView.delegate = self as PageContentViewDelegate?
        return pageContentView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
}
//MARK: - 设置UI界面
extension HomeViewController {

    fileprivate func setupUI() {
        automaticallyAdjustsScrollViewInsets = false
        //设置导航栏
        setupNavigationBar()
        //添加titleView
        view.addSubview(self.pageTitleView)
        
        view.addSubview(self.pageContentView)
    }
    
    fileprivate func setupNavigationBar() {
        //设置左侧的Item
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "logo")
        //设置右侧的Item
        let size = CGSize(width: 40, height: 40)
        let scanBarBtnItem = UIBarButtonItem.createItem(imageName: "Image_scan", highlightedImageName: "Image_scan_click", size: size)
        
        let historyBarBtnItem = UIBarButtonItem.createItem(imageName: "image_my_history", highlightedImageName: "Image_my_history_click", size: size)

        let searchBarBtnItem = UIBarButtonItem(imageName: "btn_search", highlightedImageName: "btn_search_clicked", size: size)
        
        navigationItem.rightBarButtonItems = [historyBarBtnItem,searchBarBtnItem,scanBarBtnItem]
    }
}

//MARK: - PageTitleViewDelegate
extension HomeViewController: PageTitleViewDelegate{

    func pageTitleView(titleView: PageTitleView, selectedIndex index: Int) {

        pageContentView.setCurrentIndex(currentIndex: index)
    }
}

// MARK: - PageContentViewDelegate

extension HomeViewController: PageContentViewDelegate{

    func pageContentView(_ contentView: PageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        
        pageTitleView.setTitleWithProgress(progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}


