//
//  Methods.swift
//  SwiftLeaningKit
//
//  Created by performance on 2021/5/13.
//  Copyright © 2021 SwiftLeaning. All rights reserved.
//

import Foundation

struct MethodsTest: Runable {
    static func run() {
        
    }
    
    // 方法是与特定类型相关联的函数。Swift可以为类、结构体、枚举定义方法，Objective-C 只能给类定义方法。
    // 1. 实例方法（Instance Methods）: 为给定类型的实例相关联。 相当于 Objective-C 中的实例方法（instance methods）。
    // 2. 类型方法（Type Methods）: 与类型本身相关联。相当于 Objective-C 中的类方法（class methods）。
    
    /// 实例方法，定义和函数完全一样，只是定义在特定类型内部，即定义的函数与某个类型相关联了。
    static func instanceMethodsTest() {
        class Counter {
            var count = 0
            func increment() {
                count += 1
            }
            func increment(by amount: Int) {
                count += amount
            }
        }
        // 通过点语法调用
        let counter = Counter()
        counter.increment()
        counter.increment(by: 10)
    }
    
    /// 类型方法，定义和函数完全一样，只是定义在特定类型内部，即定义的函数与某个类型相关联了。
    static func typeMethodsTest() {
        struct SomeClass {
           static func increment() {
                
           }
        }
        // 通过点语法调用
    }
    
    // self属性
    static func selfTest() {
        // 类型的每一个实例都有一个隐含属性叫做 self，self 完全等同于该实例本身
        class Counter {
            var count = 0
            init(count: Int) {
                self.count = count // 消除歧义，因为参数和属性同名
            }
            func increment(by amount: Int) {
                count += amount
            }
            func increment() {
                self.increment(by: 1) // 通过self显示调用increment(by:)方法
                // 不必在代码里面经常写 self，在一个方法中使用一个已知的属性或者方法名称，即使没有明确地写 self，Swift 假定使用当前实例的属性或者方法。
                increment(by: 0)
            }
        }
    }
    
}
