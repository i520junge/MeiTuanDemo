//
//  Category.swift
//  美团
//
//  Created by xmg5 on 2016/11/23.
//  Copyright © 2016年 Seemygo. All rights reserved.
//

import UIKit

class Category: BaseModel {
    // MARK: 分类的属性
    var highlighted_icon : String = ""
    var icon : String = ""
    var small_highlighted_icon : String = ""
    var small_icon : String = ""
    var name : String = ""
    var subcategories : [String]?
}
