//
//  ZLVideoViewController.swift
//  zhangyanlfNews
//
//  Created by 张彦林 on 2018/11/9.
//  Copyright © 2018 zhangyanlf.cn. All rights reserved.
//

import UIKit

class ZLVideoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // 设置UI
        setupUI()
        
    }
    
    
    lazy var navigationBar: ZLHomeNavigationBar = {
        let navigationBar = ZLHomeNavigationBar.loadViewFromNib()
        return navigationBar
    }()
    

    

}

extension ZLVideoViewController {
    private func setupUI(){
        view.theme_backgroundColor = "colors.cellBackgroundColor"
        navigationController?.navigationBar.barStyle = .black
        navigationItem.titleView = navigationBar
        
        //获取新闻标题数据
        NetWorkTool.loadHomeTitleData { (homeTitles) in
            NewsTitleTable().insert(homeTitles)
        }
        // 点击图像按钮
        navigationBar.didSelectAvatarButton = { [weak self] in
            self?.navigationController?.pushViewController(ZLMineViewController(), animated: true)
        }
    }
}
