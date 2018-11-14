//
//  UIKit+Extension.swift
//  zhangyanlfNews
//
//  Created by 张彦林 on 2018/11/14.
//  Copyright © 2018 zhangyanlf.cn. All rights reserved.
//

import UIKit

protocol RegisterCellFromNib {}

extension RegisterCellFromNib {
   static var identifier : String { return "\(self)" }
   static var nib: UINib? { return UINib(nibName: "\(self)", bundle: nil) }
}


extension UITableView {
    ///注册Cell方法
    func zl_registerCell<T: UITableViewCell>(cell: T.Type) where T: RegisterCellFromNib {
        if let nib = T.nib { register(nib, forCellReuseIdentifier: T.identifier) }
        else { register(cell, forCellReuseIdentifier: T.identifier) }
    }
    
    ///从缓存池中取出cell
    func zl_dequeueReusableCell<T: UITableViewCell>(indexPath: IndexPath) -> T where T: RegisterCellFromNib {
        return dequeueReusableCell(withIdentifier: T.identifier, for: indexPath) as! T
        
    }
}


extension UICollectionView {
    ///注册Cell方法
    func zl_registerCell<T: UICollectionViewCell>(cell: T.Type) where T: RegisterCellFromNib {
        if let nib = T.nib { register(nib, forCellWithReuseIdentifier: T.identifier) }
        else { register(cell, forCellWithReuseIdentifier: T.identifier) }
    }
    
    ///从缓存池中取出cell
    func zl_dequeueReusableCell<T: UICollectionViewCell>(indexPath: IndexPath) -> T where T: RegisterCellFromNib {
        return dequeueReusableCell(withReuseIdentifier: T.identifier, for: indexPath) as! T
        
    }
}
