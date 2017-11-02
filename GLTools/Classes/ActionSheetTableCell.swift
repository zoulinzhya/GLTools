//
//  ActionSheetTableCell.swift
//  GLTDemo
//
//  Created by zoulin on 2017/10/27.
//  Copyright © 2017年 zoulin. All rights reserved.
//

import UIKit
import SnapKit

enum ActionSheetBtnType : Int {
    case actionSheetBtn_unknown = -1        //未知按钮类型
    case actionSheetBtn_title   = 0         //标题按钮
    case actionSheetBtn_content = 1         //内容按钮
    case actionSheetBtn_cancel  = 2         //取消按钮
}

struct ActionSheetButton {
    var btnType:ActionSheetBtnType
    var title : String?
    var titleFont: UIFont?
    var titleColor: UIColor?
    var index:Int = -1
    var isHaveBtnSelectStyle:Bool = true
    
    
    init(with title:String, buttonType:ActionSheetBtnType = .actionSheetBtn_content,
         titleFont:UIFont = UIFont.boldSystemFont(ofSize: 17),
         titleColor:UIColor = UIColor.darkGray) {
         self.btnType = buttonType
         self.title = title
         self.titleFont = titleFont
         self.titleColor = titleColor
    }
}


class ActionSheetTableCell: UITableViewCell {
    
    static let identifier = "ActionSheetTableCeller"
    
    internal var contentlabel = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.configContentLabel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func configContentLabel() {
        self.contentView.backgroundColor = UIColor.white
        self.contentView.addSubview(contentlabel)
        contentlabel.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.backgroundColor = UIColor.clear
        contentlabel.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
    }
    
   func updateActionSheetButton(button:ActionSheetButton) {
        contentlabel.font = button.titleFont
        contentlabel.textColor = button.titleColor
        contentlabel.text = button.title
        
        self.selectionStyle = button.btnType == .actionSheetBtn_cancel || button.isHaveBtnSelectStyle == false ? .none : .default
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
