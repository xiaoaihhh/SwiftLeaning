//
//  Deinitialization.swift
//  SwiftLeaningKit
//
//  Created by performance on 2021/5/18.
//  Copyright © 2021 SwiftLeaning. All rights reserved.
//

import Foundation

struct DeinitializationTest: Runable {
    static func run() {
        print("\n\n=================== Deinitialization ====================")
        deinitTest()
    }
    
    /// 析构器只适用于类类型，当一个类的实例被释放之前，析构器会被立即调用，析构器用关键字 deinit 来定义。
    static func deinitTest() {
        class Animal {
            var color: String?
            
            func eat() {
            }
            
            deinit {
                // 析构器可以访问实例的所有属性、方法，因为直到实例的析构器被调用后，实例才会被释放
                eat()
                let _ = color
                print("Animal deinit")
            }
        }
        
        class Cat: Animal {
            deinit {
                print("Cat deinit")
            }
        }
        // 析构器是在实例释放前被自动调用的，不能主动调用析构器。子类继承了父类的析构器，先调用子类析构器，在调用父类析构器，即使子类没有提供自己的析构器，父类的析构器也同样会被调用。
        _ = Cat()
    }
}
