//
//  ZLNavigationBar.swift
//  zhangyanlfNews
//
//  Created by 张彦林 on 2018/11/29.
//  Copyright © 2018 zhangyanlf.cn. All rights reserved.
//

import UIKit

class ZLNavigationBar: UIView, NibLoadable {

    /// 导航栏栏
    @IBOutlet weak var navigationBar: UIView!
    ///返回按钮
    @IBOutlet weak var backBtn: UIButton!
    /// 更多按钮
    @IBOutlet weak var moreBtn: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        navigationBar.width = screenWidth
        //theme_backgroundColor = "colors.cellBackgroundColor"
        //backBtn.theme_setImage("images.personal_home_back_white_24x24_", forState: .normal)
        //moreBtn.theme_setImage("images.new_morewhite_titlebar_22x22_", forState: .normal)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        height = navigationBar.frame.maxY
    }
    
    
    /// 返回按钮点击
    @IBAction func returnButtonClicked(_ sender: UIButton) {
        
    }
    
    /// 更多按钮点击
    @IBAction func moreButtonClicked(_ sender: UIButton) {
        
    }
    
}
