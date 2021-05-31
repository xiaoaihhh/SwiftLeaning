//
//  ErrorHandling.swift
//  SwiftLeaningKit
//
//  Created by fanshuaifei on 2021/5/29.
//  Copyright © 2021 SwiftLeaning. All rights reserved.
//

import Foundation

struct ErrorHandlingTest: Runable {
    static func run() {
        print("\n\n=================== Error Handling ====================")
        representingAndThrowingErrorsTest()
        rethrowsTest()
        cleanupActionsTest()
        assertTest()
        fatalErrorTest()
    }
    
    /// 错误处理是响应错误以及从错误中恢复的过程。Swift 在运行时提供了抛出、捕获、传递和操作可恢复错误（recoverable errors）的一等支持（first-class support）。某些操作无法保证总是执行完所有代码或生成有用的结果，理解造成失败的原因有助于在代码中作出应对。
    
    /// 错误的表示和抛出
    /// 1. 在 Swift 中，错误用遵循 Error 协议的类型的值来表示，这个空协议表明该类型可以用于错误处理。
    /// 2. Swift 中枚举类型尤为适合构建一组相关的错误状态，枚举的关联值还可以提供错误状态的额外信息。当然也可以用其它遵守 Error 协议的值类型表示。
    /// 3. 通过 throw 语句抛出错误。可能抛出错误的函数定义时候必须使用 throws 来修饰, func funcName(paramsList) throws -> returnType。
    
    /// Swift 中有 4 种处理错误的方式。
    /// 1. 直接通过 try expression 调用抛出错误的代码，调用  try expression  的函数也定义为 throwing 函数，则把  try expression 抛出的错误继续传递下去。如果最顶层函数还没有捕获错误，则发生运行时错误。
    /// 2. 用 do-catch 语句处理错误
    /// 3. 通过 try? 将错误作为可选类型处理
    /// 4. 断言此错误根本不会发生，通过  try! 禁用错误传递
    static func representingAndThrowingErrorsTest() {
        print("\n-----------------错误处理：错误定义与处理----------------")
        enum AgeError: Error {
            case lessThanZero(description: String)   // 负数
            case olderThan100(description: String)  // 大于100
        }
        
        class Person {
            private var age: Int = 0
            private var name: String = ""
            /// 为了表示一个函数、方法或构造器可以抛出错误，在函数声明的参数之后加上 throws 关键字。一个标有 throws 关键字的函数被称作 throwing 函数。如果这个函数指明了返回值类型，throws 关键词需要写在返回箭头（->）的前面。
            /// 1. 一个 throwing 函数可以在其内部抛出错误，并将错误传递到函数被调用时的作用域。
            /// 2. 只有 throwing 函数可以传递错误，任何在某个非 throwing 函数内部抛出的错误只能在函数内部处理。
            func setAge(age: Int) throws { // throws
                if age < 0 {
                    // 通过 throw 直接抛出错误，立即终止后面所有代码执行，如果该函数有返回值，则可以省略 return 语句
                    throw AgeError.lessThanZero(description: "年龄小于0")
                } else if age > 100 {
                    throw AgeError.olderThan100(description: "年龄大于100")
                }
                self.age = age
                
            }
            
            func setAgeAndName(age: Int, name: String) throws { // 处理错误方式1: 把错误继续传递下去
                try setAge(age: age)
                self.name = name
            }
            
            func getAge() throws -> Int {
                age
            }
        }
        
        
        
        
        // 处理错误方式2: 用 do-catch 语句处理错误，语法如下
        //        do {
        //            try expression
        //            statements
        //        } catch pattern 1 {
        //            statements
        //        } catch pattern 2 where condition {
        //            statements
        //        } catch pattern 3, pattern 4 where condition {
        //            statements
        //        } catch { // 这个 catch 不能省略，处理兜底情况，省略导致编译不过
        //            statements
        //        }
        let person = Person()
        do {
            try person.setAgeAndName(age: -1, name: "Lucy")  // 如果发生错误，立即终止后面代码执行
            print("this line will print if error not happend")
        } catch AgeError.lessThanZero(let description)  {
            print(description)
        } catch AgeError.olderThan100(let description) {
            print(description)
        } catch {
            print("Unexpected error: \(error)")
        }
        
        // 处理错误方式3: 将错误作为可选类型处理
        // 1. 可以使用 try? 通过将错误转换成一个可选值来处理错误。如果是在计算 try? 表达式时抛出错误，该表达式的结果就为 nil。
        if let age = try? person.getAge() {
            print(age)
        }
        
        // 处理错误方式4: 断言此错误根本不会发生，可以使用 try! 禁用错误传递。如果抛出了错误，则发生运行时错误。
        let _ = try! person.getAge()
    }
    
    
    /// rethrows
    static func rethrowsTest() {
        /// 函数参数必须有一个 throwing 函数作为参数，函数本身不会抛出错误，但是调用的 throwing 函数可能抛出错误。
        /// throwing 函数参数可以传入 throwing 函数或者非 throwing 函数，非 throwing 函数作为参数只能传入非 throwing 函数。这里 function 可以传入 (Double, Double) throws -> Double 或者 (Double, Double)  -> Double 两种函数原型的函数。
        /// 如果这里不对抛出错误做处理，可以选择将错误继续向上抛出，即将 operation 使用 throws 修饰，但是这样不论 function 参数是否为 throwing 函数，外部调用 operation 都需要做错误处理。此时可以将 operation 函数使用 rethrows 修饰，如果传入的 function 参数是 throwing 函数，则外部需要处理错误，如果传入的 function 参数不是 throwing 函数，则外部不需要做错误处理。
        func operation(function: (Double, Double) throws -> Double, firstNum: Double, secondNum: Double) rethrows -> Double {
            try function(firstNum, secondNum)
        }
        
        enum OperationError: Error {
            case firstNumZero
            case secondNumsZero
        }
        
        func division(firstNum: Double, secondNum: Double) throws -> Double {
            if secondNum == 0 {
                throw OperationError.secondNumsZero
            }
            return firstNum / secondNum
        }
        
        func add(firstNum: Double, secondNum: Double) -> Double {
            return firstNum + secondNum
        }
        
        let _ = try? operation(function: division, firstNum: 0, secondNum: 0) // 传入 throwing 函数作为参数，使用错误处理四种方式之一处理错误。
        let _ = operation(function: add, firstNum: 10, secondNum: 20) // 传入参数不是 throwing 函数，可以不做错误处理
    }
    
