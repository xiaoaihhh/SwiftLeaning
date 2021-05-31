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
        anyAndAnyObjectTest()
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
        things.append(-3.14159)
        things.append("hello")
        things.append((3.0, 5.0))
        things.append(Dog())
        things.append({print("closure")})
        
        // Any 还可以表示可选类型。Swift 会在用 Any 类型来表示一个可选值的时候，给你一个警告。如果确实想使用 Any 类型来承载可选值，可以使用 as 操作符显式转换为 Any。
        let optionalNumber: Int? = 3
        // things.append(optionalNumber) // 编译器警告 Expression implicitly coerced from 'Int?' to 'Any'
        things.append(optionalNumber as Any)
        
        for thing in things {
            switch thing {
            case 0 as Int:
                print("zero as an Int")
            case 0 as Double:
                print("zero as a Double")
            case is Optional<Int>:
                print("Optional<Int> type")
            case let someInt as Int:
                print("an integer value of \(someInt)")
            case let someDouble as Double where someDouble > 0.0:
                print("a positive double value of \(someDouble)")
            case is Double:
                print("double type")
            case let someString as String:
                print("a string value of \"\(someString)\"")
            case let (x, y) as (Double, Double):
                print("an (x, y) point at \(x), \(y)")
            case let dog as Dog:
                dog.bark()
            case let closure as () -> ():
                closure()
            default:
                print("non match")
            }
        }
    }
    
    static func selfSelfTypeAnyclassTest() {
        let person = Person(name: "")
        person.self.eat()
    }
}


/// 1. self:：实例方法中代表实例本身，类型方法中代表类型本身；
/// 2. Self：实例方法和类型方法中都代表类型本身。Self 一般作为返回值或者参数类型，表示返回值或者参数必须是当前类型
/// 3. 元类型：指任意类型的类型，包括类类型、结构体类型、枚举类型和协议类型。
///   3.1  Type：通过 .Type 获取类、结构体、枚举的元类型
///   3.2  Protocol：通过 .Protocol 获取协议类型的元类型
//TODO

class Person {
    private static let totalPeoples: Int64 = 6000000000
    private let name: String
    init(name: String) {
        self.name = name // 实例方法：self 表示当前实例
    }
    static func getTotalPeoples() -> Int64 {
//        Self.totalPeoples //
        return self.totalPeoples // 静态方法： self 表示当前类型
    }
    func eat() {
//        Self.totalPeoples
    }
}

