//
//  PageTitleView.swift
//  JWDouYuZB
//
//  Created by dev@huaxi100.com on 2017/1/5.
//  Copyright © 2017年 简伟. All rights reserved.
//

import UIKit

protocol PageTitleViewDelegate: class {
    func pageTitleView(titleView:PageTitleView,selectedIndex index:Int)
}

fileprivate let scrollLineHeight: CGFloat = 2
fileprivate let NormalColor: (CGFloat,CGFloat,CGFloat) = (85, 85, 85)
fileprivate let SelectColor: (CGFloat,CGFloat,CGFloat) = (255, 128, 0)

class PageTitleView: UIView {
    
    //MARK: - 定义属性
    
    weak var delegate : PageTitleViewDelegate?
    
    fileprivate var titles: [String]
    
    fileprivate var currentIndex: Int = 0
    
    fileprivate lazy var scrollView:UIScrollView = {
    
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.bounces = false
        return scrollView
    }()
    
    fileprivate lazy var titleLabels: [UILabel] = [UILabel]()

    //MARK: - 自定义构造函数
    init(frame: CGRect,titles : [String]) {
        self.titles = titles
        
        super.init(frame: frame)
        
        setupUI()
    }
    fileprivate lazy var scrollLine: UIView = {
    
        let scrollLine = UIView()
        scrollLine.backgroundColor = UIColor(r: SelectColor.0, g: SelectColor.1, b: SelectColor.2)
        return scrollLine
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

//MARK: - 设置UI
extension PageTitleView{

    fileprivate func setupUI() {
    
        addSubview(scrollView)
        scrollView.frame = bounds
        
        setupTitleLabels()
        
        setupBottomLineAndScrollLine()
    }
    
    fileprivate func setupTitleLabels() {
    
        //确定label的frame固定值
        let labelW:CGFloat = frame.width / CGFloat(titles.count)
        let labelH:CGFloat = frame.height - scrollLineHeight
        let labelY:CGFloat = 0
        
        for (index,title) in titles.enumerated() {
            
            let titleLable = UILabel()
            titleLable.text = title
            titleLable.tag = index
            titleLable.font = UIFont.systemFont(ofSize: 16)
            titleLable.textColor = UIColor(r: NormalColor.0, g: NormalColor.1, b: NormalColor.2)
            titleLable.textAlignment = .center
            //设置frame
            let labelX:CGFloat = labelW * CGFloat(index)
            titleLable.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            scrollView.addSubview(titleLable)
            titleLabels.append(titleLable)
            
            titleLable.isUserInteractionEnabled = true
            
            //添加点击手势
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(titleLabelClick(tapeGes:)))
            titleLable.addGestureRecognizer(tapGesture)
        }
    }
    
    fileprivate func setupBottomLineAndScrollLine()  {
    
        //添加底部线条
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor.lightGray
        let lineHeight:CGFloat = 0.5
        bottomLine.frame = CGRect(x: 0, y: frame.height - lineHeight, width: frame.width, height: lineHeight)
        addSubview(bottomLine)
        
        //添加可以滑动的线条
        guard let firstLabel = titleLabels.first else { return }
        firstLabel.textColor = UIColor(r: SelectColor.0, g: SelectColor.1, b: SelectColor.2)
        scrollView.addSubview(scrollLine)
        scrollLine.frame = CGRect(x: firstLabel.frame.origin.x, y: frame.height - scrollLineHeight, width: firstLabel.frame.width, height: scrollLineHeight)
    }
}
//MARK: - 监听titleLabel的点击
extension PageTitleView{

    @objc fileprivate func titleLabelClick(tapeGes:UITapGestureRecognizer) {
        //获取当前label
        guard let currentLabel = tapeGes.view as? UILabel else { return }
        if currentLabel.tag == currentIndex { return }
        //获取之前选中Label
        let oldLabel = titleLabels[currentIndex]
        //切换文字颜色
        currentLabel.textColor = UIColor.orange
        oldLabel.textColor = UIColor.darkGray
        //保存最新Label的下标
        currentIndex = currentLabel.tag
        //底部滚动条位置改变
        let scrollLineX = CGFloat(currentLabel.tag) * scrollLine.frame.width
        UIView.animate(withDuration: 0.25) { 
             self.scrollLine.frame.origin.x = scrollLineX
        }
        
        delegate?.pageTitleView(titleView: self, selectedIndex: currentIndex)
    }
}

// MARK: - 对外暴露的方法
extension PageTitleView{

    func setTitleWithProgress(progress:CGFloat, sourceIndex:Int, targetIndex:Int) {
        //取出两个Label
        let sourceLabel = titleLabels[sourceIndex]
        let targetLabel = titleLabels[targetIndex]
        
        //底部滑块处理
        let moveTotalX = targetLabel.frame.origin.x - sourceLabel.frame.origin.x
        let moveX = moveTotalX * progress
        scrollLine.frame.origin.x = sourceLabel.frame.origin.x + moveX
        
        //处理字颜色渐变
        let colorDelta = (SelectColor.0 - NormalColor.0,SelectColor.1 - NormalColor.1,SelectColor.2 - NormalColor.2)
        sourceLabel.textColor = UIColor(r: SelectColor.0 - colorDelta.0*progress, g: SelectColor.1 - colorDelta.1*progress, b: SelectColor.2 - colorDelta.2*progress)
        targetLabel.textColor = UIColor(r: NormalColor.0 + colorDelta.0*progress, g: NormalColor.1 + colorDelta.1*progress, b: NormalColor.2 + colorDelta.2*progress)
        
        //记录最新的index
        currentIndex = targetIndex
    }
}

