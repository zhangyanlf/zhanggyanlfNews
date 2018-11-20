//
//  NetWorkTool.swift
//  zhangyanlfNews
//
//  Created by 张彦林 on 2018/11/14.
//  Copyright © 2018 zhangyanlf.cn. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

protocol NetWorkToolProtocol {
    //------------Home--------------------------
    ///获取新闻标题数据
     static func loadHomeTitleData(completionCallBack:@escaping(_ sections:[ZLHomeNewsTitle]) -> ())
    
    
    //------------Mine--------------------------
    ///获取我的界面cell数据
    static func loadMyCellData(completionCallBack:@escaping(_ sections:[[ZLMyCellModel]]) -> ())
    /// 获取我的关注数据
    static func loadMyAttent(completionCallBack:@escaping (_ sections:[ZLMyAttent]) -> ())
    
}

extension NetWorkToolProtocol {
    
     //------------Home--------------------------
    ///获取新闻标题数据
    static func loadHomeTitleData(completionCallBack: @escaping ([ZLHomeNewsTitle]) -> ()) {
        let url = BASE_URL + "/article/category/get_subscribed/v1/?"
        let parameters = ["device_id" : device_id,"iid":iid]
        
        Alamofire.request(url, parameters: parameters).responseJSON { (response) in
            
            guard response.result.isSuccess else {
                //网络错误提示
                return
            }
            if let value = response.result.value {
                let json = JSON(value)
                guard json["message"] == "success" else { return }
                if let dataDict = json["data"].dictionary{
                    if let datas = dataDict["data"]?.arrayObject{
                        var titleArrays = [ZLHomeNewsTitle]()
                        titleArrays.append(ZLHomeNewsTitle.deserialize(from: "{\"category\": \"\", \"name\": \"推荐\"}")!)
                        for dict in datas {
                            let titles = ZLHomeNewsTitle.deserialize(from: dict as? NSDictionary)
                            titleArrays.append(titles!)
                        }
                        //titleArrays += datas.compactMap(ZLHomeNewsTitle.deserialize(from: $0 as? Dictionary))
                        completionCallBack(titleArrays)
                    }
                    
                }
                
            }
        }
    }
    
    
    
     //------------Mine------------------------------------
    ///获取我的界面cell数据
    static func loadMyCellData(completionCallBack:@escaping (_ sections:[[ZLMyCellModel]]) -> ()) {
        
        let url = BASE_URL + "/user/tab/tabs?"
        let parameters = ["device_id" : device_id]
        
        Alamofire.request(url, parameters: parameters).responseJSON { (response) in
            
            guard response.result.isSuccess else {
                //网络错误提示
                return
            }
            if let value = response.result.value {
                let json = JSON(value)
                guard json["message"] == "success" else {
                    return
                }
                if let data = json["data"].dictionary{
                    print(data)
                    if let sections = data["sections"]?.array{
                        var sectionArray = [[ZLMyCellModel]]()
                        for item in sections {
                            var rows = [ZLMyCellModel]()
                            for row in item.arrayObject! {
                                let myCellModel = ZLMyCellModel.deserialize(from: row as? NSDictionary)
                                rows.append(myCellModel!)
                            }
                            sectionArray.append(rows)
                        }
                        completionCallBack(sectionArray)
                    }
                    
                }
                
            }
        }
        
    }
    /// 获取我的关注数据
    static func loadMyAttent(completionCallBack:@escaping (_ sections:[ZLMyAttent]) -> ()){
        let url = BASE_URL + "/concern/v2/follow/my_follow/?"
        let parameters = ["device_id" : device_id]
        
        Alamofire.request(url, parameters: parameters).responseJSON { (response) in
            
            guard response.result.isSuccess else {
                //网络错误提示
                return
            }
            if let value = response.result.value {
                let json = JSON(value)
                guard json["message"] == "success" else {
                    return
                }
                if let datas = json["data"].arrayObject{
                    print(datas)
                    var attents = [ZLMyAttent]()
                    for data in datas{
                        let attent = ZLMyAttent.deserialize(from: data as? NSDictionary)
                        attents.append(attent!)
                    }
                    completionCallBack(attents)
                }
            }
        }
    }
}

struct NetWorkTool: NetWorkToolProtocol {
   
    
    
}
