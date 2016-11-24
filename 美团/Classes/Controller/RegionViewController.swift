//
//  RegionViewController.swift
//  美团
//
//  Created by xmg5 on 2016/11/23.
//  Copyright © 2016年 Seemygo. All rights reserved.
//

import UIKit

class RegionViewController: UIViewController {
    
    fileprivate lazy var lrTableView : LRTableView = LRTableView.loadLrTableView()
    fileprivate lazy var regions : [Region] = [Region]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 1.设置UI界面
        setupUI()
        
        // 2.加载数据
        loadRegionData()
        
        // 3.成为lrTableView数据源
        lrTableView.dataSource = self
    }
    
}


extension RegionViewController {
    fileprivate func setupUI() {
        preferredContentSize = CGSize(width: 320, height: 480)
        lrTableView.frame = view.bounds
        view.addSubview(lrTableView)
    }
    
    fileprivate func loadRegionData() {
        // 1.获取plist文件的路径
        let plistPath = Bundle.main.path(forResource: "gz.plist", ofType: nil)!
        
        // 2.加载数据
        guard let dataArray = NSArray(contentsOfFile: plistPath) as? [[String : Any]] else { return }
        
        // 3.将字典转成模型对象
        for dict in dataArray {
            regions.append(Region(dict: dict))
        }
    }
}


extension RegionViewController : LRTableViewDataSource {
    func numberOfLeftRowsInLrTableView(_ lrTableView: LRTableView) -> Int {
        return regions.count
    }
    
    func lrTableView(_ lrTableView: LRTableView, leftTitleIn leftRow: Int) -> String {
        return regions[leftRow].name
    }
    
    func lrTableView(_ lrTableView: LRTableView, subdataIn leftRow: Int) -> [String]? {
        return regions[leftRow].subregions
    }
}
