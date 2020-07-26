//
//  ARC.swift
//  SwiftLeaningKit
//
//  Created by fanshuaifei on 2020/7/25.
//  Copyright © 2020 SwiftLeaning. All rights reserved.
//

import Foundation


/*
 1. 引用计数仅仅应用于类的实例。结构体和枚举类型是值类型，不是引用类型，也不是通过引用的方式存储和传递
 2. ARC 会在引用的实例被销毁后自动将其弱引用赋值为 nil。并且因为弱引用需要在运行时允许被赋值为 nil，因此只能被定义为可选类型变量。
 3. 当 ARC 设置弱引用为 nil 时，属性观察不会被触发，如果是自己设置为 nil 会触发属性观察器。
 4. 无主引用通常都被期望拥有值。ARC 不会在实例被销毁后将无主引用设为 nil，无主引用在其它实例有相同或者更长的生命周期时使用。可以定义成常量，或者变量，或者可选类型。
 5. 使用无主引用，必须确保引用始终指向一个未销毁的实例。如果试图在实例被销毁后访问该实例的无主引用，会触发运行时错误。
 
 */


// weak
class Person {
    let name: String
    init(name: String) { self.name = name }
    var apartment: Apartment?
    deinit { print("\(name) is being deinitialized") }
}

class Apartment {
    let unit: String
    init(unit: String) { self.unit = unit }
    weak var tenant: Person? {
        didSet {
            //当 ARC 设置弱引用为 nil 时，属性观察不会被触发，如果是自己设置为 nil 会触发属性观察器。
            print("tenant didset \(String(describing: tenant))")
        }
    }
    deinit {
        print("Apartment \(unit) is being deinitialized")
    }
}


// unowned
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
    unowned let customer: Customer?
    init(number: UInt64, customer: Customer) {
        self.number = number
        self.customer = customer
    }
    deinit {
        print("Card #\(number) is being deinitialized")
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

public class ARCTest: Runable {
    public static func run() {
        let p = Person(name: "xiaoming")
        let apart = Apartment(unit: "M")
        p.apartment = apart
        apart.tenant = p
//        apart.tenant = nil
        
        var john: Customer! = Customer(name: "John Appleseed")
        john.card = CreditCard(number: 1234_5678_9012_3456, customer: john)
        john = nil
        
        let personal = Personal()
        personal.closure()
    }
}



