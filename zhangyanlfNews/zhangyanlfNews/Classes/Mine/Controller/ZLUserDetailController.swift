//
//  ZLUserDetailController.swift
//  zhangyanlfNews
//
//  Created by 张彦林 on 2018/11/22.
//  Copyright © 2018 zhangyanlf.cn. All rights reserved.
//

import UIKit

class ZLUserDetailController: UIViewController {

    /// 滚动试图
    @IBOutlet weak var scrollView: UIScrollView!
    /// 底部视图
    @IBOutlet weak var bottomView: UIView!
    /// 底部View高度
    @IBOutlet weak var BottomViewConstraintHeight: NSLayoutConstraint!
    
    /// 距离底部约束
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    var userId: Int = 0
    
    var userDetail: ZLUserDetail?
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        scrollView.addSubview(headerView)
        view.addSubview(navigationBar)
        scrollView.contentSize = CGSize(width: screenWidth, height: 1000)
        // 设置约束
        bottomConstraint.constant = isIPhoneX ? 34 : 0
        view.layoutIfNeeded()
        /// 获取用户详情
        NetWorkTool.loadUserDetail(userId: userId) { (userDetail) in
            self.userDetail = userDetail
            self.headerView.userDetail = userDetail
            if self.userDetail?.bottom_tab.count == 0 {
                self.headerView.height = 979 - 34
                self.bottomConstraint.constant = 0
                self.BottomViewConstraintHeight.constant = 0
                self.view.layoutIfNeeded()
            } else {
                // 赋值到 bottomView 上
                self.bottomView.addSubview(self.myBottomView)
                self.myBottomView.bottomTabs = userDetail.bottom_tab
            }
        }

    }
    /// 底部试图
    lazy var myBottomView : ZLUserDetailBottomView = {
        let myBottomView = ZLUserDetailBottomView()
        myBottomView.delegate = self
        return myBottomView
    }()
    /// 头部试图
    lazy var headerView : ZLUserDetailHeaderView = {
        let headerView = ZLUserDetailHeaderView.loadViewFromNib()
        
        return headerView
    }()
    /// 自定义导航
    lazy var navigationBar = ZLNavigationBar.loadViewFromNib()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

}


extension ZLUserDetailController: UserDetailBottomViewDelegate  {
    
    
    /// 底部按钮点击
    ///
    /// - Parameters:
    ///   - button: 按钮
    ///   - bottomTab: ZLBottomTab
    func bottomView(clicked button: UIButton, bottomTab: ZLBottomTab) {
        

        let userDetailPushVC = ZLUserDetailBottomPushController()
        userDetailPushVC.title = "网页浏览"
        
        if bottomTab.children.count == 0 {// 直接跳转到下一控制器
            userDetailPushVC.url = bottomTab.value
            navigationController?.pushViewController(userDetailPushVC, animated: true)
        } else {// 弹出 子视图
            let storyBoard = UIStoryboard(name: "\(ZLUserDetailPopController.self)", bundle: nil)
            let udPopVC = storyBoard.instantiateViewController(withIdentifier: "\(ZLUserDetailPopController.self)") as! ZLUserDetailPopController
            
            udPopVC.childrens = bottomTab.children
            udPopVC.modalPresentationStyle = .custom
            udPopVC.didSeletcedChild = { [weak self] in
                userDetailPushVC.url = $0.value
                self!.navigationController?.pushViewController(userDetailPushVC, animated: true)
            }
            let popoverAnimator = ZLPopoverAnimator()
            let rect = myBottomView.convert(button.frame, to: view)
            let popWidth = (screenWidth - CGFloat(userDetail!.bottom_tab.count + 1) * 20) / CGFloat(userDetail!.bottom_tab.count)
            let popX = CGFloat(button.tag) * (popWidth + 20) + 20
            let popHeight = CGFloat(bottomTab.children.count) * 40 + 25
            popoverAnimator.presetnFrame = CGRect(x: popX, y: rect.origin.y - popHeight, width: popWidth, height: popHeight)
            
            udPopVC.transitioningDelegate = popoverAnimator
            present(udPopVC, animated: true, completion: nil)
            
            
        }
        
    }
    
    
}
