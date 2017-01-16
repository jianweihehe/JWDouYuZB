//
//  RoomShowViewController.swift
//  JWDouYuZB
//
//  Created by dev@huaxi100.com on 2017/1/16.
//  Copyright © 2017年 简伟. All rights reserved.
//

import UIKit

class RoomShowViewController: UIViewController {
    
    fileprivate lazy var dismissButton:UIButton = {
    
        let dismissButton = UIButton(type: UIButtonType.custom)
        dismissButton.frame = CGRect(x: JWScreenWidth - 100, y: 60, width: 80, height: 40)
        dismissButton.setTitle("返回", for: .normal)
        dismissButton.backgroundColor = UIColor.cyan
        dismissButton.addTarget(self, action: #selector(dissmissButtonClick), for: .touchUpInside)
        return dismissButton
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.red
        setupUI()
    }
    
    @objc private func dissmissButtonClick() {
    
        self.dismiss(animated: true, completion: nil)
    }
    
}

// MARK: - 设置UI界面
extension RoomShowViewController{

    func setupUI() {
    
        view.addSubview(dismissButton)
    }
}
