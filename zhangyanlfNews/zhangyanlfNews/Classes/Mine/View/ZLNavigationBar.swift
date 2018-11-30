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
    
}
