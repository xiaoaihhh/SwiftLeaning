//
//  OpaqueTypes.swift
//  SwiftLeaningKit
//
//  Created by performance on 2021/6/4.
//  Copyright © 2021 SwiftLeaning. All rights reserved.
//

import Foundation


/// 不透明类型
struct OpaqueTypesTest: Runable {
    typealias T = Int
    static func run() {
        print("\n\n=================== Opaque Types ====================")
    }
    
    /// 具有不透明返回类型的函数或方法会隐藏返回值的类型信息。函数不再提供具体的类型作为返回类型，而是根据它支持的协议来描述返回值。在处理模块和调用代码之间的关系时，隐藏类型信息非常有用，因为返回的底层数据类型仍然可以保持私有。而且不同于返回协议类型，不透明类型能保证类型一致性 —— 编译器能获取到类型信息，同时模块使用者却不能获取到。
    
    
    static func returningAnOpaqueType() {
        /// 对于协议中使用了 Self 或者关联类型，则协议只能作为泛型约束使用，因为编译器无法推断类型信息，具体看下面两个例子
        
        // 例子1: 作为参数类型
        // func appendTest0(_ a: Appendable) {} // 编译报错 Protocol 'Appendable' can only be used as a generic constraint because it has Self or associated type requirements
        /// 使用泛型并加上约束条件可以解决上述编译报错问题，令泛型遵守 Appendable 协议
        func appendTest1<T: Appendable>(_ a:T) { } // Appendable 作为泛型约束编译正常
        func appendTest2<T>(_ a:T) where T: Appendable { } // Appendable 作为泛型约束编译正常
        
        
        // 例子2: 作为返回值类型
        struct A: Appendable {
            func append(t1: A, t2: A) {
            }
        }
        // func appendTest3() -> Appendable { A() } // 编译报错 Protocol 'Appendable' can only be used as a generic constraint because it has Self or associated type requirements
        /// 使用不透明类型可以解决上述编译报错问题，在返回值 -> 后面使用 some 关键词修饰，不透明类型约定只能返回一个类型，编译器能推断出类型信息
        func appendTest4() -> some Appendable { A() }
        
        struct B: Appendable {
            func append(t1: B, t2: B) {
            }
        }
        // 下面代码编译报错，因为不透明类型只能返回一个类型，下面代码可能返回两个A或者B，A和B类型不一样，Function declares an opaque return type, but the return statements in its body do not have matching underlying types
        // let condition = true
        // func appendTest5() -> some Appendable {
        //    if condition {
        //        return A()
        //    }
        //    return B()
        //}
        
        /// some 只能修饰属性、下标（subscript）、返回值。
        //  some 修饰函数参数，编译报错：'some' types are only implemented for the declared type of properties and subscripts and the return type of functions
        // func aaa(a: some Appendable) { }
        struct C {
            var append: some Appendable = B()
            var append1: some Appendable {
                B()
            }
            
            subscript(_ index: Int) -> some Appendable {
                return A()
            }
        }
        
        
        /// 不透明类型和协议类型的区别
        /// 1. 不透明类型只能对应一个具体的类型，即使函数调用者并不知道是哪一种类型；协议类型可以同时对应多个类型，只要它们都遵循同一协议即可。协议类型更灵活性，底层类型可以存储更多样的值，而不透明类型对这些底层类型有更强的限定。
        /// 2. 使用了 Self 或者关联类型的协议不能直接作为函数参数或者返回值，因为编译器无法推断类型信息；如果作为函数参数只能使用泛型约束来解决编译器无法推断类型信息问题，如果作为函数返回值，可以使用泛型约束、也可以使用不透明类型来解决编译器无法推断类型信息问题。
    }
}


protocol Appendable {
//    associatedtype T
//    func append(t1: T, t2: T)
    func append(t1: Self, t2: Self)
}
