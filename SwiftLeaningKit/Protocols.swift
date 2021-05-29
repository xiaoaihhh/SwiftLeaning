//
//  Protocols.swift
//  SwiftLeaningKit
//
//  Created by fanshuaifei on 2020/7/25.
//  Copyright © 2020 SwiftLeaning. All rights reserved.
//

import Foundation
import UIKit


struct ProtocolsTest: Runable {
    static func run() {
        print("\n\n=================== Protocols ====================")
        protocolSyntaxTest()
        
        
    }
    /// 协议定义
    static func protocolSyntaxTest() {
        print("\n-----------------协议：协议定义----------------")
        // 使用关键词 protocol 定义
        // protocol SomeProtocol { }
        
        // 结构体、枚举、类遵循某个协议，在类型名称后加上协议名称，中间以冒号（:）分隔。遵循多个协议时，各协议之间用逗号分隔
        // struct SomeStructure: FirstProtocol, AnotherProtocol { }
        
        // 若是一个类遵守协议，并且拥有父类，应该将父类名放在遵循的协议名之前，以逗号分隔：
        // class SomeClass: SomeSuperClass, FirstProtocol, AnotherProtocol { }
    }
    
    static func propertyRequirementsTest() {
        print("\n-----------------协议：属性定义和遵守----------------")
        class SomeClass: SomeProtocolForProperty {
            /// 遵守协议，可读可写
            var name: String =  "defaultName"
            /// 遵守协议，因为是只读的，因此可以实现为只读的计算属性
            var description: String {
                "Name is " + name
            }
            /// 遵守协议，因为是只读的，尽管协议使用 var 声明属性，但是实现的类型仍可以使用 let
            let max = 1000
            // 遵守协议，因为是只读的，因此可以实现为只读的存储属性
            private(set) var min: Int = 0
            // 遵守协议，类型属性
            static var count: Int = 10
            // 遵守协议，类型计算属性可以使用 class 修饰
            class var total: Int {
                get { count }
                set { count = newValue }
            }
        }
    }
    
    static func methodRequirementsTest() {
        print("\n-----------------协议：方法定义和遵守----------------")
        struct SomeStruct: SomeProtocolForMethod {
            func printName() { }
            static func maxCount() -> Int  { Int.max }
            mutating func changeSelf() { // 这里是结构体 && 修改了 self，因此实现协议时必须使用 mutating 修饰
                self = SomeStruct()
            }
        }
    }
}

/// 协议中定义属性
protocol SomeProtocolForProperty {
    /// 1. 协议可以要求遵循协议的类型提供特定名称和类型的实例属性或类型属性，协议不指定属性是存储属性还是计算属性，它只指定属性的名称和类型，以及属性是只读的还是可读可写的。
    /// 2. 协议定义属性必须使用 var ，必修跟上 { set get } 标明是可读可写的，或者 { get } 是只读的；
    /// 3. 如果协议要求属性是可读可写的，那么实现协议的类型的属性必须是可读可写的；如果协议要求是只读的，则实现可以是只读的（只读计算属性、常量、只读存储属性都可以），也可是可读可写的（计算属性、可读可写的存储属性）；
    // 4. 在协议中定义类型属性时，总是使用 static 关键字修饰。如果是类类型遵循协议时，除了 static 关键字，还可以使用 class 关键字来声明类型属性。
    var name: String { set get }
    var description: String { get }
    var max: Int { get }
    var min: Int { get }
    static var count: Int { set get }
    static var total: Int { set get }
}

/// 协议中定义方法
protocol SomeProtocolForMethod {
    // 直接将方法声明定义在协议中即可；
    func printName()
    // 如果是类型方法使用 static 修饰，其他特点和属性部分讲解一样
    static func maxCount() -> Int
    // 1. 如果是异变方法则使用 mutating 修饰
    // 2. 实现协议中的 mutating 方法时，如果是类类型，则不用写 mutating 修饰词；对于结构体和枚举，如果实现方法中修改了 self 或者 self 的属性则必须写 mutating 关键字，否则也可以省略。
    // 3. 如果协议中没使用 mutating 修饰为异变方法，则实现协议时候在该方法前加上 mutating 修饰，则编译器认为没有实现该方法，无法编译通过
    mutating func changeSelf()
}

