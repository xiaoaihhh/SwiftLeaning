//
//  Extensions.swift
//  SwiftLeaningKit
//
//  Created by fanshuaifei on 2020/7/26.
//  Copyright © 2020 SwiftLeaning. All rights reserved.
//

import Foundation
import UIKit

public struct ExtensionsTest: Runable {
    public static func run() {
        let d = 10.0
        print("\(d.km), \(d.description)")
        
        let show = Show()
        print("\(show.shouldShow()), \(show.show), \(show[10])")
    }
}

extension Double {
    var km: Double {
        self * 1_000
    }
    var m: Double {
        self
    }
    var cm: Double {
        self / 100.0
    }
}


// 通过扩展添加的实例方法同样也可以修改（或 mutating（改变））实例本身。
extension Int {
    mutating func square() {
        self = self * self
    }
    
    // 扩展可以给现有的类型添加新的下标
    subscript(index: Int) -> Int {
        var decimalBase = 1
        for _ in 0..<index {
            decimalBase *= 10
        }
        return (self / decimalBase) % 10
    }
    
    //扩展可以给现有的类，结构体，还有枚举添加新的嵌套类型
    enum Kind {
        case negative
        case zero
        case positive
    }
    var kind: Kind {
        switch self {
        case 0:
            return .zero
        case let x where x > 0:
            return .positive
        default:
            return .negative
        }
    }
}

struct Show: Showable {
    
}

protocol Showable {
    var show: Bool { get }
    func shouldShow() -> Bool
}

extension Showable {
    var show: Bool {
        false
    }
    func shouldShow() -> Bool {
        false
    }
    subscript(index: Int) -> Bool {
        false
    }
}
