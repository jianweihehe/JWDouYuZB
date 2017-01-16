//
//  AmuseMenuCell.swift
//  JWDouYuZB
//
//  Created by dev@huaxi100.com on 2017/1/16.
//  Copyright © 2017年 简伟. All rights reserved.
//

import UIKit

private let GameViewCellID = "GameViewCellID"

class AmuseMenuCell: UICollectionViewCell {
    @IBOutlet var collectionView: UICollectionView!

    var groups:[AnchorGroup]? {
    
        didSet{
        
            self.collectionView.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        autoresizingMask = UIViewAutoresizing()
       
        collectionView.register(UINib(nibName: "CollectionGameCell", bundle: nil), forCellWithReuseIdentifier: GameViewCellID)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let itemWidth = collectionView.bounds.width / 4
        let itemHeight = collectionView.bounds.height / 2
        layout.itemSize = CGSize(width: itemWidth, height: itemHeight)
    }

}

extension AmuseMenuCell: UICollectionViewDataSource{

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groups?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GameViewCellID, for: indexPath) as! CollectionGameCell
        cell.game = groups![indexPath.item]
        cell.clipsToBounds = true
        
        return cell
    }
}
