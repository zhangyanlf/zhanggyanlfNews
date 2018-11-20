//
//  ZLSystemSetupController.swift
//  zhangyanlfNews
//  系统设置 界面
//  Created by 张彦林 on 2018/11/19.
//  Copyright © 2018 zhangyanlf.cn. All rights reserved.
//

import UIKit

class ZLSystemSetupController: UITableViewController {

    var sections = [[ZLSettingModel]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

    // MARK: - Table view data source
    // 每组头部视图
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 10))
        
        view.theme_backgroundColor = "colors.tableViewBackgroundColor"
        return view
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
     
        return sections.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.zl_dequeueReusableCell(indexPath: indexPath) as ZLSettingCell
        let section = sections[indexPath.section]
        cell.setting = section[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    

}


extension ZLSystemSetupController {
    
   fileprivate func setupUI() {
        tableView.zl_registerCell(cell: ZLSettingCell.self)
        tableView.sectionHeaderHeight = 10
        tableView.rowHeight = 44
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.theme_backgroundColor = "colors.tableViewBackgroundColor"
        //加载plist 文件数据
        let path = Bundle.main.path(forResource: "settingPlist", ofType: ".plist")
        let cellPlist = NSArray(contentsOfFile: path!) as! [Any]
        
        for dicts in cellPlist {
            let array = dicts as! [[String : Any]]
            var rows = [ZLSettingModel]()
            for dict in array {
                let row = ZLSettingModel.deserialize(from: dict as NSDictionary)
                rows.append(row!)
            }
            sections.append(rows)
        }
    }
}
