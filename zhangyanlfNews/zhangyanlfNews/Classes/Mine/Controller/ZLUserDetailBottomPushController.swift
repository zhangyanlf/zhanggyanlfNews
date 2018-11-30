//
//  ZLUserDetailBottomPushController.swift
//  zhangyanlfNews
//
//  Created by 张彦林 on 2018/11/29.
//  Copyright © 2018 zhangyanlf.cn. All rights reserved.
//

import UIKit
import WebKit

class ZLUserDetailBottomPushController: UIViewController {
    
    var url: String = ""
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let webView = WKWebView(frame: view.bounds)
        webView.load(URLRequest(url: URL(string: url)!))
        view.addSubview(webView)
    }
    

   

}
