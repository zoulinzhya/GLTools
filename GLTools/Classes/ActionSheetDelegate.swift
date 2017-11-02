//
//  ActionSheetDelegate.swift
//  GLTDemo
//
//  Created by zoulin on 2017/10/27.
//  Copyright © 2017年 zoulin. All rights reserved.
//

import Foundation

protocol GActionSheetDelegate : class {
    func actionSheet(_ actionSheet: ActionSheetViewController, clickedButton button: ActionSheetButton)
}
