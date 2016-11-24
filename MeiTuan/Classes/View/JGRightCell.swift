//
//  JGRightCell.swift
//  MeiTuan
//
//  Created by 刘军 on 2016/11/24.
//  Copyright © 2016年 刘军. All rights reserved.
//

import UIKit

class JGRightCell: UITableViewCell {

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        //设置cell的背景
        backgroundView = UIImageView(image: UIImage(named: "bg_dropdown_leftpart"))
        selectedBackgroundView = UIImageView(image: UIImage(named: "bg_dropdown_left_selected"))
        
        //显示文字的label背景为透明，不然会挡住cell的背景
        textLabel?.backgroundColor = UIColor.clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
