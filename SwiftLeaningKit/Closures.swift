//
//  Closures.swift
//  SwiftLeaningKit
//
//  Created by fanshuaifei on 2021/5/9.
//  Copyright © 2021 SwiftLeaning. All rights reserved.
//

import Foundation

struct ClosuresTest: Runable {
    static func run() {
        print("\n\n=================== Closures ====================")
        closureExpressions()
        trailingClosures()
        capturingValues()
        closuresAreReferenceTypesTest()
        escapingClosures()
        autoClosures()
    }
    
    //    闭包定义：闭包是自包含的函数代码块，可以在代码中被传递和使用
    //    闭包采用如下三种形式之一：
    //    1. 全局函数是一个有名字但不会捕获任何值的闭包
    //    2. 嵌套函数是一个有名字并可以捕获其封闭函数域内值的闭包
    //    3. 闭包表达式是一个利用轻量级语法所写的可以捕获其上下文中变量或常量值的匿名闭包
    
    static func mathFunction(a: Int, b: Int, mathFunc: (Int, Int) -> Int) -> Int {
        return mathFunc(a, b)
    }
    
    /// 闭包表达式
    static func closureExpressions() {
        print("\n-----------------闭包：内敛闭包定义----------------")
        //  内敛闭包表达式语法如下：
        //  1. (parameters) -> return type 部分和函数定义一样，只是省略了函数名字
        //  2. 闭包的函数体部分由关键字 in 引入
        //  3. 闭包整体使用 {} 包裹，其他语言 {} 定义一个代码块，swift 中 {} 是一个无参数和无返回值的闭包，详细见下面关于闭包的简洁风格的写法。
        //  4. 因为全局函数和嵌套函数也是闭包，下面这种将函数和返回值类型都写在大括号内的形式称为内联闭包表达式。
        //  { (parameters) -> return type in
        //      statements
        //  }
        
        // 定义一个闭包
        let mathFunc = { (a: Int, b: Int) -> Int in
            return a + b
        }
        var sum = mathFunction(a: 10, b: 10, mathFunc: mathFunc) // 闭包作为函数参数
        print(sum)
        
        
        /// 根据上下文推断闭包参数类型
        /// 通过内联闭包表达式构造的闭包作为参数传递给函数或方法时，总是能够推断出闭包的参数和返回值类型。这意味着闭包作为函数或者方法的参数时，几乎不需要利用完整格式构造内联闭包。
        // a 和 b 被推断为 Int
        sum = mathFunction(a: 10, b: 10, mathFunc: { (a, b) -> Int in
            return a + b
        })
        print(sum)
        
        // 因为可以推断出类型，因此 () 和 返回类型都可以省略
        sum = mathFunction(a: 10, b: 10, mathFunc: { a, b in return a + b })
        print(sum)
        
        // 单表达式闭包隐式返回，和函数一样，如果是单行表达式可以省略 reture
        sum = mathFunction(a: 10, b: 10, mathFunc: { a, b in a + b })
        print(sum)
        
        // 参数名称缩写
        // Swift 自动为内联闭包提供了参数名称缩写功能，你可以直接通过 $0，$1，$2 来顺序调用闭包的参数，以此类推。
        sum = mathFunction(a: 10, b: 10, mathFunc: { $0 + $1 })
        print(sum)
        
        // 运算符方法，针对这个 mathFunction 这个函数，闭包还可以传入运算符，比如 + - * 等等。swift 中运算符本身就是定义的函数。
        sum = mathFunction(a: 10, b: 10, mathFunc: +)
        print(sum)
    }
    
    
    /// 尾随闭包（Trailing Closures）
    /// 如果将一个很长的闭包表达式作为最后一个参数传递给函数，可以使用尾随闭包形式，当闭包非常长以至于不能在一行中进行书写时，使用尾随闭包可读性更强。尾随闭包是一个书写在函数圆括号之后的闭包表达式，函数支持将其作为最后一个参数调用。在使用尾随闭包时，不需要写出它的参数标签。
    static func trailingClosures() {
        print("\n-----------------闭包：尾随闭包----------------")
        // 直接将闭包写在函数最后面，作为函数的最后一个参数，此时省略了函数标签 mathFunc:
        var sum = mathFunction(a: 10, b: 10) { a, b in
            a + b
        }
        print(sum)
        
        // 使用更精简的闭包表达式
        sum = mathFunction(a: 10, b: 10) { $0 + $1 }
        print(sum)
        
        func doSomeThingUsing(action: () -> Void) {
            action()
        }
        doSomeThingUsing() {
            print("doSomeThingUsing")
        }
        // 如果只有一个参数，可以把函数调用的 () 省略
        doSomeThingUsing {
            print("doSomeThingUsing")
        }
    }
    
    
    /// 值捕获
    /// 闭包可以在其被定义的上下文中捕获常量或变量,即使定义这些常量和变量的原作用域已经不存在，闭包仍然可以在闭包体内引用和修改这些值。
    static func capturingValues() {
        print("\n-----------------闭包：值捕获----------------")
        /// Swift 中，可以捕获值的闭包的最简单形式是嵌套函数，也就是定义在其他函数的函数体内的函数。嵌套函数可以捕获其外部函数所有的参数以及定义的常量和变量。
        func makeIncrementer(forIncrement amount: Int) -> () -> Int {
            var runningTotal = 0
            func incrementer() -> Int {
                runningTotal += amount // 这里捕获了 runningTotal 变量，将 malloc 堆空间保存 runningTotal 变量，不然超出makeIncrementer函数作用域后 runningTotal 变量将被销毁，无法使用
                return runningTotal
            }
            return incrementer
        }
        
        // 每次调用 makeIncrementer 都将重新 malloc 堆空间捕获 runningTotal，即每次对 runningTotal 的捕获是和 makeIncrementer 的调用绑定的
        // incrementBy10 和 incrementBy3 不是修改的同一个 runningTotal
        let incrementBy10 = makeIncrementer(forIncrement: 10)
        print("forIncrement-10:", incrementBy10()) // print 10
        print("forIncrement-10:", incrementBy10()) // print 20
        
        let incrementBy3 = makeIncrementer(forIncrement: 3)
        print("forIncrement-3:", incrementBy3()) // print 3
        print("forIncrement-3:", incrementBy3()) // print 6
        
        
        // 为了优化，如果一个值不会被闭包改变，或者在闭包创建后不会改变，Swift 可能会改为捕获并保存一份对值的拷贝。
        // Swift 也会负责被捕获变量的所有内存管理工作，包括释放不再需要的变量。
        func getB(from: Int) -> Int {
            return from
        }
        
        func closureCapturing() -> () -> () {
            var a = 5
            var b = 10
            let c = 15
            b += getB(from: 3) // b = 13
            func closure() {
                a += (b + c) // 这里只会为捕获的 a malloc 堆空间，因为 b 和 c 在闭包体内部不会被修改，只会保存一份对 b 和 c 值的拷贝。
            }
            return closure
        }
        let closure = closureCapturing()
        closure()
        
        // 闭包对变量的捕获只有在返回时候才会真正捕获
        func closureCapturing1() -> () -> () {
            var a = 5
            func closure() {
                a += 1 // 这里捕获的 a 的值是 10，因为只有真正返回 closure 闭包时候，才会进行捕获
                print("closureCapturing1:", a)
            }
            
            a = 10
            return closure
        }
        let closure1 = closureCapturing1()
        closure1()
    }
    
    
    /// 闭包是引用类型（Closures Are Reference Types）
    static func closuresAreReferenceTypesTest() {
        // 这里继续使用 makeIncrementer 例子
        func makeIncrementer(forIncrement amount: Int) -> () -> Int {
            var runningTotal = 9
            func incrementer() -> Int {
                runningTotal += amount
                return runningTotal
            }
            return incrementer
        }
        let incrementBy10 = makeIncrementer(forIncrement: 10)
        print("closuresAreReference-forIncrement-10:", incrementBy10()) // print 10
        let incrementBy10Ref = incrementBy10
        print("closuresAreReference-forIncrement-10:", incrementBy10Ref()) // print 11
    }
    
    
    /// 逃逸闭包（Escaping Closures）
    /// 当一个闭包作为参数传到一个函数中，但这个闭包在函数返回之后才被执行，称该闭包从函数中逃逸。当定义接受闭包作为参数的函数时，可以在参数名之前标注 @escaping，用来指明这个闭包是允许“逃逸”出这个函数的。
    static func escapingClosures() {
//        var completionHandlers: [() -> Void] = []
//        func someFunctionWithEscapingClosure(completionHandler: @escaping () -> Void) { // 不将这个参数标记为 @escaping，就会得到一个编译错误。
//            completionHandlers.append(completionHandler)
//        }
        
        class SomeClass {
            var x = 10
            func doSomething() {
//                someFunctionWithEscapingClosure { self.x = 100 }
//                someFunctionWithNonescapingClosure { x = 200 }
            }
        }
        
    }
    
