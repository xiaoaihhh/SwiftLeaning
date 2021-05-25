//
//  Type.swift
//  SwiftLeaningKit
//
//  Created by fanshuaifei on 2021/5/25.
//  Copyright © 2021 SwiftLeaning. All rights reserved.
//

import Foundation

struct TypeTest: Runable {
    static func run() {
        print("\n\n=================== 类型 ====================")
        typeCheckingTest()
        typeCastingTest()
    }
    
    class Animal {
        var name: String?
    }
    
    class Dog: Animal {
        func bark() {
            print("Dog wang wang wang")
        }
    }
    
    class Cat: Animal {
        func eat() {
            print("Cat eat fish")
        }
    }
    
    
    /// 类型检查
    /// 通过类型检查操作符（is）来检查一个实例是否属于特定子类型。若实例属于那个子类型，类型检查操作符返回 true，否则返回 false
    static func typeCheckingTest() {
        print("\n-----------------类型：类型判断----------------")
        let animals = [Dog(), Cat(), Dog(), Dog(), Cat()]
        var dogCount = 0
        var catCount = 0
        
        for animal in animals {
            if animal is Dog {
                dogCount += 1
            } else if animal is Cat {
                catCount += 1
            }
        }
        print("dogCount:\(dogCount), catCount\(catCount)")
    }
    
    /// 类型转换
    /// 可以使用类型转换操作符（as? 或 as!）转换成实例的真实类型。转换没有真的改变实例或它的值，根本的实例保持不变，只是简单地把它作为被转换成的类型来使用。
    //   1. as? 转换成功返回转换类型的可选值，转换失败返回 nil，如果不确定类型转型是否可以成功时使用 as?，根据转换后是否为 nil 判断是否转换成功。
    //   2. as! 将类型转换和强制解包结果结合为一个操作，转换成功返回要转换的类型，转换失败发生运行时错误。只有可以确定类型转型一定会成功时，才使用 as!。
    //   3. as 本身没法做类型转换，但是可以将一个类型当作另一个类型使用
    //   4. as? 和 as!是在运行时进行类型转换的，as 可以理解为在编译期间来确定类型，如果编译期间无法将一个类型当作另一个类型使用，则报错
    static func typeCastingTest() {
        print("\n-----------------类型：类型转换----------------")
        let animals = [Dog(), Cat(), Dog(), Dog(), Cat()]
        for animal in animals {
            if let dog = animal as? Dog { // 不确定是否能转换成功，使用 as? 返回可选值
                dog.bark()
            } else if let cat = animal as? Cat {
                cat.eat()
            }
        }
        
        let dog:Animal = Dog()
        (dog as! Dog).bark() // 一定能转换成功，可以使用 as!，如果转换失败则发生运行时错误
        
        
        let num1 = 0 // Int 类型
        let num2 = 0 as Double // Double 类型
        // let _ = 0 as Animal // 编译报错，无法将 0 当作 Animal 类型使用； 如果使用 as？ 则运行时转换失败；使用 as! 则发生运行时错误。
        print("num1 type is \(type(of: num1)); num2 type is \(type(of: num2))")
    }
    
    
    /// Any 和 AnyObject，
    /// Any 表示任何类型，例如结构体、枚举、类、函数、闭包
    /// AnyObject 表示任何类类型
    static func  anyAndAnyObjectTest() {
        print("\n-----------------类型：Any and AnyObject----------------")
        var things:[Any] = []
        things.append(0)
        things.append(0.0)
        things.append(42)
        things.append(3.14159)
        things.append("hello")
        things.append((3.0, 5.0))
        things.append(Dog())
        things.append({print("closure")})
    }
}

