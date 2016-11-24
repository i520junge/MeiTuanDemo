//
//  LRTableView.swift
//  美团
//
//  Created by xmg5 on 2016/11/23.
//  Copyright © 2016年 Seemygo. All rights reserved.
//

import UIKit

private let kLeftCellID = "kLeftCellID"
private let kRightCellID = "kRightCellID"

@objc protocol LRTableViewDataSource : class {
    func numberOfLeftRowsInLrTableView(_ lrTableView : LRTableView) -> Int
    func lrTableView(_ lrTableView : LRTableView, leftTitleIn leftRow : Int) -> String
    func lrTableView(_ lrTableView : LRTableView, subdataIn leftRow : Int) -> [String]?
    
    @objc optional func lrTableView(_ lrTableView : LRTableView, iconNameIn leftRow : Int) -> String
    @objc optional func lrTableView(_ lrTableView : LRTableView, highIconNameIn leftRow : Int) -> String
}


@objc protocol LRTableViewDelegate : class {
    @objc optional func lrTableView(_ lrTableView : LRTableView, didSelected leftRow : Int)
    @objc optional func lrTableView(_ lrTableView : LRTableView, leftRow : Int ,didSelected rightRow : Int)
}

class LRTableView: UIView {
    
    // MARK: 对外暴露属性
    weak var dataSource : LRTableViewDataSource?
    weak var delegate : LRTableViewDelegate?
    
    fileprivate var subdata : [String]?
    fileprivate var leftRow : Int = 0
    
    // MARK: 控件属性
    @IBOutlet weak var leftTableView: UITableView!
    @IBOutlet weak var rightTableView: UITableView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        leftTableView.register(LeftViewCell.self, forCellReuseIdentifier: kLeftCellID)
        rightTableView.register(RightViewCell.self, forCellReuseIdentifier: kRightCellID)
        
        let name = test
        name(20, 30)
    }
    
    
    func test(a : Int, b : Int) {
        
    }
    
}


extension LRTableView {
    class func loadLrTableView() -> LRTableView {
        return Bundle.main.loadNibNamed("LRTableView", owner: nil, options: nil)?.first as! LRTableView
    }
}


// MARK:- 实现UITableView的数据源&代理方法
extension LRTableView : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == leftTableView {
            return dataSource?.numberOfLeftRowsInLrTableView(self) ?? 0
        } else {
            return subdata?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell : UITableViewCell!
        
        if tableView == leftTableView {
            cell = tableView.dequeueReusableCell(withIdentifier: kLeftCellID, for: indexPath)
            
            cell.textLabel?.text = dataSource?.lrTableView(self, leftTitleIn: indexPath.row)
            
            if let iconName = dataSource?.lrTableView?(self, iconNameIn: indexPath.row) {
                cell.imageView?.image = UIImage(named: iconName)
            }
            
            if let highIconName = dataSource?.lrTableView?(self, highIconNameIn: indexPath.row) {
                cell.imageView?.highlightedImage = UIImage(named: highIconName)
            }
            
            /*
            if let data = dataSource {
                if let funcName = data.abclrTableView {
                    let iconName = funcName(self, indexPath.row)
                    cell.imageView?.image = UIImage(named: iconName)
                }
            }
            */
            
        } else {
            cell = tableView.dequeueReusableCell(withIdentifier: kRightCellID, for: indexPath)
            cell.textLabel?.text = subdata![indexPath.row]
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == leftTableView {
            // 0.记录左边选中下标值
            leftRow = indexPath.row
            
            // 1.问数据源要所有的子数据
            subdata = dataSource?.lrTableView(self, subdataIn: indexPath.row)
            
            // 2.刷新右边的表格
            rightTableView.reloadData()
            
            // 3.通知代理
            delegate?.lrTableView?(self, didSelected: indexPath.row)
        } else {
            delegate?.lrTableView?(self, leftRow: leftRow, didSelected: indexPath.row)
        }
    }
}
