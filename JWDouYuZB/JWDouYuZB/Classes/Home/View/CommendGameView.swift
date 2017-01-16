//
//  CommendGameView.swift
//  JWDouYuZB
//
//  Created by dev@huaxi100.com on 2017/1/11.
//  Copyright © 2017年 简伟. All rights reserved.
//

import UIKit

fileprivate let GameViewCellID = "GameViewCellID"

class CommendGameView: UIView {

    @IBOutlet var collectionView: UICollectionView!
    
    var groups: [BaseGameModel]? {
    
        didSet{

            collectionView.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        autoresizingMask = UIViewAutoresizing()

        collectionView.register(UINib(nibName: "CollectionGameCell", bundle: nil), forCellWithReuseIdentifier: GameViewCellID)
    }

}

// MARK: - 提供快速创建的类方法
extension CommendGameView{

    class func commendGameView() -> CommendGameView{

       return Bundle.main.loadNibNamed("CommendGameView", owner: nil, options: nil)?.first as! CommendGameView
    }
}

// MARK: - 遵守UICollectionViewDataSource
extension CommendGameView: UICollectionViewDataSource{

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groups?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GameViewCellID, for: indexPath) as! CollectionGameCell
        cell.game = groups![indexPath.item]
        return cell
    }
}
