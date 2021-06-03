//
//  MemorySafety.swift
//  SwiftLeaningKit
//
//  Created by performance on 2021/5/28.
//  Copyright © 2021 SwiftLeaning. All rights reserved.
//

import Foundation


struct MemorySafety: Runable {
    static func run() {
        conflictingAccessToInOutParametersTest()
    }
    
    /// 内存访问
    //  1.  冲突会发生在代码尝试同时访问同一个存储地址的时侯，同一个存储地址的多个访问同时发生会造成不可预计或不一致的行为。在 Swift 里，有很多修改值的行为都会持续好几行代码，在修改值的过程中进行访问是有可能发生的。
    //  2. 并发和多线程的代码中，内存访问冲突是同样的问题。如果在单线程代码里有访问冲突，Swift 可以保证在编译或者运行时会得到错误。对于多线程的代码，可以使用 Thread Sanitizer 去检测多线程的冲突。
    
    /// 内存访问性质
    ///    内存访问冲突时，要考虑内存访问上下文中的三个性质：访问是读还是写，访问的时长，以及被访问的存储地址。冲突会发生在当有两个访问符合下列的情况时候：
    //    1. 至少有一个是写访问
    //    2. 它们访问的是同一个存储地址
    //    3. 它们的访问在时间线上部分重叠
    
    /// 内存访问的时长分为两种：
    //  1. 瞬时的: 如果一个访问不可能在其访问期间被其它代码访问，那么就是一个瞬时访问，通常两个瞬时访问是不可能同时发生的，大多数内存访问都是瞬时的。
    //  2. 长期的:访问时间较长，容易和其他访问发生时间重叠。
    //  3. 瞬时访问和长期访问的区别在于别的代码有没有可能在访问期间同时访问，也就是在时间线上的重叠。一个长期访问可以被别的长期访问或瞬时访问重叠。重叠的访问主要出现在使用 in-out 参数的函数和方法或者结构体的 mutating 方法里。
    
    /// In-Out 参数的访问冲突
    /// 一个函数会对它所有的 in-out 参数进行长期写访问，in-out 参数的写访问会在所有非 in-out 参数处理完之后开始，直到函数执行完毕为止。如果有多个 in-out 参数，则写访问开始的顺序与参数的顺序一致。长期访问的存在会造成一个结果，如果一个变量以 in-out 作为参数传入函数，函数执行期间不能在访问该变量，即使作用域原则和访问权限允许——任何访问原变量的行为都会造成冲突。
    static func conflictingAccessToInOutParametersTest() {
        var stepSize = 1
        stepSize = 1 // 这行用来消除警告
        func increment(_ number: inout Int) {
             number += stepSize
        }
        
        // 下面注释这行代码内存访问冲突，increment 内部访问了 stepSize，又将 stepSize 作为 inout 参数传入函数，inout 参数长期传入的参数，内存冲突导致访问将发生运行时错误
        // increment(&stepSize)
        
        
        // 解决方法是将传入的 stepSize copy 一份
        var stepSizeCopy = stepSize
        increment(&stepSizeCopy)
        
        func balance(_ x: inout Int, _ y: inout Int) {
            let sum = x + y
            x = sum / 2
            y = sum - x
        }
        var playerOneScore = 42
        var playerTwoScore = 30
        balance(&playerOneScore, &playerTwoScore) // 正常，两个不同变量
        // balance(&playerOneScore, &playerOneScore) // 编译报错，同一个变量禁止同时传入两个 inout 参数，因为会对同一个变量内存访问冲突
    }
}
