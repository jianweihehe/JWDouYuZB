//
//  CollectionCycleCell.swift
//  JWDouYuZB
//
//  Created by dev@huaxi100.com on 2017/1/10.
//  Copyright © 2017年 简伟. All rights reserved.
//

import UIKit

class CollectionCycleCell: UICollectionViewCell {

    @IBOutlet var imageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    var cycleModel: CycleModel?{
    
        didSet{
            titleLabel.text = cycleModel?.title
            let iconURL = URL(string: cycleModel?.pic_url ?? "")!
            imageView.kf.setImage(with: iconURL, placeholder: UIImage(named: "Img_default"))
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

}
