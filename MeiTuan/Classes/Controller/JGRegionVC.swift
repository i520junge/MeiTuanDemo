//
//  JGRegionVC.swift
//  MeiTuan
//
//  Created by 刘军 on 2016/11/24.
//  Copyright © 2016年 刘军. All rights reserved.
//

import UIKit

class JGRegionVC: UIViewController {
//MARK:- 闭包属性
    var regionBlock:((_ subName:String)->())?
    
//MARK:- 懒加载属性
    fileprivate lazy var regionArr:[JGRegionModel] = [JGRegionModel]()
    fileprivate lazy var towTableView = JGTowTableView.towTableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        1、初始化界面
        setUpUI()
        
//        2、加载数据
        loadCategoryData()
        
//        3、展示数据
        towTableView.dataSource = self
        towTableView.delegate = self
    }
}

//MARK:- 初始化界面
extension JGRegionVC{
    fileprivate func setUpUI(){
//        1、确定popover的尺寸
        preferredContentSize = CGSize(width: 320, height: 480)
        
//        2、懒加载towTableView，添加到view上
        towTableView.frame = view.bounds
        view.addSubview(towTableView)
    }
}

//MARK:- 加载数据，转模型
extension JGRegionVC{
    fileprivate func loadCategoryData(){
        //        1、获取plist文件路径
        let plistPath = Bundle.main.path(forResource: "gz.plist", ofType: nil)!
        
        //        2、根据路径加载数据
        guard let dataArray = NSArray(contentsOfFile: plistPath) as? [[String:Any]] else{return}    //swift中Array没有contentsOfFile方法，所以用NSArray，然后再转化为swift中的数组
        
        //        3、遍历字典数组 转为模型，保存到模型数组中
        for dict in dataArray{
            regionArr.append(JGRegionModel(dict: dict))
        }
    }
}

//MARK:- towTableView数据源
extension JGRegionVC:JGTowTableViewDataSource{
    func towTableView(_ tableView: JGTowTableView, numberOfRowsInSection section: Int) -> Int {
        return regionArr.count
    }
    
    func towTableView(_ tableView: JGTowTableView, leftTitleInfo leftRow: Int) -> String {
        return regionArr[leftRow].name
    }
    
    func towTableView(_ tableView: JGTowTableView, subTitleInfo leftRow: Int) -> [String] {
        return regionArr[leftRow].subregions ?? []
    }
}

//MARK:- 代理方法回调闭包
extension JGRegionVC:JGTowTableViewDelegate{
    func towTableView(_ tableView: JGTowTableView, leftRow: Int, didSelectedRightRow: Int) {
        //回调闭包
        if let callBack = regionBlock{
            callBack(regionArr[leftRow].subregions?[didSelectedRightRow] ?? "")
        }
    }
}

