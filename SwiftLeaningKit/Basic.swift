//
//  Basic.swift
//  SwiftLeaningKit
//
//  Created by fanshuaifei on 2021/5/10.
//  Copyright © 2021 SwiftLeaning. All rights reserved.
//

import Foundation

struct BasicTest: Runable {
    static func run() {
        if #available(iOS 10, *) {
            // 处理高于和等于 iOS10 的系统
        } else {
            // 处理低于 iOS10 的系统
        }
    }
}
