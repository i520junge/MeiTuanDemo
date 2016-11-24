//
//  RightViewCell.swift
//  美团
//
//  Created by xmg5 on 2016/11/23.
//  Copyright © 2016年 Seemygo. All rights reserved.
//

import UIKit

class RightViewCell: UITableViewCell {

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundView = UIImageView(image: UIImage(named: "bg_dropdown_rightpart"))
        selectedBackgroundView = UIImageView(image: UIImage(named: "bg_dropdown_right_selected"))
        textLabel?.backgroundColor = UIColor.clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
