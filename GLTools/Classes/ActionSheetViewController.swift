//
//  ActionSheetViewController.swift
//  GLTDemo
//
//  Created by zoulin on 2017/10/27.
//  Copyright © 2017年 zoulin. All rights reserved.
//

import UIKit

class ActionSheetViewController: UIViewController {
    
    var delegate: GActionSheetDelegate?
    var bgAlpha:CGFloat = 0.35
    
    fileprivate var actionSheetButtons:[ActionSheetButton] = [ActionSheetButton]()
    fileprivate var datasource:[[ActionSheetButton]] = [[ActionSheetButton]]()
    fileprivate let screenWidth = UIScreen.main.bounds.size.width
    fileprivate let screenHeight = UIScreen.main.bounds.size.height
    fileprivate var overlayView: UIView!
    fileprivate let headerHeight: CGFloat = 5
    
    fileprivate lazy var tableView:UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.showsVerticalScrollIndicator = false
        table.showsHorizontalScrollIndicator = false
        table.isScrollEnabled = false
        table.register(ActionSheetTableCell.self, forCellReuseIdentifier: ActionSheetTableCell.identifier)
        table.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0)
        table.tableFooterView = UIView()
        return table
    }()
    
   init(buttonList:[ActionSheetButton]) {
        super.init(nibName: nil, bundle: nil)

        self.providesPresentationContextTransitionStyle = true
        self.definesPresentationContext = true
        self.modalPresentationStyle = .custom
    
        self.actionSheetButtons = buttonList
        self.configDatasource()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.configViews()
        
        NotificationCenter.default.addObserver(self, selector: #selector(deviceOrientationDidChange), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
    }
    
    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.updateContentViewFrame()
    }
    
    fileprivate func configViews() {
        overlayView = UIView(frame: self.view.bounds)
        overlayView.backgroundColor = UIColor(red:0, green:0, blue:0, alpha:bgAlpha)
        overlayView.alpha = 0
        self.view.addSubview(overlayView)
        let tap = UITapGestureRecognizer(target: self, action: #selector(overlayViewTapHandler))
        overlayView.addGestureRecognizer(tap)
        
        var frame = self.view.frame
        frame.origin.y = self.screenHeight
        self.tableView.frame = frame
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.view.addSubview(self.tableView)
    }
    
    fileprivate func updateContentViewFrame() {
        var height: CGFloat = 0
        height = CGFloat(actionSheetButtons.count) * 44
        if self.datasource.count > 1 {
            height += headerHeight
        }
        
        let frame = CGRect(x: 0, y: screenHeight - height, width: screenWidth, height: height)
        UIView.animate(withDuration: 0.2) {
            self.tableView.frame = frame
            self.overlayView.alpha = 1.0
        }
    }
    
    @objc fileprivate func overlayViewTapHandler() {
        UIView.animate(withDuration: 0.25, animations: {
            var frame = self.tableView.frame
            frame.origin.y = self.view.bounds.size.height
            self.tableView.frame = frame
            self.overlayView.backgroundColor = UIColor(red:0, green:0, blue:0, alpha:0)
        }) { _ in
            self.dismiss(animated: false, completion: nil)
        }
    }
    
    fileprivate func configDatasource() {
        if self.actionSheetButtons.count > 0 {
            var actonButtons:[ActionSheetButton] = [ActionSheetButton]()
            var cancelButton:[ActionSheetButton] = [ActionSheetButton]()
            
            for (_, actionButton) in actionSheetButtons.enumerated() {
                if (actionButton.btnType == .actionSheetBtn_cancel) {
                    cancelButton.append(actionButton)
                } else {
                    actonButtons.append(actionButton)
                }
            }
            
            self.datasource.append(actonButtons)
            self.datasource.append(cancelButton)
        }
    }
    
    @objc fileprivate func deviceOrientationDidChange() {
        let height = self.tableView.bounds.size.height
        let width = self.view.bounds.size.width
        let y = self.view.bounds.size.height - height
        let frame = CGRect(x: 0, y: y, width: width, height: height)
        UIView.animate(withDuration: 0.2) {
            self.overlayView.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi / 2));
            self.tableView.frame = frame
            self.overlayView.frame = self.view.bounds
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ActionSheetViewController : UITableViewDelegate, UITableViewDataSource {
    public func numberOfSections(in tableView: UITableView) -> Int {
        return self.datasource.count
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.datasource[section].count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let actionButton:ActionSheetButton = self.datasource[indexPath.section][indexPath.row]
        
        let cell:ActionSheetTableCell = tableView.dequeueReusableCell(withIdentifier: ActionSheetTableCell.identifier, for: indexPath) as! ActionSheetTableCell
        cell.updateActionSheetButton(button: actionButton)
    
        return cell
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return self.datasource.count == 2 && section == 1 ? headerHeight : 0.0
    }
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let reuseIdentifier = "sectionheader"
        var header = tableView.dequeueReusableHeaderFooterView(withIdentifier: reuseIdentifier)
        if (header == nil) {
            header = UITableViewHeaderFooterView(reuseIdentifier: reuseIdentifier)
            header?.contentView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.6)
        }
        return header
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectActionButton:ActionSheetButton = self.datasource[indexPath.section][indexPath.row]
        self.overlayViewTapHandler()
        self.delegate?.actionSheet(self, clickedButton: selectActionButton)
    }
}
