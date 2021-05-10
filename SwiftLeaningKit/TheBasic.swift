//
//  TheBasic.swift
//  SwiftLeaningKit
//
//  Created by performance on 2021/4/25.
//  Copyright © 2021 SwiftLeaning. All rights reserved.
//

import Foundation

/// 常量，不可以修改；使用 let 关键词
let maximumNumberOfLoginAttempts = 0
/// 变量，可以修改；使用 var 关键词
var currentLoginAttempt = 0
/// 多个变量用逗号隔开
var a = 0, b = 1, c = maximumNumberOfLoginAttempts

/// Note
/// 1. 全局变量/常量声明时候必须初始化，局部的声明时候可以不初始化；

func changeValue() {
//    maximumNumberOfLoginAttempts = 0
    currentLoginAttempt = 10
    
    /// 类型注解，声明时候指定类型
    var welcomeMessage: String
    welcomeMessage = "welcomeMessage"
    print(welcomeMessage)
    
    /// 可以在一行中定义多个同样类型的变量，用逗号分割，并在最后一个变量名之后添加类型注解
    var a, b, c:Double
    a = 1.0
    b = a
    c = b
    print(c)
}



/// 使用 typealias 关键字来定义类型别名，类型别名（type aliases）就是给现有类型定义另一个名字。
typealias MessageName = String
let name: MessageName = "name"



/// 布尔（Boolean）类型，叫做 Bool。布尔值指逻辑上的值，因为它们只能是真或者假。Swift 有两个布尔常量，true 和 false
let orangesAreOrange = true
let turnipsAreDelicious = false

/// 元组（tuples）把多个值组合成一个复合值。元组内的值可以是任意类型，并不要求是相同类型。
func tupleTest() {
    let http404Error = (404, "Not Found")
    /// 通过0，1 ... 下标访问元组元素
    print("The status code is \(http404Error.0)\n" + "The status message is \(http404Error.1)")
    
    /// 将元组拆解成两个元素
    let (httpCode, httpMessage) = http404Error
    print("The status code is \(httpCode)\n" + "The status message is \(httpMessage)")
    
    let http200Status = (statusCode: 200, description: "")
    print("The status code is \(http200Status.statusCode)\n" + "The status message is \(http200Status.description)")
    
//    Note: 当遇到一些相关值的简单分组时，元组是很有用的。元组不适合用来创建复杂的数据结构。如果你的数据结构比较复杂，不要使用元组，用类或结构体去建模
}


/// 类型安全和类型推断
//Swift 是一个类型安全（type safe）的语言。类型安全的语言可以让你清楚地知道代码要处理的值的类型。如果你的代码需要一个 String，你绝对不可能不小心传进去一个 Int。
//由于 Swift 是类型安全的，所以它会在编译你的代码时进行类型检查（type checks），并把不匹配的类型标记为错误。这可以让你在开发的时候尽早发现并修复错误。
//当你要处理不同类型的值时，类型检查可以帮你避免错误。然而，这并不是说你每次声明常量和变量的时候都需要显式指定类型。如果你没有显式指定类型，Swift 会使用类型推断（type inference）来选择合适的类型。有了类型推断，编译器可以在编译代码的时候自动推断出表达式的类型。原理很简单，只要检查你赋的值即可。
//因为有类型推断，和 C 或者 Objective-C 比起来 Swift 很少需要声明类型。常量和变量虽然需要明确类型，但是大部分工作并不需要你自己来完成。

let meaningOfLife = 42 // meaningOfLife 会被推测为 Int 类型
let pi = 3.1415 // pi 会被推测为 Double 类型； 当推断浮点数的类型时，Swift 总是会选择 Double 而不是 Float

let three = 3
let pointOneFourOneFiveNine = 0.14159
let pi_1 = Double(three) + pointOneFourOneFiveNine //three不强制转Double编译器将报错
let pi_2 = 3 + 0.14159
/// Note: 结合数字类常量和变量不同于结合数字类字面量。字面量 3 可以直接和字面量 0.14159 相加，因为数字字面量本身没有明确的类型。它们的类型只在编译器需要求值的时候被推测。


