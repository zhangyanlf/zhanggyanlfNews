//
//  ZLDongtaiCollectionView.swift
//  zhangyanlfNews
//
//  Created by 张彦林 on 2019/1/8.
//  Copyright © 2019 zhangyanlf.cn. All rights reserved.
//

import UIKit

class ZLDongtaiCollectionView: UICollectionView, UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource, NibLoadable {
    var thumbImageList = [ZLThumbImage]() {
        didSet {
            reloadData()
        }
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        dataSource = self
        delegate = self
        zl_registerCell(cell: ZLDongtaiCollectionViewCell.self)
        collectionViewLayout = DongtaiCollectionViewFlowLayout()
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false
        isScrollEnabled = false
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return thumbImageList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.zl_dequeueReusableCell(indexPath: indexPath) as ZLDongtaiCollectionViewCell
        cell.thumbImage = thumbImageList[indexPath.item]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return ZLCalculate.collectionViewCellSize(thumbImageList.count)
    }

}

class DongtaiCollectionViewFlowLayout: UICollectionViewFlowLayout {
    override func prepare() {
        super.prepare()
        minimumLineSpacing = 5
        minimumInteritemSpacing = 5
    }
}
