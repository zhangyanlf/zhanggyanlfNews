//
//  ZLNewsNavigationController.swift
//  zhangyanlfNews
//
//  Created by 张彦林 on 2018/11/9.
//  Copyright © 2018 zhangyanlf.cn. All rights reserved.
//

import UIKit

class ZLNewsNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        ///全局拖拽手势
        initGestureGlobal()
        
        let navigationBar = UINavigationBar.appearance()
        //navigationBar.theme_tintColor = "colors.black"
        navigationBar.theme_barTintColor = "colors.cellBackgroundColor"
        
        //设置导航颜色
        if UserDefaults.standard.bool(forKey: isNight) {
             navigationBar.setBackgroundImage(UIImage(named: "navigation_background_night"), for: .default)
        } else {
            navigationBar.setBackgroundImage(UIImage(named: "navigation_background"), for: .default)
        }
         NotificationCenter.default.addObserver(self, selector: #selector(receiveDayoOrNightChange), name: NSNotification.Name(rawValue: "dayoOrNightChange"), object: nil)

    }
    
    
    @objc func receiveDayoOrNightChange(notification: Notification) {
        let selected = notification.object as! Bool
        if selected { // 设置为日间
            navigationBar.setBackgroundImage(UIImage(named: "navigation_background_night"), for: .default)
            
        } else { // 设置为夜间
            navigationBar.setBackgroundImage(UIImage(named: "navigation_background"), for: .default)
        }
    }
    

    // 拦截 push 操作
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if viewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "lefterbackicon_titlebar_24x24_"), style: .plain, target: self, action: #selector(navigationBack))
        }
        super.pushViewController(viewController, animated: true)
    }
    
    @objc func navigationBack() {
        popViewController(animated: true)
    }
    
    

}


extension ZLNewsNavigationController: UIGestureRecognizerDelegate{
    /// 全局返回手势
    fileprivate func initGestureGlobal() {
        //1.获取系统的pop手势
        guard let systemGes = interactivePopGestureRecognizer else { return }
        //2.获取手势添加到的view中
        guard let gesView = systemGes.view else { return }
        
        //3.获取target/action
        //3.1利用运行时机制查看所有属性名称
        /*
         var count: UInt32 = 0
         let ivars = class_copyIvarList(UIGestureRecognizer.self, &count)!
         for i in 0..<count {
         let ivar = ivars[Int(i)]
         let name = ivar_getName(ivar)
         print(String(cString: name!))
         }
         */
        let targets = systemGes.value(forKey: "_targets") as? [NSObject]
        guard let targetObjc = targets?.first else { return }
        print(targetObjc)
        //3.2 取出target
        guard let target = targetObjc.value(forKey: "target") else { return }
        //3.3 取出action
        let action = Selector(("handleNavigationTransition:"))
        
        //4.创建自己的pan手势
        let panGes = UIPanGestureRecognizer()
        gesView.addGestureRecognizer(panGes)
        
        panGes.addTarget(target, action: action)
    }
}
