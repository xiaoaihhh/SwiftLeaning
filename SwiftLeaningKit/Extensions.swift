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
        print("\n\n=================== Extensions ====================")
        computedPropertiesTest()
        initializersTest()
        methodTest()
        subscriptsTest()
        nestedTypesTest()
    }
    // 扩展可以给一个现有的类、结构体、枚举、协议添加新的功能，不需要访问被扩展类型源代码就能完成扩展（即逆向建模）。扩展和 Objective-C 的分类很相似。（与 Objective-C 分类不同的是，Swift 扩展是没有名字的。）
    // 1. 添加计算型实例属性和计算型类属性
    // 2. 定义实例方法和类方法
    // 3. 提供新的构造器
    // 4. 定义下标
    // 5. 定义和使用新的嵌套类型
    // 6. 使已经存在的类型遵循（conform）一个协议
    // 7. 扩展只能直接定义在文件作用域中，不能嵌套定义在结构体、函数等中
    // 8. 扩展不能覆盖原有功能、不能添加 deinit、不能添加属性观察器和存储属性、
    
    
    static func computedPropertiesTest() {
        var distance = 10.5.km + 100.m + 1000.5.cm
        print("\(distance), \(distance.description)")
        distance.absoulateValue = 100.99
        print("\(distance), \(distance.description)")
    }
    
    static func initializersTest() {
        
    }
    
    static func methodTest() {
        3.repetitions { print($0) }
        print(Int.add(num1: 10, num2: 10))
        var two = 2
        print(two.square())
    }
    
    static func subscriptsTest() {
        print(12345[4])
    }
    
    static func nestedTypesTest() {
        for number in [1, 6, 10, -1, 0] {
            switch number.kind {
            case .negative:
                print("- ", terminator: "")
            case .zero:
                print("0 ", terminator: "")
            case .positive:
                print("+ ", terminator: "")
            }
        }
    }
}


/// 扩展计算属性
/// 扩展可以添加新的计算属性，但是它们不能添加存储属性，或向现有的属性添加属性观察者。
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
    var absoulateValue: Double {
        get {
            self
        }
        set {
            self = newValue
        }
    }
}


/// TODO
/// 构造器
extension Int {
    init(maxValue: Int) {
        self.init()
    }
}

/// 扩展方法
/// 扩展可以给现有类型添加新的实例方法和类方法
extension Int {
    // 扩展实例方法
    func repetitions(task: (Int) -> ()) {
        for _ in 0..<self {
            task(self)
        }
    }
    
    /// 扩展类型方法
    static func add(num1: Int, num2: Int) -> Int {
        num1 + num2
    }
    
    /// 对于结构体和枚举(mutating 不可用于类)，添加扩展可变方法，使用 mutating 修饰，可以修改自身或者存储属性
    mutating func square() {
        self = self * self
    }
}

/// 扩展下标
/// 扩展可以给现有的类型添加新的下标
extension Int {
    subscript(digitIndex: Int) -> Int {
        var decimalBase = 1
        for _ in 0..<digitIndex {
            decimalBase *= 10
        }
        return (self / decimalBase) % 10
    }
}

/// 扩展可以给现有的类，结构体，还有枚举添加新的嵌套类型
extension Int {
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


class SomeClassForExtension {
    func test() {
    }
}

extension SomeClassForExtension {
    // func test() { } // 编译报错，不能覆盖原有功能
    // deinit { } // 编译报错 Deinitializers may only be declared within a class
}