    /// 自动闭包 (Autoclosures)
    /// 自动闭包是一种自动创建的闭包，用于包装传递给函数作为参数的表达式。这种闭包不接受任何参数，当它被调用的时候，会返回被包装在其中的表达式的值。这种便利语法让你能够省略闭包的花括号，用一个普通的表达式来代替显式的闭包。
    // 自动闭包函数原型为 () -> T，无参数，返回传入表达式返回值类型
    static func autoClosures() {
        print("\n-----------------闭包：自动闭包----------------")
        // && || 等运算符都是短路求值，下面模拟短路求值 case
        
        func addOperator(leftValue: Bool, rightValue: Bool) -> (Bool) {
            if leftValue == false {
                return leftValue
            }
            return rightValue
        }
        func getRightValue( ) -> Bool {
            print("call getRightValue function")
            return true
        }
        _ = addOperator(leftValue: false, rightValue: getRightValue())
        // 这里这个case，addOperator 函数中如果 leftValue 是false，那么完全不会用到 rightValue，但是传入的 getRightValue() 是立即调用的，如果该函数很耗时，完全没有必要，所以 rightValue 可以使用一个闭包替代，做到短路求值目的
        
        func addOperatorWithClosure(leftValue: Bool, rightValue: () -> Bool) -> (Bool) {
            if leftValue == false {
                return leftValue
            }
            return rightValue()
        }
        _ = addOperatorWithClosure(leftValue: false, rightValue: { getRightValue() }) // 这里传入 { getRightValue() }，是一个最简洁的闭包语法糖写法
        
        // 使用 @autoclosure，调用时可以直接传入一个 Bool 值，自动封装成 () -> T 类型闭包
        func addOperatorWithClosure(leftValue: Bool, rightValue: @autoclosure () -> Bool) -> (Bool) {
            if leftValue == false {
                return leftValue
            }
            return rightValue()
        }
        _ = addOperator(leftValue: false, rightValue: getRightValue())
        _ = addOperatorWithClosure(leftValue: false, rightValue: { getRightValue() }) // 这里传入 { getRightValue() }，是一个最简洁的闭包语法糖写法
        // todo
        _ = addOperatorWithClosure(leftValue: false, rightValue: getRightValue())
        
        // 总结
        // 1. 经常会调用采用自动闭包的函数，但是很少去实现这样的函数。
        // 2. 自动闭包让你能够延迟求值，因为直到你调用这个闭包，代码段才会被执行。
        // 3. 过度使用 autoclosures 会让你的代码变得难以理解。上下文和函数名应该能够清晰地表明求值是被延迟执行的。
        // 4. 如果想让一个自动闭包可以“逃逸”，则应该同时使用 @autoclosure 和 @escaping 属性
        // 5. 有和无 @autoclosure 构成函数重载
    }
}


