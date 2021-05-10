//
//  Functions.swift
//  SwiftLeaningKit
//
//  Created by fanshuaifei on 2020/8/2.
//  Copyright © 2020 SwiftLeaning. All rights reserved.
//

import Foundation

struct Functions: Runable {
    static func run() {
        func greet(person: String) {
            print("Hello, \(person)!")
        }
        
        func add(num1: Int, num2: Int) -> Int {
            num1 + num2
        }
        
        func returnTuple() -> (Int, String) {
            return (1, "hello")
        }
        
        
        //        someFunction(1)
        someFunction(1, 2)
        let value = greet(person: "hello")
        print(value)
        
        printObjects(objects: NSObject.init(), NSObject.init(), max: 5)
        
        if #available(iOS 10, *) {
            // 处理高于和等于 iOS10 的系统
        } else {
            // 处理低于 iOS10 的系统
        }
        
        var age = 4
        // 传入参数只能是 var 类型，不能是 let 或者字面量
//        modifyAge(&age)
    }
    
    static func someFunction(num: Int = 10, name: String) {
    }
    
    static func someFunction(_ num: Int = 10, _ num1: Int) {
    }
    
    static func printObjects(objects: AnyObject..., max: Int) {
        // Swift 中可变参数是一个数组，所有参数存储在数组中
        // Swift 中可变参数通过在类型后面加 … 来表示，且访问起来极其方便；
        // 函数只能定一个一个可变参数；
        // 可变参数不要求一定放在函数结尾，可函数默认值类似，只要调用时没有语义冲突就可以。
        
        for obj in objects {
            print(obj)
        }
    }
    
   
    func modifyAge(_ age: inout Int) {
        // 这里将 age 修改为 10
        // 调用 modifyAge，传入参数需要加 &，表明参数能被修改
        age = 10
    }
    
    
    
    func someFunction(age: Int) {
        // 参数默认为 let 类型，禁止修改变量，
        // 一方面可以让编译根据copy on write 特性更好的优化内存，
        // 另一方面使得内存访问也更加安全，可读性也会变高，避免了拿输入参数作为其它的各种用途使用。
//        age = 10
    }

}
