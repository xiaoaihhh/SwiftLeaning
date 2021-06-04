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
        struct A: Appendable {
            func append(t1: A, t2: A) {
                
            }
        }
        func append<T: Appendable>(a:T) {
//            return A()
        }
    }
}


protocol Appendable {
//    associatedtype T
//    func append(t1: T, t2: T)
    func append(t1: Self, t2: Self)
}
