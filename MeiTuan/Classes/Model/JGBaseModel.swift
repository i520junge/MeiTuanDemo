//
//  JGBaseModel.swift
//  MeiTuan
//
//  Created by 刘军 on 2016/11/24.
//  Copyright © 2016年 刘军. All rights reserved.
//

import UIKit

class JGBaseModel: NSObject {
    
//MARK:- 自定义构造函数，外界传入字典，转模型
    init(dict:[String:Any]) {
        super.init()
        
        setValuesForKeys(dict)
    }
    
    //防止有的key没有
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
    }
}
