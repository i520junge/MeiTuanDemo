//
//  SortViewController.swift
//  美团
//
//  Created by xmg5 on 2016/11/23.
//  Copyright © 2016年 Seemygo. All rights reserved.
//

import UIKit

class SortViewController: UIViewController {
    
    fileprivate lazy var sorts : [Sort] = [Sort]()
    fileprivate var selectedBtn : UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 1.加载数据
        loadSortData()
        
        // 2.设置UI界面
        setupUI()
    }
    
}


extension SortViewController {
    fileprivate func setupUI() {
        
        // 0.定义常量
        let edgeMargin : CGFloat = 15
        let lineMargin : CGFloat = 10
        let itemW : CGFloat = 120
        let itemH : CGFloat = 35
        
        // 1.获取数据的个数
        let count = sorts.count
        
        // 2.遍历所有的数据
        for i in 0..<count {
            // 2.1.创建UIButton
            let btn = UIButton()
            
            // 2.2.设置btn的属性
            btn.frame = CGRect(x: edgeMargin, y: lineMargin + (lineMargin + itemH) * CGFloat(i), width: itemW, height: itemH)
            btn.setTitle(sorts[i].label, for: .normal)
            btn.setTitleColor(UIColor.black, for: .normal)
            btn.setTitleColor(UIColor.white, for: .selected)
            btn.setBackgroundImage(UIImage(named: "btn_filter_normal"), for: .normal)
            btn.setBackgroundImage(UIImage(named: "btn_filter_selected"), for: .selected)
            btn.tag = i
            
            // 2.3.将btn添加到控制器的View中
            view.addSubview(btn)
            
            // 2.4.监听btn的点击
            btn.addTarget(self, action: #selector(btnClick(_ :)), for: .touchDown)
        }
        
        // 3.设置控制器在Popover中显示的尺寸
        preferredContentSize = CGSize(width: itemW + 2 * edgeMargin, height: (itemH + lineMargin) * CGFloat(count) + lineMargin)
    }
    
    @objc private func btnClick(_ btn : UIButton) {
        // 交换三部曲
        selectedBtn?.isSelected = false
        selectedBtn = btn
        selectedBtn?.isSelected = true
        
        // 将数据传递出去
        NotificationCenter.default.post(name: kSortDidChangeNoteKey, object: nil, userInfo: [kSortDidChangeSortNameKey : sorts[btn.tag]])
        
        // 消失Popover
        dismiss(animated: true, completion: nil)
    }
}


extension SortViewController {
    fileprivate func loadSortData() {
        let plistPath = Bundle.main.path(forResource: "sorts.plist", ofType: nil)!
        
        guard let dataArray = NSArray(contentsOfFile: plistPath) as? [[String : Any]] else {
            return
        }
        
        for dict in dataArray {
            sorts.append(Sort(dict: dict))
        }
    }
}
