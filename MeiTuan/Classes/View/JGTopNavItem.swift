//
//  JGTopNavItem.swift
//  MeiTuan
//
//  Created by 刘军 on 2016/11/24.
//  Copyright © 2016年 刘军. All rights reserved.
//

import UIKit

class JGTopNavItem: UIView {
    @IBOutlet weak var iconBtn: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    
    // 初始化设置xib不被拉伸：
    //方式一：在awakeFromNib设置autoresizingMask为.init(rawValue: 0)，在OC中是none
    //方式二：在xib视图里面autoresizing那里只留下上面和左边箭头，其他都取消
    
    override func awakeFromNib() {
        super.awakeFromNib()
        autoresizingMask = .init(rawValue: 0)
    }
}

//MARK:- 提供类方法给外界创建对象
extension JGTopNavItem{
    class func topNavItem()->JGTopNavItem{
        return Bundle.main.loadNibNamed("JGTopNavItem", owner: nil, options: nil)?.first as! JGTopNavItem
    }
}

//MARK:- 设置内部子控件内容
extension JGTopNavItem{
    func setUpInfo(_ iconName:String,_ highIconName:String,_ title:String,_ subTitle:String) {
        iconBtn.setImage(UIImage(named: iconName), for: .normal)
        iconBtn.setImage(UIImage(named: highIconName), for: .highlighted)
        
        titleLabel.text = title
        subTitleLabel.text = subTitle
    }
}

//MARK:- 提供方法供外面监听按钮点击
extension JGTopNavItem{
    func addTargetBtnClick(target: Any?,action: Selector) {
        iconBtn.addTarget(target, action: action, for: .touchUpInside)
    }
}
