//
//  ZLNavigationBar.swift
//  zhangyanlfNews
//
//  Created by 张彦林 on 2018/11/29.
//  Copyright © 2018 zhangyanlf.cn. All rights reserved.
//

import UIKit
import IBAnimatable

class ZLNavigationBar: UIView, NibLoadable {
    
    var userDetail: ZLUserDetail? {
        didSet {
            nameLabel.text = userDetail!.screen_name
            concernButton.isSelected = userDetail!.is_following
            concernButton.theme_backgroundColor = userDetail!.is_following ? "colors.userDetailFollowingConcernBtnBgColor" : "colors.globalRedColor"
            concernButton.borderColor = userDetail!.is_following ? .grayColor232() : .globalRedColor()
            concernButton.borderWidth = userDetail!.is_following ? 1 : 0
        }
    }

    /// 导航栏栏
    @IBOutlet weak var navigationBar: UIView!
    ///返回按钮
    @IBOutlet weak var backBtn: UIButton!
    /// 更多按钮
    @IBOutlet weak var moreBtn: UIButton!
    
    /// 标题
    @IBOutlet weak var nameLabel: UILabel!
    /// 关注按钮
    @IBOutlet weak var concernButton: AnimatableButton!
    
    var goBackClickBotton: (()->())?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        theme_backgroundColor = "colors.cellBackgroundColor"
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        height = navigationBar.frame.maxY
        self.frame = CGRect(x: 0, y: 0, width: screenWidth, height: height)
    }
    
    
    /// 返回按钮点击
    @IBAction func returnButtonClicked(_ sender: UIButton) {
        goBackClickBotton?()
    }
    
    /// 更多按钮点击
    @IBAction func moreButtonClicked(_ sender: UIButton) {
        
    }
    
    /// 关注按钮
    @IBAction func concernButtonClicked(_ sender: AnimatableButton) {
        
        
    }
    
    
}
