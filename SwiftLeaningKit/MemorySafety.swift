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
        conflictingAccessToSelfInMethodsTest()
        conflictingAccessToPropertiesTest()
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
        
        
        var playerOneScore = 42
        var playerTwoScore = 30
        balance(&playerOneScore, &playerTwoScore) // 正常，两个不同变量
        // balance(&playerOneScore, &playerOneScore) // 编译报错，同一个变量禁止同时传入两个 inout 参数，因为会对同一个变量内存访问冲突
    }
    
    
    /// mutating 方法的内存访问冲突
    static func conflictingAccessToSelfInMethodsTest() {
        struct SomeStruct {
            var x = 0
            var y = 0
            mutating func modify(_ s: inout SomeStruct) {
                
            }
        }
        
        var s = SomeStruct()
        // s.modify(&s) // 编译报错 Inout arguments are not allowed to alias each other;  Overlapping accesses to 's', but modification requires exclusive access; consider copying to a local variable
    }
    
    
    /// 属性内存访问冲突
    /// 结构体、元组、枚举的类型都是由多个独立的值组成，例如结构体的属性或元组的元素。因为它们都是值类型，修改值的任何一部分都是对于整个值的修改，意味着其中一个属性的读或写访问都需要访问整一个值。例如，元组元素的写访问重叠会产生冲突
    static func conflictingAccessToPropertiesTest() {
          // 运行时错误，Simultaneous accesses to 0x10ba338f0, but modification requires exclusive access
        
        /// 实践中，如果是局部变量，大多数对于结构体属性的访问都会安全的重叠。局部变量直接创建在栈上，比如结构属性、元组元素，都是顺序存储在栈上的，本质是直接访问栈上的属性变量的地址。
        var playerInformationLocal = (health: 10, energy: 20)
        balance(&playerInformationLocal.health, &playerInformationLocal.energy) // 可以安全重叠访问
        
        balance(&playerInformation.health, &playerInformation.energy)
    }

}
var playerInformation = (health: 10, energy: 20)

func balance(_ x: inout Int, _ y: inout Int) {
    let sum = x + y
    x = sum / 2
    y = sum - x
}