    /// 可以通过 defer 语句在【当前代码块】结束之前定义必须执行的代码，无论结束当前代码块是由于抛出错误而离开，或是由于诸如 return、break 的语句而离开。
    static func cleanupActionsTest() {
        print("\n-----------------错误处理：defer语句----------------")
        
        // 同一个代码块下，先定义的 defer 语句后执行
        do { // Swift 中 {} 默认是一个闭包，因此定一个局部作用域可以使用 do { }
            defer {
                print("do1 defer 1")
            }
            
            print("do1 not defer 1")
            
            defer {
                print("do1 defer 2")
            }
            
            print("do1 not defer 2")
        }
        
        do {
            defer {
                print("do2 defer 1")
            }
            if true {
                return
            }
            defer {
                print("do2 defer 2")
            }
        }
        
        // 打印顺序
        // do1 not defer 1
        // do1 not defer 2
        // do1 defer 2
        // do1 defer 1
        // do2 defer 1
        
        // 总结
        // 1. 同一个作用域下的 defer 语句后定义的先执行
        // 2. 同一个作用域下的 defer 语句必须定义在流程结束之前（例如return，throw等），不然流程结束无法执行该 defer 语句
        // 3. 不同作用域下的 defer 语句和执行顺序和作用域执行顺序有关。
    }
    
    /// 断言，当不符合指定条件时抛出运行时错误，常用于 Debug 调试。默认情况下，Swift 的断言只会在 Debug 下生效，Release 不会生效。
    static func assertTest() {
        print("\n-----------------错误处理：assert ----------------")
        func setAge(age: Int) {
            assert(age > 0 && age < 100, "年龄必须大于0小于100")
            // set age operation
        }
        setAge(age: 4)
    }
    
    /// fatalError，如果遇到严重问题需要立即终止程序运行，可以使用 fatalError
    static func fatalErrorTest() {
        func setAge(age: Int) throws { // fatalError 不需要将函数定义为 throwing 函数，这个为了说明 fatalError 不能被捕获
            if age < 0 || age >= 100 {
                fatalError("年龄必须大于0小于100")
            }
            // set age operation
        }
        try? setAge(age: 100) // fatalError 不能被捕获
    }
}
