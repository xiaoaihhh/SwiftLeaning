//
//  CollectionTypes.swift
//  SwiftLeaningKit
//
//  Created by performance on 2021/4/26.
//  Copyright © 2021 SwiftLeaning. All rights reserved.
//

import Foundation


public struct CollectionTypes: Runable {
    //    1. 在不需要改变集合的时候创建不可变集合是很好的实践。这样做便于你理解自己的代码，也能让 Swift 编译器优化集合的性能。
    
    public static func run() {
        arrayTest()
        setTest()
        dictionaryTest()
    }
    
    
    /// 数组 Array
    static func arrayTest() {
        var someInt = Array<Int>() // Array<Element> 方式创建数组
        someInt = [Int]() // [Element] 方式创建数组
        someInt.append(3) // 添加一个元素
        var otherSomeInt: [Int] = []
        otherSomeInt.append(4)
        someInt += otherSomeInt
        print(someInt)
        someInt = [] // 设置为空数组
        
        var shoppingList = ["Eggs", "Milk"]; // 通过字面量直接构建数组，使用类型推断
        shoppingList += ["Chocolate Spread", "Cheese", "Butter"]
        shoppingList[0...1] = [] // 使用区间运算符改变连续的值，改变前后无需个数相同
        print(shoppingList)
        
        for item in shoppingList { // 遍历数组
            print(item)
        }
        
        // 使用 enumerated() 方法来进行数组遍历, 同时获取每个数据项的值和索引值
        for (idx, value) in shoppingList.enumerated() {
            print("Item \(String(idx + 1)): \(value)")
        }
    }
    
    /// 集合
//    1. 一个类型为了存储在集合中，该类型必须是可哈希化的，也就是说，该类型必须提供一个方法来计算它的哈希值。一个哈希值是 Int 类型的，相等的对象哈希值必须相同，比如 a == b,因此必须 a.hashValue == b.hashValue。
    
    //你可以使用自定义的类型作为集合值的类型或者是字典键的类型，但需要使自定义类型遵循 Swift 标准库中的 Hashable 协议。遵循 Hashable 协议的类型需要提供一个类型为 Int 的可读属性 hashValue。由类型的 hashValue 属性返回的值不需要在同一程序的不同执行周期或者不同程序之间保持相同。
//    因为 Hashable 协议遵循 Equatable 协议，所以遵循该协议的类型也必须提供一个“是否相等”运算符（==）的实现。这个 Equatable 协议要求任何遵循 == 实现的实例间都是一种相等的关系。也就是说，对于 a,b,c 三个值来说，== 的实现必须满足下面三种情况：
//    a == a(自反性)
//    a == b 意味着 b == a(对称性)
//    a == b && b == c 意味着 a == c(传递性)
    static func setTest() {
        var letters = Set<Character>() // Set<Element> 方式创建空集合；集合没有数组 [Element] 的便捷创建方式
        letters.insert("A")
        letters = [] // 设置为空集合，因为letters已经声明为集合类型，可以直接使用 [] 设置为空集合
        var favoriteGenres: Set<String> = ["Rock", "Classical", "Hip hop"] //  通过字面量方式创建集合，但是需要声明集合的类型，这里无法使用类型推断，不然会被推断为数组
        favoriteGenres.remove("Rock")
        // 遍历集合
        for item in favoriteGenres {
            print(item)
        }
        // Swift 的 Set 类型没有确定的顺序，为了按照特定顺序来遍历一个集合中的值可以使用 sorted() 方法，它将返回一个有序数组，这个数组的元素排列顺序由操作符 < 对元素进行比较的结果来确定。
        for item in favoriteGenres.sorted() {
            print(item)
        }
        
        // 集合可以高效地完成集合的一些基本操作，例如交集、并集、是否包含等等。
    }
    
    /// 字典 Dictionary
//    1. 一个字典的 Key 类型必须遵循 Hashable 协议，就像 Set 的值类型。
//    2. 字典的下标访问会返回对应值类型的可选类型。如果这个字典包含请求键所对应的值，下标会返回一个包含这个存在值的可选类型，否则将返回 nil
    
    static func dictionaryTest() {
        var namesOfIntegers = Dictionary<Int, String>() // 使用 Dictionary<Key, Value> 定义字典
        namesOfIntegers = [Int: String]() // 使用 [Key: Value] 简化形式定义字典
        namesOfIntegers[16] = "sixteen"
        namesOfIntegers = [:] // 由于之前已经声明字典类型，使用 [:] 设置为空字典
        
        // 使用字面量创建字典
        var airports: [String: String] = ["YYZ": "Toronto Pearson", "DUB": "Dublin"] // 使用[Key: Value] 简化形式声明字典
        var airports1: Dictionary<String, String> = ["YYZ": "Toronto Pearson", "DUB": "Dublin"] // 使用 Dictionary<Key, Value> 声明字典类型
        var airports2 = ["YYZ": "Toronto Pearson", "DUB": "Dublin"] // 类型推断
        
        airports["LHR"] = "London" // 使用下标方式往字典添加新的内容
        // 使用updateValue(_:forKey:)更新字段的值，如果之前对应的Kye，Value存在，则返回旧值，如果不存在则返回 nil，返回的数据为可选类型
        if let oldValue = airports.updateValue("London1", forKey: "LHR") {
            print(oldValue)
        }
        
        airports.removeValue(forKey: "LHR") // 移除一个健值对
        airports["YYZ"] = nil // 直接通过赋值为 nil 移除一个健值对
        
        // 遍历数组
        for (key, value) in airports {
            print("key:\(key), value:\(value)")
        }
    }
}
