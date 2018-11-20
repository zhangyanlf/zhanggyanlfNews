//
//  ZLOfflineDownloadViewController.swift
//  zhangyanlfNews
//  离线下载界面
//  Created by 张彦林 on 2018/11/20.
//  Copyright © 2018 zhangyanlf.cn. All rights reserved.
//

import UIKit

class ZLOfflineDownloadViewController: UITableViewController {

    var homeTitles = [ZLHomeNewsTitle]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
    }

    // MARK: - Table view data source
    // 每组头部视图
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 44))
        
        view.theme_backgroundColor = "colors.tableViewBackgroundColor"
        let label = UILabel(frame: CGRect(x: 15, y: 0, width: screenWidth, height: 44))
        label.text = "我的频道"
        let separatorView = UIView(frame: CGRect(x: 0, y: 43, width: screenWidth, height: 1))
        separatorView.theme_backgroundColor = "colors.separatorViewColor"
        view.addSubview(separatorView)
        label.theme_textColor = "colors.black"
        view.addSubview(label)
        return view
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.homeTitles.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.zl_dequeueReusableCell(indexPath: indexPath) as ZLOffLineDownLoadCell
        cell.titles = homeTitles[indexPath.row]
        return cell
    }
    
}


extension ZLOfflineDownloadViewController {
    fileprivate func setupUI(){
        tableView.zl_registerCell(cell: ZLOffLineDownLoadCell.self)
        tableView.rowHeight = 44
        tableView.sectionHeaderHeight = 44
        tableView.tableFooterView = UIView()
        tableView.theme_separatorColor = "colors.separatorViewColor"
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tableView.theme_backgroundColor = "colors.tableViewBackgroundColor"
        NetWorkTool.loadHomeTitleData { (homeTitles) in
            self.homeTitles = homeTitles
            self.tableView.reloadData()
        }
    }
}
