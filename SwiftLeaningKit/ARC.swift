//
//  ARC.swift
//  SwiftLeaningKit
//
//  Created by fanshuaifei on 2020/7/25.
//  Copyright © 2020 SwiftLeaning. All rights reserved.
//

import Foundation

// Swift 通过 ARC 管理内存，和 Objective C 一样，这里不在介绍 ARC 原理。

/// 1. 引用计数仅仅应用于类的实例。结构体和枚举类型是值类型，不是引用类型，也不是通过引用的方式存储和传递
/// 2. ARC 会在引用的实例被销毁后自动将其弱引用赋值为 nil。并且因为弱引用需要在运行时允许被赋值为 nil，因此只能被定义为可选类型变量。
/// 3. 当 ARC 设置弱引用为 nil 时，属性观察不会被触发，如果是自己设置为 nil 会触发属性观察器。
/// 4. 无主引用通常都被期望拥有值。ARC 不会在实例被销毁后将无主引用设为 nil，无主引用在其它实例有相同或者更长的生命周期时使用。可以定义成常量，或者变量，或者可选类型。
/// 5. 使用无主引用，必须确保引用始终指向一个未销毁的实例。如果试图在实例被销毁后访问该实例的无主引用，会触发运行时错误。

struct ARCTest: Runable {
    static func run() {
        print("\n\n=================== ARC ====================")
        weakReferenceCycles()
        unownedOptionalReferences()
        resolvingStrongReferenceCyclesForClosures()
    }
    
    ///  循环引用原理同 Objective C 一样，这里不在介绍原理，Swift 提供了两种办法用来解决循环强引用问题：
    ///  1. 弱引用（weak reference）, 自动被设置为 nil。
    ///  2. 无主引用（unowned reference），不会自动被设置为 nil。
    
    
    /// 弱引用，声明属性或者变量时，在前面加上 weak 关键字表明这是一个弱引用
    static func weakReferenceCycles() {
        print("\n-----------------ARC：弱引用测试----------------")
        class Person {
            let name: String
            init(name: String) {
                self.name = name
            }
            var apartment: Apartment?
            deinit { print("\(name) is being deinitialized") }
        }

        class Apartment {
            let unit: String
            init(unit: String) { self.unit = unit }
            // weak 表明是弱引用，因为弱引用需要在运行时允许被赋值为 nil，因此只能被定义为可选类型变量
            weak var tenant: Person? {
                didSet {
                    // 当 ARC 设置弱引用为 nil 时，属性观察不会被触发，如果是自己设置为 nil 会触发属性观察器。
                    print("tenant didset \(String(describing: tenant))")
                }
            }
            deinit {
                print("Apartment \(unit) is being deinitialized")
            }
        }
        
        let person = Person(name: "lily")
        let apart = Apartment(unit: "M1")
        // person 和 apart 互相持有，但是 apart 弱持有 person，不会导致循环引用。
        person.apartment = apart
        apart.tenant = person
        apart.tenant = nil
    }
    
    
    /// 无主引用，声明属性或者变量时，在前面加上 unowned 关键字表明这是一个无主引用
    static func unownedOptionalReferences() {
        print("\n-----------------ARC：无主引用测试----------------")
        class Customer {
            let name: String
            var card: CreditCard?
            init(name: String) {
                self.name = name
            }
            deinit { print("\(name) is being deinitialized") }
        }

        class CreditCard {
            let number: UInt64
            // unowned 表明是无主引用，因为弱引用需要在运行时允许被赋值为 nil，因此只能被定义为可选类型变量
            unowned let customer: Customer?
            init(number: UInt64, customer: Customer) {
                self.number = number
                self.customer = customer
            }
            deinit {
                print("Card #\(number) is being deinitialized")
            }
        }
        var john: Customer! = Customer(name: "John Appleseed")
        john.card = CreditCard(number: 1234_5678_9012_3456, customer: john)
        john = nil
    }
    
    
    /// 闭包循环引用，和 Objective C 的 block 导致循环引用原理类似
    /// 在定义闭包时同时定义捕获列表作为闭包的一部分，通过这种方式可以解决闭包和类实例之间的循环强引用。捕获列表定义了闭包体内捕获一个或者多个引用类型的规则，跟解决两个类实例间的循环强引用一样，声明每个捕获的引用为弱引用或无主引用，而不是强引用。
    static func resolvingStrongReferenceCyclesForClosures() {
        print("\n-----------------ARC：闭包循环引用测试----------------")
        class Person {
            let name = "lily"
            /// 捕获列表中的每一项都由一对元素组成，一个元素是 weak 或 unowned 关键字，另一个元素是类实例的引用（例如 self）或初始化过的变量（如 delegate = self.delegate），不同的元素在方括号中用逗号分开。
            /// 可以直接 [weak/unowned self], 也可以定义一个新的变量名字 [weak/unowned self0 = self]
            lazy var closure = { // 这里必须是 lazy 的，不然初始化 closure 属性时 self 还没有构造完成。如果这里闭包没有引用 self 则不需要时 lazy的，或者是可选类型的，通过外部赋值，也不需要使用 lazy 修饰。
                [weak self, unowned unownedSelf = self] in
                // 只要在闭包内使用 self 的成员，必须要加上 self，提醒闭包可能会捕获 self
                let a = self?.name // weak 修饰可能是nil，因此通过可选链或者强制解包调用
                unownedSelf.printName() // 如果被捕获的引用绝对不会变为 nil，应该用无主引用，而不是弱引用。因此 unowned 修饰的变量不需要通过可选链调用
            }
            func printName() {
                print("Person name is \(name)")
            }
            
            deinit {
                print("Person is being deinitialized")
            }
        }
        
        let person = Person()
        person.closure()
    }
}







