//
//  ZLDongtaiOriginThreadView.swift
//  zhangyanlfNews
//
//  Created by 张彦林 on 2019/1/8.
//  Copyright © 2019 zhangyanlf.cn. All rights reserved.
//

import UIKit

class ZLDongtaiOriginThreadView: UIView, NibLoadable {
    
    
    var originThread = ZLDongtaiOriginThread() {
        didSet {
            contentLabel.text = originThread.content
            contentlabelConstraint.constant = originThread.contentH
            collectionView.thumbImageList = originThread.thumb_image_list
            layoutIfNeeded()
        }
    }
    

    @IBOutlet weak var collectionView: ZLDongtaiCollectionView!
    
    @IBOutlet weak var contentLabel: UILabel!
    
    @IBOutlet weak var contentlabelConstraint: NSLayoutConstraint!
    override func awakeFromNib() {
        super.awakeFromNib()
        theme_backgroundColor = "colors.grayColor247"
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        height = originThread.height
    }

}
