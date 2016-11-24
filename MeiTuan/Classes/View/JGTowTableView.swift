//
//  JGTowTableView.swift
//  MeiTuan
//
//  Created by 刘军 on 2016/11/24.
//  Copyright © 2016年 刘军. All rights reserved.
//

import UIKit
fileprivate let leftCellID = "leftCellID"
fileprivate let rightCellID = "rightCellID"

//MARK:- 提供数据源协议
@objc protocol JGTowTableViewDataSource:class{
    /// 这组有几行
    func towTableView(_ tableView:JGTowTableView,numberOfRowsInSection section:Int) -> Int
    /// 左边第leftRow行，展示什么数据
    func towTableView(_ tableView:JGTowTableView,leftTitleInfo leftRow:Int) -> String
    /// 左边第leftRow行的子类，展示什么数据
    func towTableView(_ tableView:JGTowTableView,subTitleInfo leftRow:Int) -> [String]
    
    /// 可选方法：左边第leftRow行展示的图标
    @objc optional func towTableView(_ tableView:JGTowTableView,leftIconName leftRow:Int)->String
    /// 可选方法：左边第leftRow行展示的高亮图标
    @objc optional func towTableView(_ tableView:JGTowTableView,leftHighIconName leftRow:Int) -> String
}

//MARK:- 代理方法
@objc protocol JGTowTableViewDelegate:class{
    /// 选择了左边哪行
    @objc optional func towTableView(_ tableView:JGTowTableView,didSelectedLeftRow:Int)
    /// 选择了左边那行子类中的第几行
    @objc optional func towTableView(_ tableView:JGTowTableView,leftRow:Int,didSelectedRightRow:Int)
}


class JGTowTableView: UIView {
//MARK:- 控件属性
    @IBOutlet weak var leftTableView: UITableView!
    @IBOutlet weak var rightTableView: UITableView!
    
//MARK:- 数据源、代理属性
    weak var dataSource:JGTowTableViewDataSource?
    weak var delegate:JGTowTableViewDelegate?
    
//MARK:- 数据属性
    fileprivate var subdata:[String] = []
    fileprivate var leftRow:Int = 0     //记录选择了左边第几行
    
}

//MARK:- 提供类方法给外界创建对象
extension JGTowTableView{
    class func towTableView()->JGTowTableView{
        return Bundle.main.loadNibNamed("JGTowTableView", owner: nil, options: nil)?.first as! JGTowTableView
    }
}

//MARK:- 初始化操作
extension JGTowTableView{
    override func awakeFromNib() {
        super.awakeFromNib()
        leftTableView.dataSource = self
        leftTableView.delegate = self
        rightTableView.dataSource = self
        rightTableView.delegate = self
        
        //注册cell
        leftTableView.register(JGLeftCell.self, forCellReuseIdentifier: leftCellID)
        rightTableView.register(JGRightCell.self, forCellReuseIdentifier: rightCellID)
        
    }
}

//MARK:- TableView数据源
extension JGTowTableView:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == leftTableView {
            return dataSource?.towTableView(self, numberOfRowsInSection: section) ?? 0
        }else {
            return subdata.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:UITableViewCell!   //用非可选，因为return不能返回一个可选类型
        
        if tableView == leftTableView {
            cell = tableView.dequeueReusableCell(withIdentifier: leftCellID, for: indexPath)
            
            //给cell设置数据
            cell.textLabel?.text = dataSource?.towTableView(self, leftTitleInfo: indexPath.row)
            
            // 如果外界实现了可选协议方法，则给cell设置小图标
            if let iconName = dataSource?.towTableView?(self, leftIconName: indexPath.row) {cell.imageView?.image = UIImage(named: iconName)}
            if let highIconName = dataSource?.towTableView?(self, leftHighIconName: indexPath.row) {
                cell.imageView?.highlightedImage = UIImage(named: highIconName)
            }
            
        }
        else{
            cell = tableView.dequeueReusableCell(withIdentifier: rightCellID, for: indexPath)
            cell.textLabel?.text = subdata[indexPath.row]
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == leftTableView {
            // 记录下选择了左边那行时 是左边第几行，好等选择右边时可以拿到右边选择这个是归属于左边的第几行的数据
            leftRow = indexPath.row
//            1、取出选中分类的数据
//            let categoryModel = dataSource[indexPath.row]
            
//            2、获取分类对应的子类别数据
             subdata = dataSource?.towTableView(self, subTitleInfo: indexPath.row) ?? []
            
//            3、更新右边tabbleView
            rightTableView.reloadData()
            
//            4、告诉外界选择了左边第几行
            delegate?.towTableView?(self, didSelectedLeftRow: indexPath.row)
            
        }else{  //点击了右边
            delegate?.towTableView?(self, leftRow: leftRow, didSelectedRightRow: indexPath.row)
        }
    }
    
}
