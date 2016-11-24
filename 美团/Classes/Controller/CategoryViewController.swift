//
//  CategoryViewController.swift
//  美团
//
//  Created by xmg5 on 2016/11/23.
//  Copyright © 2016年 Seemygo. All rights reserved.
//

import UIKit

class CategoryViewController: UIViewController {
    
    fileprivate lazy var categories : [Category] = [Category]()
    fileprivate lazy var lrTableView = LRTableView.loadLrTableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        loadCategoryData()
        
        lrTableView.dataSource = self
        lrTableView.delegate = self
    }
}


extension CategoryViewController {
    fileprivate func setupUI() {
        // 1.设置控制器在Popover中显示的尺寸
        preferredContentSize = CGSize(width: 320, height: 480)
        
        // 2.添加左右tableView
        lrTableView.frame = view.bounds
        view.addSubview(lrTableView)
    }
}


extension CategoryViewController {
    fileprivate func loadCategoryData() {
        // 1.获取plist文件的路径
        let plistPath = Bundle.main.path(forResource: "categories.plist", ofType: nil)!
        
        // 2.根据路径,加载对应的数据
        guard let dataArray = NSArray(contentsOfFile: plistPath) as? [[String : Any]] else {
            return
        }
        
        // 3.遍历字典,并且将字典转成模型对象
        for dict in dataArray {
            categories.append(Category(dict: dict))
        }
    }
}


extension CategoryViewController : LRTableViewDataSource, LRTableViewDelegate {
    func numberOfLeftRowsInLrTableView(_ lrTableView: LRTableView) -> Int {
        return categories.count
    }
    
    func lrTableView(_ lrTableView: LRTableView, leftTitleIn leftRow: Int) -> String {
        return categories[leftRow].name
    }
    
    func lrTableView(_ lrTableView: LRTableView, subdataIn leftRow: Int) -> [String]? {
        return categories[leftRow].subcategories
    }
    
    func lrTableView(_ lrTableView: LRTableView, iconNameIn leftRow: Int) -> String {
        return categories[leftRow].small_icon
    }
    
    func lrTableView(_ lrTableView: LRTableView, highIconNameIn leftRow: Int) -> String {
        return categories[leftRow].small_highlighted_icon
    }
    
    func lrTableView(_ lrTableView: LRTableView, didSelected leftRow: Int) {
        print(leftRow)
    }
    
    func lrTableView(_ lrTableView: LRTableView, leftRow: Int, didSelected rightRow: Int) {
        print(leftRow, rightRow)
    }
}
