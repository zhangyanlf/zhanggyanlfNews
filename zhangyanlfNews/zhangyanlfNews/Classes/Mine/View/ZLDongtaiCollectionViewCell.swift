//
//  ZLDongtaiCollectionViewCell.swift
//  zhangyanlfNews
//
//  Created by 张彦林 on 2019/1/3.
//  Copyright © 2019 zhangyanlf.cn. All rights reserved.
//

import UIKit
import Kingfisher

class ZLDongtaiCollectionViewCell: UICollectionViewCell, RegisterCellFromNib {
    
   
    var thumbImage = ZLThumbImage() {
        didSet{
            thumbImageView.kf.setImage(with: URL(string: thumbImage.urlString))
        }
    }

    @IBOutlet weak var thumbImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
