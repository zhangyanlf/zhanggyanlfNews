//
//  ZLMyTabController.swift
//  zhangyanlfNews
//
//  Created by 张彦林 on 2018/11/9.
//  Copyright © 2018 zhangyanlf.cn. All rights reserved.
//

import UIKit

class ZLMyTabController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let tabbar = UITabBar.appearance()
        tabbar.tintColor = UIColor(red: 245/255.0, green: 90/255.0, blue: 93/255.0, alpha: 1.0)
        
        ///添加子控制器
        addChildViewController()
        print(tabBar.subviews)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)
         print(tabBar.subviews)
    }
    ///添加子控制器
    func addChildViewController() {
        setChild(ZLHomeViewController(), title: "首页", imageName: "home_tabbar_32x32_", selectedImageName: "home_tabbar_press_32x32_")
        setChild(ZLVideoViewController(), title: "视频", imageName: "video_tabbar_32x32_", selectedImageName: "video_tabbar_press_32x32_")
        setChild(ZLHuoShanViewController(), title: "小视频", imageName: "huoshan_tabbar_32x32_", selectedImageName: "huoshan_tabbar_press_32x32_")
        setChild(ZLMineViewController(), title: "我的", imageName: "no_login_tabbar_32x32_", selectedImageName: "no_login_tabbar_press_32x32_")
        //tabbar 是 readonly 属性不能直接修改 通过KVC
        setValue(ZLMyTabBar(), forKey: "tabBar")
    }
    

    ///初始化子控制器
     func setChild(_ childController: UIViewController,title: String,imageName: String,selectedImageName: String) {
        //设置Tab 图片和文字
        childController.tabBarItem.image = UIImage(named: imageName)
        childController.tabBarItem.selectedImage = UIImage(named: selectedImageName)
        childController.tabBarItem.title = title
        childController.title = title
        //添加导航控制器为 TabBar子控制器
        let navVC = ZLNewsNavigationController.init(rootViewController: childController)
        addChild(navVC)
        
    }
}
