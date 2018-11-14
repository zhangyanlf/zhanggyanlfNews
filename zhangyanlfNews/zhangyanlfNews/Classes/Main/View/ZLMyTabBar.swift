//
//  ZLMyTabBar.swift
//  zhangyanlfNews
//
//  Created by 张彦林 on 2018/11/13.
//  Copyright © 2018 zhangyanlf.cn. All rights reserved.
//

import UIKit

class ZLMyTabBar: UITabBar {

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(publishButton)
    }
    //private 绝对私有 只能在当前类中访问
    //fileprivate 文件私有
    //open 在任何类、文件都能访问
    
    private lazy var publishButton: UIButton = {
        let publishButton = UIButton(type: .custom)
        publishButton.setImage(UIImage(named: "feed_publish_44x44_"), for: .normal)
        publishButton.setImage(UIImage(named: "feed_publish_press_44x44_"), for: .selected)
        publishButton.sizeToFit()
        return publishButton
    }()
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //当前tabbar 宽度和高度
        let width = frame.width
        let height = frame.height
        publishButton.center = CGPoint(x: width * 0.5, y: height * 0.5)
        
        //设置其他按钮frame
        let buttonW = width * 0.2
        let buttonH = height
        let buttonY: CGFloat = 0
        
        var index = 0
        for button in subviews {
            if !button.isKind(of: NSClassFromString("UITabBarButton")!){ continue }
            let buttonX = buttonW * (index > 1 ? CGFloat(index + 1) : CGFloat(index))
            button.frame = CGRect(x: buttonX, y: buttonY, width: buttonW, height: buttonH)
            index += 1
        }
        
        
        
        
    }
    
}
