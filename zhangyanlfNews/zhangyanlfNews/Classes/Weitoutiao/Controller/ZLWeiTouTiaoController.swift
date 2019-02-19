//
//  ZLWeiTouTiaoController.swift
//  zhangyanlfNews
//
//  Created by 张彦林 on 2019/1/15.
//  Copyright © 2019 zhangyanlf.cn. All rights reserved.
//

import UIKit

class ZLWeiTouTiaoController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

}


extension ZLWeiTouTiaoController {
    //设置UI
    private func setupUI(){
        view.theme_backgroundColor = "colors.cellBackgroundColor"
        if UserDefaults.standard.bool(forKey: isNight) { //夜间
            ZlThemeStyle.setNightnavigationStyle(self)
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "follow_title_profile_night_18x18_"), style: .plain, target: self, action: #selector(rightbarButtonItemClick))
        } else { //日间
            ZlThemeStyle.setDaynavigationStyle(self)
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "follow_title_profile_18x18_"), style: .plain, target: self, action: #selector(rightbarButtonItemClick))
            
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(receiveDayoOrNightChange), name: NSNotification.Name(rawValue: "dayoOrNightChange"), object: nil)
    }
    
    
    @objc private func receiveDayoOrNightChange(notification: Notification) {
        let selected = notification.object as! Bool
        if selected { // 设置为夜间
             ZlThemeStyle.setNightnavigationStyle(self)
            
        } else { // 设置为日间
            ZlThemeStyle.setDaynavigationStyle(self)
        }
    }
    
    @objc private func rightbarButtonItemClick() {
        
    }
    
}
