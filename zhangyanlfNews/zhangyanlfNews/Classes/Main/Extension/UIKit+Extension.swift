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


extension UIColor {
    
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, alpha:CGFloat = 1.0) {
        if #available(iOS 10.0, *) {
            self.init(displayP3Red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: alpha)
        } else {
            self.init(r: r / 255.0, g: g / 255.0, b:  b / 255.0, alpha: alpha)
        }
    }
    
    /// 背景灰色 f8f9f7
    class func globalBackgroundColor() -> UIColor {
        return UIColor(r: 248, g: 249, b: 247)
    }
    
    /// 背景红色
    class func globalRedColor() -> UIColor {
        return UIColor(r: 196, g: 73, b: 67)
    }
    
    /// 字体蓝色
    class func blueFontColor() -> UIColor {
        return UIColor(r: 72, g: 100, b: 149)
    }
    
    /// 背景灰色 132
    class func grayColor132() -> UIColor {
        return UIColor(r: 132, g: 132, b: 132)
    }
    
    /// 背景灰色 232
    class func grayColor232() -> UIColor {
        return UIColor(r: 232, g: 232, b: 232)
    }
    
    /// 夜间字体背景灰色 113
    class func grayColor113() -> UIColor {
        return UIColor(r: 113, g: 113, b: 113)
    }
    
    /// 夜间背景灰色 37
    class func grayColor37() -> UIColor {
        return UIColor(r: 37, g: 37, b: 37)
    }
    
    /// 灰色 210
    class func grayColor210() -> UIColor {
        return UIColor(r: 210, g: 210, b: 210)
    }
    
}
