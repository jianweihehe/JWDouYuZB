//
//  CollectionPrettyCell.swift
//  JWDouYuZB
//
//  Created by dev@huaxi100.com on 2017/1/9.
//  Copyright © 2017年 简伟. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionPrettyCell: UICollectionViewCell {
    @IBOutlet var readCountButton: UIButton!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var locationButton: UIButton!
    @IBOutlet var backImageView: UIImageView!
    
    var anchor: AnchorModel? {
        
        didSet{
            
            titleLabel.text = anchor?.room_name
            locationButton.setTitle(anchor?.anchor_city, for: .normal)
            var onlineStr : String = ""
            if (anchor?.online)! >= 10000 {
                onlineStr = "\(Int((anchor?.online)! / 10000))万在线"
            } else {
                onlineStr = "\((anchor?.online)!)在线"
            }
            readCountButton.setTitle(onlineStr, for: .normal)

            guard let iconURL = URL(string: (anchor?.vertical_src)!) else { return }
            backImageView.kf.setImage(with: iconURL)
        }
    }

}
