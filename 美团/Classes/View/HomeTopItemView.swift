//
//  HomeTopItemView.swift
//  美团
//
//  Created by xmg5 on 2016/11/23.
//  Copyright © 2016年 Seemygo. All rights reserved.
//

import UIKit

class HomeTopItemView: UIView {
    @IBOutlet weak var iconBtn: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
}


extension HomeTopItemView {
    class func loadTopView() -> HomeTopItemView {
        return Bundle.main.loadNibNamed("HomeTopItemView", owner: nil, options: nil)?.first as! HomeTopItemView
    }
    
    func setInfo(_ iconName : String, _ highIconName : String, _ title : String, _ subtitle : String) {
        iconBtn.setImage(UIImage(named: iconName), for: .normal)
        iconBtn.setImage(UIImage(named: highIconName), for: .highlighted)
        titleLabel.text = title
        subtitleLabel.text = subtitle
    }
    
    func addTarget(target : Any?, action : Selector) {
        iconBtn.addTarget(target, action: action, for: .touchUpInside)
    }
}
