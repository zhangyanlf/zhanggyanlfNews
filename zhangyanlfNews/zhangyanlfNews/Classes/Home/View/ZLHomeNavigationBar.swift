//
//  ZLHomeNavigationBar.swift
//  zhangyanlfNews
//
//  Created by 张彦林 on 2019/1/14.
//  Copyright © 2019 zhangyanlf.cn. All rights reserved.
//

import UIKit
import IBAnimatable
class ZLHomeNavigationBar: UIView, NibLoadable {

    @IBOutlet weak var searchButton: AnimatableButton!
    
    @IBOutlet weak var avatarButton: UIButton!
    
    /// 搜索按钮点击
    var didSelectSearchButton: (()->())?
    /// 头像按钮点击
    var didSelectAvatarButton: (()->())?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        searchButton.theme_backgroundColor = "colors.cellBackgroundColor"
        searchButton.theme_setTitleColor("colors.grayColor150", forState: .normal)
        searchButton.setImage(UIImage(named: "search_small_16x16_"), for: [.normal, .highlighted])
        searchButton.contentHorizontalAlignment = .left
        //设置按钮titleLabel  后面...
        searchButton.titleLabel?.lineBreakMode = .byTruncatingTail
        searchButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        searchButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0)
        avatarButton.theme_setImage("images.home_no_login_head", forState: .normal)
        avatarButton.theme_setImage("images.home_no_login_head", forState: .highlighted)
        NetWorkTool.loadHomeSearchSuggestInfo { (suggestInfo) in
            self.searchButton.setTitle(suggestInfo, for: .normal)
        }
    }
    
    // 固有大小
    override var intrinsicContentSize: CGSize{
        return UIView.layoutFittingExpandedSize
    }
    
    
    override var frame: CGRect {
        didSet{
            super.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 44)
        }
    }
    
    //我的点击
    @IBAction func avatarButtonClick(_ sender: Any) {
        didSelectAvatarButton?()
    }
    
    //点击搜索
    @IBAction func searchButtonClick(_ sender: Any) {
        didSelectSearchButton?()
    }
    
}
