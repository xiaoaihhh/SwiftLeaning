//
//  Generics.swift
//  SwiftLeaningKit
//
//  Created by fanshuaifei on 2021/5/31.
//  Copyright © 2021 SwiftLeaning. All rights reserved.
//

import Foundation

struct GenericsTest: Runable {
    static func run() {
        print("\n\n=================== 泛型 ====================")
        genericFunctionsTest()
        genericTypesTest()
        extendingAGenericTypeTest()
        typeConstraintsTest()
        associatedTypesTest()
    }
    
    /// 1. 泛型代码可以根据自定义的需求，编写出适用于任意类型的、灵活可复用的函数及类型。从而避免编写重复的代码，而是用一种清晰抽象的方式来表达代码的意图。
    /// 2. 通过 <T> 来定一个泛型类型， T 是一个占位，可以使用其他字符串代替，但是请始终使用大写字母开头的驼峰命名法（例如 T 和 MyTypeParameter）来为类型参数命名，以表明它们是占位类型，而不是一个值。也可以使用多个占位符，例如字典 Dictionary<Key, Value>。占位符通常起一个有意义的名字，告诉阅读代码的人这些参数类型与泛型类型或函数之间的关系，当它们之间没有有意义的关系时，通常使用单个字符来表示，例如 T、U、V 等。
    
    
    /// 泛型函数
    static func genericFunctionsTest() {
        // 直接在函数名后面跟上 <T>，指明函数参数接受一个类型为 T 的参数，也可以接受多个泛型类型参数，例如 <T, U>
        func swapTwoValue<T>(x: inout T, y: inout T) {
            (y, x) = (x, y)
        }
        
        var x = 10, y = 20 // Int
        swapTwoValue(x: &x, y: &y)
        print("x:\(x), y:\(y)")
        
        var x1 = 10.0, y1 = 20.0 // Double
        swapTwoValue(x: &x1, y: &y1)
        print("x:\(x1), y:\(y1)")
        
        func twoGenericParameter<T, U>(x: T, y: U) {
            
        }
    }
    
    
    /// 泛型类型
    static func genericTypesTest() {
        var stack = Stack<Int>()
        stack.push(10)
        stack.push(20)
        stack.push(30)
        print("stack pop: \(stack.pop() ?? -1)")
        print("stack pop: \(stack.pop() ?? -1)")
        print("stack pop: \(stack.pop() ?? -1)")
        print("stack pop: \(stack.pop() ?? -1)")
    }
    
    
    /// 泛型扩展
    static func extendingAGenericTypeTest() {
        var stack = Stack<Int>()
        stack.push(10)
        stack.push(20)
        print("stack pop: \(stack.topItem ?? -1)")
    }
    
    
    /// 泛型约束
    /// 类型约束指定类型参数必须继承自指定类、遵循特定的协议或协议组合。在一个类型参数名后面放置一个类名或者协议名，并用冒号进行分隔，来定义类型约束，例如 <T: SomeClass, U: SomeProtocol>
    static func typeConstraintsTest() {
        func findIndex<T: Equatable>(of valueToFind: T, in array: [T]) -> Int? {
            for (index, value) in array.enumerated() {
                if value == valueToFind { // 这里如果不定义 T 遵守 Equatable 协议，则无法进行比较
                    return index
                }
            }
            return nil
        }
    }
    
    
    /// 关联类型
    static func associatedTypesTest() {
        var stack = IntStack()
        stack.append(10)
        stack.append(20)
        print("stack 0: \(stack[0])")
    }
    
    
    /// 泛型 Where 语句
    /// 类型约束能够为泛型函数、下标、类型的类型参数定义一些强制要求。可以通过将 where 关键字紧跟在类型参数列表后面来定义 where 子句，where 子句后跟一个或者多个针对关联类型的约束，以及一个或多个类型参数和关联类型间的类型相等关系。可以在函数体、类型的大括号之前、关联类型定义处添加 where 子句。
    static func genericWhereClauses() {
        // 这里也可以这样 func allItemsMatch<C1, C2>(c1: C1, c2: C2) -> Bool where C1:Container, C2:Container, C1.Item == C2.Item, C1.Item: Equatable
        // C1 和 C2 必须遵守 Container 协议；C1 和 C2 的 Item 类型必须相同；C1 的 Item 必须遵守 Equatable 协议（同时 C2 的 Item 也会遵守 Equatable 协议）
        func allItemsMatch<C1: Container, C2: Container>(c1: C1, c2: C2) -> Bool where C1.Item == C2.Item, C1.Item: Equatable {
            if c1.count != c2.count {
                return false
            }
            for i in 0..<c1.count {
                if c1[i] != c2[i] {
                    return false
                }
            }
            return true
        }
    }
}

/// 泛型类型: 直接在类型名后面跟上 <T>，指明类型内部可以使用一个类型为 T 的参数，也可以定义多个泛型类型，例如 <T, U>
struct Stack<Item> {
    private var items:[Item] = []
    mutating func push(_ item: Item) {
        items.append(item)
    }
    mutating func pop() -> Item? {
        guard items.count > 0 else {
            return nil
        }
        return items.removeLast()
    }
}


/// 泛型扩展
extension Stack {
    // 当对泛型类型进行扩展时，并不需要提供类型参数列表作为定义的一部分。原始类型定义中声明的类型参数列表在扩展中可以直接使用。
    var topItem: Item? { // 直接使用 Stack 定义中的泛型类型 Item 和变量 items
        items.last
    }
}


/// 关联类型
/// 定义一个协议时，声明一个或多个关联类型作为协议定义的一部分将会非常有用。关联类型为协议中的某个类型提供了一个占位符名称，其代表的实际类型在协议被遵循时才会被指定。关联类型通过 associatedtype 关键字来指定。由于协议中无法定义泛型，通过关联类型让实现协议时候指定类型，达到类似泛型的效果。
protocol Container {
    // 定义一个关联类型 Item（也可以是其它字符串），在实现协议时候：
    //  1. 通过 typealias 来指定实现协议时候关联类型的实际类型。
    //  2. 定一个 Item 的实际类型，即 Item 是一个真实存在的类型，例如 associatedtype Int。
    associatedtype Item
    mutating func append(_ item: Item)
    var count: Int { get }
    subscript(i: Int) -> Item { get }
}

struct IntStack: Container {
    typealias Item = Int // 通过 typealias 来指定实现协议时候关联类型的实际类型。也可以省略这行，因为 Swift 会自动推断出关联类型的类型为 Int，如果不能自断推断出则报错。
    var items:[Item] = []
    var count: Int {
        items.count
    }
    mutating func append(_ item: Int) {
        items.append(item)
    }
    subscript(i: Int) -> Int {
        items[i]
    }
}


protocol ContainerEquatable {
    // 可以给关联类型添加约束，和泛型添加约束类似；约束中遵守的协议可以是关联类型所在协议本身。
    associatedtype Item: Equatable
    mutating func append(_ item: Item)
    var count: Int { get }
    subscript(i: Int) -> Item { get }
}


/// 泛型下标，可以在 subscript 后用尖括号来写占位符类型，还可以在下标代码块花括号前写 where 子句
extension Container {
    subscript<Indices: Sequence>(indices: Indices) -> [Item]
        where Indices.Iterator.Element == Int {
            var result = [Item]()
            for index in indices {
                result.append(self[index])
            }
            return result
    }
}
