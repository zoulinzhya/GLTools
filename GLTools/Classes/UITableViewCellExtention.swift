//
//  UITableViewCellExtention.swift
//  SwiftLearn
//
//  Created by zoulin on 2017/6/30.
//  Copyright © 2017年 zoulin. All rights reserved.
//

import Foundation
import UIKit


extension UITableViewCell {
    //返回cell所在的UITableView
    func superTableView() -> UITableView? {
        for view in sequence(first: self.superview, next: { $0?.superview }) {
            if let tableView = view as? UITableView {
                return tableView
            }
        }
        return nil
    }
}


//UITableViewCell 里面获取UITableView 和indexPath
/*
//单元格类
class MyTableCell: UITableViewCell {
    
    var button:UIButton!
    
    //初始化
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        button = UIButton(frame:CGRect(x:0, y:0, width:40, height:25))
        button.setTitle("点击", for:.normal) //普通状态下的文字
        button.backgroundColor = UIColor.orange
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        //按钮点击
        button.addTarget(self, action:#selector(tapped(_:)), for:.touchUpInside)
        self.addSubview(button)
    }
    
    //布局
    override func layoutSubviews() {
        super.layoutSubviews()
        button.center = CGPoint(x: bounds.size.width - 35, y: bounds.midY)
    }
    
    //按钮点击事件响应
    func tapped(_ button:UIButton){
        let tableView = superTableView()
        let indexPath = tableView?.indexPath(for: self)
        print("indexPath：\(indexPath!)")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}*/


//获取任意类型的父View

extension UIView {
    //返回该view所在的父view
    func superView<T: UIView>(of: T.Type) -> T? {
        for view in sequence(first: self.superview, next: { $0?.superview }) {
            if let father = view as? T {
                return father
            }
        }
        return nil
    }
}
/*
使用样例
这里对上面样例代码做个修改，之前我们在单元格中这么得到该 cell 所在的 tableView：
1
let tableView = superTableView()
现在改成这样：
1
let tableView = superView(of: UITableView.self)
*/

//MARK: - Swift - 在单元格里的按钮点击事件中获取对应的cell以及indexPath
/*
class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    //总数
    var sum = 0
    
    override func loadView() {
        super.loadView()
        
        self.title = "总数：\(sum)"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.allowsSelection = false
    }
    
    
    //返回表格行数（也就是返回控件数）
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    //创建各单元显示内容(创建参数indexPath指定的单元）
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
        -> UITableViewCell {
            //创建一个重用的单元格
            let cell = tableView
                .dequeueReusableCell(withIdentifier: "tableCell", for: indexPath)
            let label = cell.viewWithTag(1) as! UILabel
            label.text = "\(indexPath.row)"
            return cell
    }
    
    //单元格中的按钮点击
    @IBAction func tapAddButton(_ sender: AnyObject) {
        let btn = sender as! UIButton
        let cell = superUITableViewCell(of: btn)!
        let label = cell.viewWithTag(1) as! UILabel
        sum = sum + (label.text! as NSString).integerValue
        self.title = "总数：\(sum)"
    }
    
    //返回button所在的UITableViewCell
    func superUITableViewCell(of: UIButton) -> UITableViewCell? {
        for view in sequence(first: of.superview, next: { $0?.superview }) {
            if let cell = view as? UITableViewCell {
                return cell
            }
        }
        return nil
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}*/

/*
2，功能改进
（1）我们可以通过扩展 UIView，让我们可以获得任意视图对象（View）所在的指定类型的父视图。
extension UIView {
    //返回该view所在的父view
    func superView<T: UIView>(of: T.Type) -> T? {
        for view in sequence(first: self.superview, next: { $0?.superview }) {
            if let father = view as? T {
                return father
            }
        }
        return nil
    }
}

（2）在 button 点击事件中可以这么获取到对应的 cell：
//单元格中的按钮点击
@IBAction func tapAddButton(_ sender: AnyObject) {
    let btn = sender as! UIButton
    let cell = btn.superView(of: UITableViewCell.self)!
    let label = cell.viewWithTag(1) as! UILabel
    sum = sum + (label.text! as NSString).integerValue
    self.title = "总数：\(sum)"
}

3，在点击事件中获取对应的indexPath
获取到 cell 后，通过 tableView 的 indexPath(for:) 方法即可得到对应的 indexPath。

//单元格中的按钮点击
@IBAction func tapAddButton(_ sender: AnyObject) {
    let btn = sender as! UIButton
    let cell = btn.superView(of: UITableViewCell.self)!
    let indexPath = tableView.indexPath(for: cell)
    print("indexPath：\(indexPath!)")
}*/



