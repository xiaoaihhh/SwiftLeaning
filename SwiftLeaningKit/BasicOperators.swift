//
//  BasicOperators .swift
//  SwiftLeaningKit
//
//  Created by performance on 2021/4/26.
//  Copyright © 2021 SwiftLeaning. All rights reserved.
//

import Foundation

public func basicOperators() {
    assignmentOperator()
    arithmeticOperators()
    comparisonOperators()
    rangeOperators()
}

/// 赋值运算符 =
func assignmentOperator() {
    // 与 C 语言和 Objective-C 不同，Swift 的赋值操作并不返回任何值
    var x = false
    var y = true
    let z = (x = false)
//    if x = y {
//        此句错误，因为 x = y 并不返回任何值
//        通过将 if x = y 标记为无效语句，Swift 能帮你避免把 （==）错写成（=）这类错误的出现。
//    }
}


/// 算术运算符 + - * /
func arithmeticOperators() {
   
    var a = Int8.max
//    var a1 = a + 1 // 溢出，编译器报错
    var b = Int8("128") // 128 溢出，类型转换失败，因此 b 为 nil
//    var c = Int8("127")! + 1; // 溢出运行时错误
    // Note：与 C 语言和 Objective-C 不同的是，Swift 默认情况下不允许在数值运算中出现溢出情况。
}

/// 组合赋值运算符 +=  -=  *=  -=
func compoundAssignmentOperators() {
    var a = 1
    a += 2
    let b = (a += 2) // 复合赋值运算没有返回值，这类代码是错误的。
}

/// 比较运算符
//等于（a == b）
//不等于（a != b）
//大于（a > b）
//小于（a < b）
//大于等于（a >= b）
//小于等于（a <= b）
// 恒等（===）和不恒等（!==）这两个比较符来判断两个对象(只能是引用类型)是否引用同一个对象实例
func comparisonOperators() {
//    1. 比较运算都返回了一个标识表达式是否成立的布尔值
//    2. Swift 也提供。
    1 == 1   // true, 因为 1 等于 1
    let str = "abc"
    str == "abc" // true
    
    class ATest {
        
    }
    let a = ATest()
    let b = ATest()
    a === b // false
    
    // 当元组中的元素都可以被比较时，也可以使用这些运算符来比较它们的大小。Swift 标准库只能比较七个以内元素的元组比较函数。如果你的元组元素超过七个时，你需要自己实现比较运算符。
    (1, "123") <= (1, "234") // true
}

/// 空合运算符  ??
func nilCoalescingOperator() {
    // 空合运算符（a ?? b）将对可选类型 a 进行空判断，如果 a 包含一个值就进行解包，否则就返回一个默认值 b。表达式 a 必须是 Optional 类型。默认值 b 的类型必须要和 a 存储值的类型保持一致
    // a ?? b  等价于 a != nil ? a! : b
    let defaultColorName = "red"
    var userDefinedColorName: String?   //默认值为 nil
    var colorNameToUse = userDefinedColorName ?? defaultColorName // red
    userDefinedColorName = "green"
    colorNameToUse = userDefinedColorName ?? defaultColorName // green
}

/// 区间运算符 ... ..<
func rangeOperators() {
    // 闭区间运算符（a...b）定义一个包含从 a 到 b（包括 a 和 b）的所有值的区间。a 的值不能超过 b。
    let range = 1...4
    for idx in range { // 打印 1 到 4
        print(idx)
    }
    
    // 半开区间运算符（a..<b）定义一个从 a 到 b 但不包括 b 的区间。 之所以称为半开区间，是因为该区间包含第一个值而不包括最后的值。
    let names = ["Anna", "Alex", "Brian", "Jack"]
    for i in 0..<names.count {
        print("第 \(i + 1) 个人叫 \(names[i])")
    }
    
    // 单侧区间，即省略掉区间操作符一侧的值，闭区间操作符可以省略左值或者右值，半开区间操作符只能省略左值
    let name1 = names[2...]
    print(name1)
    let name2 = names[...2]
    print(name2)
    let name3 = names[..<2]
    print(name3)
    //Note： 闭区间/半开区间/单侧区间运算符都可以在下标里使用
    
    // 还可以如下使用
    // 不能遍历省略了初始值的单侧区间，因为遍历的开端并不明显。可以遍历一个省略最终值的单侧区间；然而，由于这种区间无限延伸的特性，请保证你在循环里有一个结束循环的分支
    let range1 = ...5
    range1.contains(7)   // false
    range1.contains(-1)  // true
}
