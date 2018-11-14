//
//  ZLMineViewController.swift
//  zhangyanlfNews
//
//  Created by 张彦林 on 2018/11/9.
//  Copyright © 2018 zhangyanlf.cn. All rights reserved.
//

import UIKit
let zlMyOtherCell: String = "zlMyOtherCell"
let zlAttentCell: String = "zlAttentCell"
class ZLMineViewController: UITableViewController {

    var sections = [[ZLMyCellModel]]()
    var attents = [ZLMyAttent]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.white
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = UIColor.globalBackgroundColor()
        tableView.separatorStyle = .none
        tableView.zl_registerCell(cell: ZLMyOtherCell.self)
        tableView.zl_registerCell(cell: ZLAttentCell.self)
        
        NetWorkTool.loadMyCellData { (sections) in
            let string = "{\"text\": \"我的关注\", \"grey_text\": \"\"}"
            let myAttent = ZLMyCellModel.deserialize(from: string)
            var myAttents = [ZLMyCellModel]()
            myAttents.append(myAttent!)
            self.sections.append(myAttents)
            self.sections += sections
            self.tableView.reloadData()
            
            NetWorkTool.loadMyAttent(completionCallBack: { (attents) in
                self.attents = attents
                let indexSet = IndexSet(integer: 0)
                self.tableView.reloadSections(indexSet, with: .automatic)
            })
            
        }
    }
    

    
}


extension ZLMineViewController {
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 1 ? 0 : 10
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 10))
        view.backgroundColor = UIColor.globalBackgroundColor()
        return view
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 && indexPath.row == 0 {
            let cell = tableView.zl_dequeueReusableCell(indexPath: indexPath) as ZLAttentCell

            let section = sections[indexPath.section]
            cell.zlMyCellModel = section[indexPath.row]
            
            if sections.count == 0 || sections.count == 1 {
                cell.attentCollectionView.isHidden = true
            }
            if sections.count == 1 {
                cell.zlMyAtten = attents[0]
            }
            if sections.count > 1 {
                cell.attents = attents
            }
           
            return cell
        }
        let cell = tableView.zl_dequeueReusableCell(indexPath: indexPath) as ZLMyOtherCell
        let section = sections[indexPath.section]
        let myCellModel = section[indexPath.row]
        cell.leftLabel.text = myCellModel.text
        cell.rightLabel.text = myCellModel.grey_text
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 && indexPath.row == 0 {
            return (attents.count == 0 || attents.count == 1) ? 40 : 114
        }
        return 40
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
}
