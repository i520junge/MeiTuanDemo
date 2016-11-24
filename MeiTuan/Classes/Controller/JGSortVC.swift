//
//  JGSortVC.swift
//  MeiTuan
//
//  Created by 刘军 on 2016/11/24.
//  Copyright © 2016年 刘军. All rights reserved.
//

import UIKit

class JGSortVC: UIViewController {
    //MARK:- 属性
    fileprivate lazy var sortArr:[JGSortModel] = [JGSortModel]()
    fileprivate var selectBtn:UIButton?
    var sortBlock:((_ sortName:String)->())?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        2、加载数据
        loadRegionData()
        
//        1、初始化界面
        setUpUI()
        
    }
}

//MARK:- 初始化界面
extension JGSortVC{
    fileprivate func setUpUI(){
        let edgeMargin:CGFloat = 15
        let rowMargin:CGFloat = 10
        let w:CGFloat = 120
        let h:CGFloat = 35
        let x:CGFloat = edgeMargin
        
//        1、添加按钮
        for i in 0..<sortArr.count{
            let y:CGFloat = rowMargin + (rowMargin + h)*CGFloat(i)
            let btn = UIButton(frame: CGRect(x: x, y: y, width: w, height: h))
            btn.setBackgroundImage(UIImage(named: "btn_filter_normal"), for: .normal)
            btn.setBackgroundImage(UIImage(named: "btn_filter_selected"), for: .highlighted)
            btn.setTitle(sortArr[i].label, for: .normal)
            btn.setTitleColor(UIColor.black, for: .normal)
            btn.setTitleColor(UIColor.white, for: .highlighted)
            btn.tag = i
            
            btn.addTarget(self, action: #selector(sortBtnClick(_:)), for: .touchUpInside)
            view.addSubview(btn)
        }
        
//        2、设置popover的尺寸
        preferredContentSize = CGSize(width: w + 2*edgeMargin, height: rowMargin + (rowMargin+h)*CGFloat(sortArr.count))
        
    }
}

//MARK:- 加载数据
extension JGSortVC{
    fileprivate func loadRegionData(){
        //        1、获取plist文件路径
        let plistPath = Bundle.main.path(forResource: "sorts.plist", ofType: nil)!
        
        //        2、根据路径加载数据
        guard let dataArray = NSArray(contentsOfFile: plistPath) as? [[String:Any]] else{return}    //swift中Array没有contentsOfFile方法，所以用NSArray，然后再转化为swift中的数组
        
        //        3、遍历字典数组 转为模型，保存到模型数组中
        for dict in dataArray{
            sortArr.append(JGSortModel(dict: dict))
        }
    }
}

//MARK:- 点击按钮
extension JGSortVC{
    @objc fileprivate func sortBtnClick(_ btn:UIButton){
        // 交换
        selectBtn?.isSelected = false
        btn.isSelected = true
        selectBtn = btn
        
        // 回调，传值
        if let callBack = sortBlock{
            callBack((sortArr[btn.tag].label))
        }
    }
}

