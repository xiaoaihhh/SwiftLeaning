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
//public class ARCTest: Runable {
//    public static func run() {
//
//
//
//
//        let personal = Personal()
//        personal.closure()
//    }
//}

struct ARCTest: Runable {
    static func run() {
        print("\n\n=================== ARC ====================")
    }
    
    ///  循环引用原理同 Objective C 一样，这里不在介绍原理，Swift 提供了两种办法用来解决循环强引用问题：
    ///  1. 弱引用（weak reference）, 自动被设置为 nil。
    ///  2. 无主引用（unowned reference），不会自动被设置为 nil。
    
    
    /// 弱引用，声明属性或者变量时，在前面加上 weak 关键字表明这是一个弱引用
    static func weakReferenceCycles() {
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
    
    
    /// 闭包循环引用
    ///
    static func resolvingStrongReferenceCyclesForClosures() {
        
    }
}



class Personal {
    let name = "xiaoming"
    var obj: NSObject?
    // 可以直接 [weak/unowned self], 也可以定义一个新的变量名字 [weak/unowned self0 = self]
    lazy var closure = { [weak self, unowned self0 = self] in
        let name = self?.name
        let obj = self0.name
    }
    
    deinit {
        print("Personal is being deinitialized")
    }
}



