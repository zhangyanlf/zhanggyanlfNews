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
    
    /// 改变状态栏的字体颜色
    var changeStatusBarStyle: UIStatusBarStyle = .lightContent {
        didSet { setNeedsStatusBarAppearanceUpdate() }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //view.backgroundColor = UIColor.white
        scrollView.addSubview(headerView)
        scrollView.delegate = self
        view.addSubview(navigationBar)
        
        navigationBar.goBackClickBotton = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
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
                self.headerView.height = 969
                // 赋值到 bottomView 上
                self.bottomView.addSubview(self.myBottomView)
                self.bottomView.backgroundColor = UIColor.red
                self.myBottomView.bottomTabs = userDetail.bottom_tab
            }
        }

    }
    /// 底部试图
   fileprivate lazy var myBottomView : ZLUserDetailBottomView = {
         let myBottomView = ZLUserDetailBottomView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 44))
        myBottomView.delegate = self
        return myBottomView
    }()
    /// 头部试图
   fileprivate lazy var headerView : ZLUserDetailHeaderView = {
        let headerView = ZLUserDetailHeaderView.loadViewFromNib()
        
        return headerView
    }()
    /// 自定义导航
   fileprivate lazy var navigationBar = ZLNavigationBar.loadViewFromNib()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return changeStatusBarStyle
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


extension ZLUserDetailController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        print(offsetY)
        // 图片黏住顶部，拉伸
        if offsetY < (isIPhoneX ? -44 : -20) {
            let totalOffset = kZLUserDetailHeaderBGImageViewHeight + abs(offsetY)
            let f = totalOffset / kZLUserDetailHeaderBGImageViewHeight
            headerView.backgroundImageView.frame = CGRect(x: -screenWidth * (f - 1) * 0.5, y: offsetY, width: screenWidth * f, height: totalOffset)
            navigationBar.backgroundColor = UIColor(white: 1.0, alpha: 0.0)
        } else {
            var alpha: CGFloat = (offsetY + 44) / 58
            alpha = min(alpha, 1.0)
            navigationBar.backgroundColor = UIColor(white: 1.0, alpha: alpha)
            if alpha == 1.0 {
                changeStatusBarStyle = .default
                navigationBar.backBtn.theme_setImage("images.personal_home_back_black_24x24_", forState: .normal)
                navigationBar.moreBtn.theme_setImage("images.new_more_titlebar_24x24_", forState: .normal)
            } else {
                changeStatusBarStyle = .lightContent
               navigationBar.backBtn.theme_setImage("images.personal_home_back_white_24x24_", forState: .normal)
                navigationBar.moreBtn.theme_setImage("images.new_morewhite_titlebar_22x22_", forState: .normal)
            }
        }
    }
}
