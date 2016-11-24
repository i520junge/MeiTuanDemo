//
//  LeftViewCell.swift
//  美团
//
//  Created by xmg5 on 2016/11/23.
//  Copyright © 2016年 Seemygo. All rights reserved.
//

import UIKit

class LeftViewCell: UITableViewCell {

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundView = UIImageView(image: UIImage(named: "bg_dropdown_leftpart"))
        selectedBackgroundView = UIImageView(image: UIImage(named: "bg_dropdown_left_selected"))
        textLabel?.backgroundColor = UIColor.clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
