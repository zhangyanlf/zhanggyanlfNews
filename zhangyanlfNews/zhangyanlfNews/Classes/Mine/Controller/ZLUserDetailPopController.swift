//
//  ZLUserDetailPopController.swift
//  zhangyanlfNews
//
//  Created by 张彦林 on 2018/11/29.
//  Copyright © 2018 zhangyanlf.cn. All rights reserved.
//

import UIKit

class ZLUserDetailPopController: UIViewController ,UITableViewDelegate, UITableViewDataSource{

    var didSeletcedChild: ((ZLBottomTabChildren) -> ())?
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var childrens = [ZLBottomTabChildren]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "\(UITableViewCell.self)")
       
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return childrens.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(UITableViewCell.self)", for: indexPath)
        let child = childrens[indexPath.row]
        cell.textLabel?.text = child.name
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.font = UIFont.systemFont(ofSize: 13)
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
         NotificationCenter.default.post(name: NSNotification.Name(rawValue: ZLPresentationControllerDismiss), object: nil)
        didSeletcedChild!(childrens[indexPath.row])
    }
    

}
