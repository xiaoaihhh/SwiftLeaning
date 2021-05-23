//
//  OptionalChaining.swift
//  SwiftLeaningKit
//
//  Created by fanshuaifei on 2021/5/23.
//  Copyright © 2021 SwiftLeaning. All rights reserved.
//

import Foundation

struct OptionalChainingTest: Runable {
    static func run() {
        print("\n\n=================== 可选链 ====================")
        optionalChainingTest()
        accessingSubscriptsThroughOptionalChaining()
        linkingMultipleLevelsOfChaining()
    }
    
    /// 可选链式调用是一种在当前值可能为 nil 的可选值上调用属性、方法及下标。
    /// 1. 如果可选值有值，那么调用就会成功，返回值被包装成一个可选值（如果原来返回值不是可选值，则包装成可选值；如果原来返回值本身就是可选值，则不会再次包装）
    /// 2. 如果可选值是 nil，那么调用会失败，并返回 nil；
    /// 3. 多个调用可以连接在一起形成一个调用链，如果其中任何一个节点为 nil，整个调用链都会失败，即返回 nil；
    
    
    /// 可选链测试
    /// 通过在调用的属性、方法、下标的可选值后面放一个问号（?），定义一个可选链。类似在可选值后面放一个叹号（!）来强制解包，主要区别在于当可选值为空时可选链式调用只会调用失败，而强制解包将会触发运行时错误。
    static func optionalChainingTest() {
        struct Room {
            let name: String
            var address: String?
            init(name: String) {
                self.address = nil
                self.name = name
            }
            func printNumberOfRooms() {
                print("The name of room is \(name)")
            }
        }
        
        struct Person {
            var room: Room?
        }
        
        var person = Person()
        
        // 可选链式调用可以在空值（nil）上调用，不论这个调用的属性、方法及下标返回的值是不是可选值，可选链式调用总是返回一个可选值。
        let roomName = person.room?.name // room 是一个可选值，通过在后面跟一个 ？ 来进行链式调用，如果调用失败则返回 nil，如果调用成功，则 name 被包装成一个可选值，即 String?。也可以对 room 进行强制解包进行调用 person.room!.name，但是如果强制解包失败则导致运行时错误。
        
        if let name = roomName {
            print("the person has a room \(name)")
        } else {
            print("the person has not a room")
        }
        
        // 可以通过可选链式调用来调用方法，如果方法有返回值，则将返回值包装成可选值；如果方法没有返回值，因为方法具有隐式的返回类型 Void，即空元组 ()，则被包装成 Void?，即 ()?。
        if person.room?.printNumberOfRooms() != nil { // 这里如果调用失败返回 nil， 调用成功返回 Void?，因此根据返回是否是 nil 来判断调用是否成功。不能总是根据方法返回是否是 nil 来判断方法是否调用成功，因为如果方法本身就返回一个可选类型，及时方法调用成功，也可能返回 nil。
            print("printNumberOfRooms called sucess")
        } else {
            print("printNumberOfRooms called failure")
        }
        
        /// 如果可选链中间某一步失败，则立即终止调用流程
        
        // 下面的闭包没有被执行，因为 person.room 调用失败
        person.room?.address = {
            print("this closure called")
            return "1号"
        }()
        // printNumberOfRooms 函数中的打印 log 没有输出，说明 printNumberOfRooms 没被调用，因为 person.room 调用失败
        person.room?.printNumberOfRooms()
    }
    
    /// 通过可选链式调用访问下标
    /// 通过可选链式调用，可以在一个可选值上访问下标，并且判断下标是否调用成功。
    static func accessingSubscriptsThroughOptionalChaining() {
        let dic:[String: [Int]] = ["first": [1, 2], "second": [3, 4]]
        // 通过可选链式调用访问可选值的下标时，应将问号放在下标方括号的前面而不是后面。可选链式调用的问号一般直接跟在可选表达式的后面。
        
        // 字典总是返回一个可选类型，因为不知道是否能获取到 key 值对应的 value 值
        if let value = dic["first"]?[0] {
            print(value)
        } else {
            print("first failure")
        }
        if let value = dic["third"]?[1] {
            print(value)
        } else {
            print("second failure")
        }
    }
    
    
    /// 连接多层可选链式调用
    /// 可以通过连接多个可选链式调用在更深的模型层级中访问属性、方法以及下标，多层可选链式调用不会增加返回值的可选层级。
    //    1. 如果访问的值不是可选的，可选链式调用将会返回可选值
    //    2. 如果访问的值本身就是可选的，可选链式调用不会让可选返回值变得"更可选"。
    //    例子：通过可选链式调用访问一个 Int 值，将会返回 Int?，无论使用了多少层可选链式调用；通过可选链式调用访问 Int? 值，依旧会返回 Int? 值，并不会返回 Int??。
    static func linkingMultipleLevelsOfChaining() {
        struct Address {
            var city: String = "beijing"
            var street: String?
            func getCity() -> String {
                city
            }
            func getStreet() -> String? {
                street
            }
        }
        
        struct Room {
            let name: String
            var address: Address?
            init(name: String) {
                self.name = name
            }
        }
        
        struct Person {
            var room: Room?
        }
        
        var person = Person()
        
        // 只要是可选值就可以进行可选链式调用，无论可选值是在链式调用过程被包装的（属性或者方法返回值），还是本身定义的；
        person.room?.address?.city = "shanghai"
        person.room?.address?.street = "1号"
        // 下面两个函数都将返回 Bool? 类型
        let _ = person.room?.address?.getStreet()?.hasPrefix("1")
        let _ = person.room?.address?.getCity().hasPrefix("1")
    }
}
