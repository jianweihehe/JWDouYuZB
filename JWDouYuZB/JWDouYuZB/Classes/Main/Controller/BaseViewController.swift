//
//  BaseViewController.swift
//  JWDouYuZB
//
//  Created by dev@huaxi100.com on 2017/1/16.
//  Copyright © 2017年 简伟. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    var baseContentView: UIView?
    

    //属性设置
    fileprivate lazy var animationImgView: UIImageView = { [unowned self] in
        
        let aimgView = UIImageView(image: UIImage(named: "img_loading_1"))
        aimgView.center = self.view.center
        aimgView.animationImages = [UIImage(named: "img_loading_1")!,UIImage(named: "img_loading_2")!]
        aimgView.animationDuration = 0.5
        aimgView.animationRepeatCount = LONG_MAX
        aimgView.autoresizingMask = [.flexibleTopMargin,.flexibleBottomMargin]
        return aimgView
    }()
    
    //系统回调
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

}

// MARK: - 添加数据加载是的动画
extension BaseViewController{

    //执行动画的imgView
    func setupUI() {
    
        baseContentView?.isHidden = true
        view.addSubview(animationImgView)
        animationImgView.startAnimating()
        view.backgroundColor = UIColor(r: 250, g: 250, b: 250)
    }
    
    func loadDataFinished() {
    
        animationImgView.stopAnimating()
        animationImgView.isHidden = true
        baseContentView?.isHidden = false
    }
}
