//
//  Const.swift
//  zhangyanlfNews
//
//  Created by 张彦林 on 2018/11/13.
//  Copyright © 2018 zhangyanlf.cn. All rights reserved.
//

import UIKit
/// 屏幕宽度
let screenWidth = UIScreen.main.bounds.width
/// 屏幕高度
let screenHeight = UIScreen.main.bounds.height

///服务器地址
//let BASE_URL = "http://lf.snssdk.com"
//let BASE_URL = "http://ib.snssdk.com"
let BASE_URL = "https://is.snssdk.com"

let device_id: Int = 6096495334
let iid: Int = 5034850950


let zlMyHeaderViewHeight: CGFloat = 280

let isNight = "isNight"
///判断 iPhone X
let isIPhoneX: Bool = screenHeight == 812 ? true : false
