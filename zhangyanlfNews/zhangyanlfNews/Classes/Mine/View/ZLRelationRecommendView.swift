//
//  ZLRelationRecommendView.swift
//  zhangyanlfNews
//
//  Created by 张彦林 on 2018/11/30.
//  Copyright © 2018 zhangyanlf.cn. All rights reserved.
//

import UIKit

class ZLRelationRecommendView: UIView, NibLoadable, RegisterCellFromNib {


    var userCards = [ZLUserCard]()
    
    @IBOutlet weak var relationLabelHeight: NSLayoutConstraint!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        theme_backgroundColor = "colors.cellBackgroundColor"
        collectionView.collectionViewLayout = RelationRecommendFlowLayout()
        collectionView.zl_registerCell(cell: ZLRelationRecommendCell.self)
        collectionView.delegate = self
        collectionView.dataSource  = self
    }
    
}

extension ZLRelationRecommendView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return userCards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.zl_dequeueReusableCell(indexPath: indexPath) as ZLRelationRecommendCell
        cell.userCard = userCards[indexPath.item]
        return cell
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
    }
}

///自定义FlowLayout
class RelationRecommendFlowLayout: UICollectionViewFlowLayout {
    override func prepare() {
        super.prepare()
        scrollDirection = .horizontal
        itemSize = CGSize(width: 142, height: 190)
        minimumLineSpacing = 10
        sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
}
