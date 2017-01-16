//
//  CollectionGameCell.swift
//  JWDouYuZB
//
//  Created by dev@huaxi100.com on 2017/1/11.
//  Copyright © 2017年 简伟. All rights reserved.
//

import UIKit

class CollectionGameCell: UICollectionViewCell {

    
    @IBOutlet var titleLabel: UILabel!

    @IBOutlet var imageView: UIImageView!
    
    var game: BaseGameModel? {
    
        didSet{
        
            titleLabel.text = game?.tag_name
            if let iconURL = URL(string: game?.icon_url ?? "") {
                imageView.kf.setImage(with: iconURL)
            } else {
                imageView.image = UIImage(named: "home_more_btn")
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
