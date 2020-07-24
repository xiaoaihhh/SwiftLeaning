//
//  SwiftLeaningKit.swift
//  SwiftLeaningKit
//
//  Created by fanshuaifei on 2020/7/24.
//  Copyright © 2020 SwiftLeaning. All rights reserved.
//


public protocol Runable {
    // 1. protocol 定义的属性函数等无法使用 public/private 等访问控制修饰符
    // 2. public/private 等只能用于整个协议定义前，实现协议对象的方法必须使用高于或者等于修饰协议的访问修饰词，例如该协议使用 internal 修饰，则实现该协议的方法前面必须使用 internal/public 等修饰词，使用较低的修饰词报错
    // 3. 协议扩展作为默认实现，修饰词不受限制，定义扩展前修饰级别是所有默认函数的修饰级别，函数可以单独定义访问级别，如果作为协议声明的默认实现，访问级别比协议定义的访问级别低的话，则不能对外暴露，起不到默认实现作用
    static func run()
   
}

internal extension Runable {
    private static func run() {
        assert(false, "default run.")
    }
}


protocol Caculatorable {
    func add(num1: Int, num2: Int) -> Int
}

extension Caculatorable {
    func add(num1: Int, num2: Int) -> Int {
        return num1 + num2
    }
}

public class SwiftLeaningKit1 {
    public init() {
        
    }
}
