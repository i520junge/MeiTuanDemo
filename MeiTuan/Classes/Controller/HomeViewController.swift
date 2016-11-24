//
//  HomeViewController.swift
//  MeiTuan
//
//  Created by 刘军 on 2016/11/24.
//  Copyright © 2016年 刘军. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    //MARK:- 控件属性
    fileprivate var categoryItem:UIBarButtonItem?   //分类
    fileprivate var regionItem:UIBarButtonItem?     //区域
    fileprivate var sortItem:UIBarButtonItem?       //排序
    
    //MARK:- 懒加载属性
    fileprivate lazy var categoryVC:JGCategoryVC = {
        let categoryVC = JGCategoryVC()
        categoryVC.modalPresentationStyle = .popover
        return categoryVC
    }()
    
    fileprivate lazy var regionVC:JGRegionVC = {
        let regionVC = JGRegionVC()
        regionVC.modalPresentationStyle = .popover
        return regionVC
    }()
    
    fileprivate lazy var sortVC:JGSortVC = {
        let sortVC = JGSortVC()
        sortVC.modalPresentationStyle = .popover
        return sortVC
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
}

//MARK:- 初始化界面
extension HomeViewController{
    fileprivate func  setUpUI(){
//        1、设置导航栏背景
        let bar = navigationController?.navigationBar
        bar?.setBackgroundImage(UIImage(named: "bg_navigationBar_normal"), for: .default)
            
//        2、设置导航栏的items
        setUpNavgationItem()
    }
    
    fileprivate func setUpNavgationItem(){
//        0、logo的item
        let logoItem = UIBarButtonItem(image: UIImage(named: "icon_meituan_logo"), style: .plain, target: nil, action: nil)
        logoItem.isEnabled = false  //让它无法点击
        
//        1、分类item
        //①、加载xib
        let categoryView = JGTopNavItem.topNavItem()
        //②、设置xib内容
        categoryView.setUpInfo("icon_category_-1", "icon_category_highlighted_-1", "美团", "全部分类")
        //监听按钮点击
        categoryView.addTargetBtnClick(target: self, action: #selector(categoryItemClick))
        //③、把自定义view赋值给item
        categoryItem = UIBarButtonItem(customView: categoryView)
        
        //给categoryVC闭包赋值
        categoryVC.categoryBlock = {
            (iconName:String,highIconName:String,subName:String) in
            categoryView.iconBtn.setImage(UIImage(named: iconName), for: .normal)
            categoryView.iconBtn.setImage(UIImage(named: highIconName), for: .highlighted)
            categoryView.subTitleLabel.text = subName
        }
        
        
//        2、区域item
        let regionView = JGTopNavItem.topNavItem()
        regionView.setUpInfo("icon_district", "icon_district_highlighted", "广州", "全部区域")
        regionView.addTargetBtnClick(target: self, action: #selector(regionItemClick))
        regionItem = UIBarButtonItem(customView: regionView)
        
        //给regionVC闭包赋值
        regionVC.regionBlock = {
            (subName:String) in
            regionView.subTitleLabel.text = subName
        }
        
//        3、排序item
        let sortView = JGTopNavItem.topNavItem()
        sortView.setUpInfo("icon_sort", "icon_sort_highlighted", "排序", "默认排序")
        sortView.addTargetBtnClick(target: self, action: #selector(sortItemClick))
        sortItem = UIBarButtonItem(customView: sortView)
        
        //给sortVC的闭包赋值
        sortVC.sortBlock = {
            (sortName:String) in
            sortView.subTitleLabel.text = sortName
        }
        
        
//        4、将所有item添加到导航栏的左边items中
        navigationItem.leftBarButtonItems = [logoItem,categoryItem!,regionItem!,sortItem!]
    }
}

//MARK:- item的点击事件
extension HomeViewController{
    @objc fileprivate func categoryItemClick(){//必须加@objc，方法选择器是在objc runtime运行环境下调用的
        //UIBarButtonItem可以不用设置sourceRect、sourceView
        categoryVC.popoverPresentationController?.barButtonItem = categoryItem
        present(categoryVC, animated: true, completion: nil)
    }
    
    @objc fileprivate func regionItemClick(){//必须加@objc
        regionVC.popoverPresentationController?.barButtonItem = regionItem
        present(regionVC, animated: true, completion: nil)
    }
    
    @objc fileprivate func sortItemClick(){//必须加@objc
        sortVC.popoverPresentationController?.barButtonItem = sortItem
        present(sortVC, animated: true, completion: nil)
    }
}

