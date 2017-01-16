//
//  CollectionNormalCell.swift
//  JWDouYuZB
//
//  Created by dev@huaxi100.com on 2017/1/6.
//  Copyright © 2017年 简伟. All rights reserved.
//

import UIKit

class CollectionNormalCell: UICollectionViewCell {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var readCountButton: UIButton!
    @IBOutlet var nickNameButton: UIButton!
    @IBOutlet var imageView: UIImageView!
    
    var anchor: AnchorModel? {
    
        didSet{
        
            titleLabel.text = anchor?.room_name
            nickNameButton.setTitle(anchor?.nickname, for: .normal)
            var onlineStr : String = ""
            if (anchor?.online)! >= 10000 {
                onlineStr = "\(Int((anchor?.online)! / 10000))万在线"
            } else {
                onlineStr = "\((anchor?.online)!)在线"
            }
            readCountButton.setTitle(onlineStr, for: .normal)
            guard let iconURL = URL(string: (anchor?.vertical_src)!) else { return }
            imageView.kf.setImage(with: iconURL)
        }
    }
    

}