/// 可选类型（optionals）
// 1. 可选类型表示两种可能：1)有值，你可以解析可选类型访问这个值; 2)根本没有值。
// 2. 通过在一个类型后面加上?表示这个类型为可选类型，例如 Int?，String?
// 3. 可以将一个可选类型赋值为 nil 表示表示它没有值;
// 4. nil 不能用于非可选的常量和变量，如果你的代码中有常量或者变量需要处理值缺失的情况，请把它们声明成对应的可选类型。
// 5. Swift 的 nil 和 Objective-C 中的 nil 并不一样。在 Objective-C 中，nil 是一个指向不存在对象的指针。在 Swift 中，nil 不是指针——它是一个确定的值，用来表示值缺失。任何类型的可选状态都可以被设置为 nil，不只是对象类型。
// 6. 你可以使用 if 语句和 nil 比较来判断一个可选值是否包含值。你可以使用“相等”(==)或“不等”(!=)来执行比较。
// 7. 强制解析（forced unwrapping）：当确定可选类型确实包含值之后，可以在可选的名字后面加一个感叹号（!）来获取值。
// 8. 使用 ! 来获取一个不存在的可选值会导致运行时错误。使用 ! 来强制解析值之前，一定要确定可选包含一个非 nil 的值。
// 9. 可选绑定（optional binding）：判断可选类型是否包含值，如果包含就把值赋给一个临时常量或者变量。可选绑定用在if/while/guard等语句中；
// 10. 可以将包含多个可选绑定或多个布尔条件写一个 if 语句中，只要使用逗号分开就行。只要有任意一个可选绑定的值为 nil，或者任意一个布尔条件为 false，则整个 if 条件判断为 false。
// 11. 在 if 条件语句中使用常量和变量来创建一个可选绑定，仅在 if 语句的句中（body）中才能获取到值。相反，在 guard 语句中使用常量和变量来创建一个可选绑定，仅在 guard 语句外且在语句后才能获取到值。
// 12. C 和 Objective-C 中并没有可选类型这个概念。最接近的是 Objective-C 中的一个特性，一个方法要不返回一个对象要不返回 nil，nil 表示“缺少一个合法的对象”。然而，这只对对象起作用——对于结构体，基本的 C 类型或者枚举类型不起作用。对于这些类型，Objective-C 方法一般会返回一个特殊值（比如 NSNotFound）来暗示值缺失。这种方法假设方法的调用者知道并记得对特殊值进行判断。然而，Swift 的可选类型可以让你暗示任意类型的值缺失，并不需要一个特殊值。
func testOptionals() {
    var serverResponseCode: Int? = 404 // serverResponseCode是一个可选类型，目前值是 404
    serverResponseCode = nil // serverResponseCode 赋值为 nil，serverResponseCode 现在没有值
    print(serverResponseCode ?? 404)
}

/// 隐式解析可选类型（implicitly unwrapped optionals）
// 1. 有时候在程序架构中，第一次被赋值之后，可以确定一个可选类型总会有值。在这种情况下，每次都要判断和解析可选值是非常低效的，因为可以确定它总会有值。
// 2. 通过在一个类型后面加上 ! 表示这个类型为隐式解析可选类型，例如 Int!，String!
// 3. 隐式解析可选类型其实就是一个普通的可选类型（可选绑定，通过和nil比较判断是否包含值，使用 ! 解析值等），但是可以被当做非可选类型来使用，并不需要每次都使用 ！来解析获取可选值;
// 4. 当可选类型被第一次赋值之后就可以确定之后一直有值的时候，隐式解析可选类型非常有用。隐式解析可选类型主要被用在 Swift 中类的构造过程
// 5. 如果一个变量之后可能变成 nil 的话请不要使用隐式解析可选类型。如果你需要在变量的生命周期中判断是否是 nil 的话，请使用普通可选类型。

let possibleString: String? = "An optional string."
let forcedString: String = possibleString! // 可选类型需要使用 ! 来获取值

let assumedString: String! = "An implicitly unwrapped optional string."
let implicitString: String = assumedString  // 隐式解析可选类型不需要使用 ! 来获取值
