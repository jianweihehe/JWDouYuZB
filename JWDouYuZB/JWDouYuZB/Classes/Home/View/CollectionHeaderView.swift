//
//  CollectionHeaderView.swift
//  JWDouYuZB
//
//  Created by dev@huaxi100.com on 2017/1/6.
//  Copyright © 2017年 简伟. All rights reserved.
//

import UIKit

class CollectionHeaderView: UICollectionReusableView {
    @IBOutlet var iconImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var moreBtn: UIButton!
    
    var group:AnchorGroup? {
    
        didSet{
        
            titleLabel.text = group?.tag_name
            iconImageView.image = UIImage(named: group?.icon_name ?? "home_header_normal")
        }
    }
    
    
}

// MARK: - 从XIB中创建的类方法
extension CollectionHeaderView{

    class func collectionHeaderView() -> CollectionHeaderView {
    
        return Bundle.main.loadNibNamed("CollectionHeaderView", owner: nil, options: nil)?.first as! CollectionHeaderView
    }
}
