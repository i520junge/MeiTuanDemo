//
//  HomeViewController.swift
//  美团
//
//  Created by xmg5 on 2016/11/23.
//  Copyright © 2016年 Seemygo. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    // MARK: 控件属性
    fileprivate var categoryItem : UIBarButtonItem!
    fileprivate var regionItem : UIBarButtonItem!
    fileprivate var sortItem : UIBarButtonItem!
    
    // MARK: 懒加载属性
    fileprivate lazy var categoryVc : CategoryViewController = {
        let categoryVc = CategoryViewController()
        categoryVc.modalPresentationStyle = .popover
        return categoryVc
    }()
    fileprivate lazy var regionVc : RegionViewController = {
        let regionVc = RegionViewController()
        regionVc.modalPresentationStyle = .popover
        return regionVc
    }()
    
    fileprivate lazy var sortVc : SortViewController = {
        let sortVc = SortViewController()
        sortVc.modalPresentationStyle = .popover
        return sortVc
    }()
    
    // MARK: 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        // 监听通知
        NotificationCenter.default.addObserver(self, selector: #selector(sortDidChange(_:)), name: kSortDidChangeNoteKey, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}


extension HomeViewController {
    fileprivate func setupUI() {
        // 1.设置导航栏的背景
        let navBar = navigationController?.navigationBar
        navBar?.setBackgroundImage(UIImage(named: "bg_navigationBar_normal"), for: .default)
        
        // 2.设置导航栏的items
        setupNavigationBarItems()
    }
    
    private func setupNavigationBarItems() {
        // 1.logo的item
        let logoItem = UIBarButtonItem(image: UIImage(named: "icon_meituan_logo"), style: .plain, target: nil, action: nil)
        logoItem.isEnabled = false
        
        // 2.分类的item
        let categoryView = HomeTopItemView.loadTopView()    //加载xib
        categoryView.setInfo("icon_category_-1", "icon_category_highlighted_-1", "美团", "全部分类")  //设置xib的内容
        categoryView.addTarget(target: self, action: #selector(categoryItemClick))
        categoryItem = UIBarButtonItem(customView: categoryView)
        
        // 3.区域的item
        let regionView = HomeTopItemView.loadTopView()
        regionView.setInfo("icon_district", "icon_district_highlighted", "广州", "全部区域")
        regionView.addTarget(target: self, action: #selector(regionItemClick))
        regionItem = UIBarButtonItem(customView: regionView)
        
        // 3.排序的item
        let sortView = HomeTopItemView.loadTopView()
        sortView.setInfo("icon_sort", "icon_sort_highlighted", "排序", "默认排序")
        sortView.addTarget(target: self, action: #selector(sortItemClick))
        sortItem = UIBarButtonItem(customView: sortView)
    
        navigationItem.leftBarButtonItems = [logoItem, categoryItem, regionItem, sortItem]
    }
}



// MARK:- 监听item的点击
extension HomeViewController {
    @objc fileprivate func categoryItemClick() {
        categoryVc.popoverPresentationController?.barButtonItem = categoryItem
        present(categoryVc, animated: true, completion: nil)
    }
    
    @objc fileprivate func regionItemClick() {
        regionVc.popoverPresentationController?.barButtonItem = regionItem
        present(regionVc, animated: true, completion: nil)
    }
    
    @objc fileprivate func sortItemClick() {
        sortVc.popoverPresentationController?.barButtonItem = sortItem
        present(sortVc, animated: true, completion: nil)
    }
}



// MARK:- 监听通知
extension HomeViewController {
    @objc fileprivate func sortDidChange(_ note : Notification) {
        // 1.取出模型对象
        guard let sort = note.userInfo![kSortDidChangeSortNameKey] as? Sort else { return }
        
        // 2.将内容设置到item中
        let sortView = sortItem.customView as? HomeTopItemView
        sortView?.subtitleLabel.text = sort.label
    }
}
