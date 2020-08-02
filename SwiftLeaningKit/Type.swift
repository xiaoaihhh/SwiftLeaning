//
//  TypeCasting.swift
//  SwiftLeaningKit
//
//  Created by fanshuaifei on 2020/7/26.
//  Copyright © 2020 SwiftLeaning. All rights reserved.
//

import Foundation
import UIKit

// https://stackoverflow.com/questions/37401959/how-can-i-get-the-memory-address-of-a-value-type-or-a-custom-struct-in-swift
func address(_ o: UnsafePointer<Void>) -> Int {
    unsafeBitCast(o, to: Int.self)
}

func addressHeap<T: AnyObject>(_ o: T) -> Int {
    return unsafeBitCast(o, to: Int.self)
}

struct myStruct {
    var a: Int
}

class myClas {

}

protocol Printable {
    func printMessage()
}

struct TypeCasting: Printable {
    func printMessage() {
       
        print("printMessage:\(self.self)")
    }
    
    var age = 10
    static var count = 2
    func test() {
//        print(self.age)
//        // 访问count的时候，一般通过类名直接访问
//        print(Person.count)
//        // 也可以使用 Self 访问
//        print(Self.count)
    }
}

class SomeBaseClass {
    class func classMethod() {
        print("this is classMethod")
    }
    
    func instanceMethod() {
        print("this is instanceMethod")
    }
}
class SomeSubClass: SomeBaseClass {
    override class func classMethod() {
        print("SomeSubClass")
    }
}

public struct TypeCastingTest: Runable {
    public static func run() {
//        print(NSString(format: "%p", unsafeBitCast(SomeBaseClass.self, to: Int.self))) // -> 0x7fd5c8700970
//        print(NSString(format: "%p", unsafeBitCast(SomeBaseClass.self, to: Int.self))) // -> 0x7fd5c8700970
//        print(NSString(format: "%p", unsafeBitCast(SomeBaseClass.Type.self, to: Int.self))) // -> 0x7fd5c8700970
//        print(NSString(format: "%p", unsafeBitCast(SomeBaseClass.Type.self, to: Int.self)))
//        print(NSString(format: "%p", unsafeBitCast(SomeBaseClass.Type.Type.self, to: Int.self)))
//        print(NSString(format: "%p", unsafeBitCast(SomeBaseClass.Type.Type.self, to: Int.self)))
//        print(NSString(format: "%p", unsafeBitCast(SomeBaseClass.Type.Type.Type.self, to: Int.self))) // -> 0x7fd5c8700970
//        print(NSString(format: "%p", unsafeBitCast(SomeBaseClass.Type.Type.Type.self, to: Int.self)))
//        print(NSString(format: "%p", unsafeBitCast(SomeBaseClass.Type.Type.Type.Type.Type.Type.Type.Type.Type.self, to: Int.self)))
//        print(NSString(format: "%p", unsafeBitCast(SomeBaseClass.Type.Type.Type.Type.Type.Type.Type.Type.Type.self, to: Int.self)))
        var some = SomeBaseClass()
        if some === some.self {
            print("")
        }
        some.instanceMethod()
        // 获取类类型
        var classType: SomeBaseClass.Type = type(of: some)
        var classType1: SomeBaseClass.Type = type(of: some)
        classType.classMethod()
        // 获取元类类型
        var metaClassType = type(of: classType);
        var metaClassType111 = type(of: metaClassType);
    }
}



public struct Student: Runable {
    var name: String?
    
    var hello = "hello"    // 定义一个变量，可以修改，此处使用了类型推断，推断为 String 类型
    let maxNum = 10 // 定一个常量，不能在修改，此处使用了类型推断，推断为 Int 类型
    
    public static func run() {
        //        let a = Student
        let b = Student.self
        let c = Student.init(name: "xiaoming")
        let d = b.init(name: "xiaohong")
        
        var message: String //显示指定为 String 类型，后续可以将 String 对象赋值给改变量
        var age: Int = 0 // 显示指定为 Int 类型，并初始化为 0
        
        var scale1 = 3.0 // 默认推断为 Double 类型
        var scale2: Float = 1.0 // 显示指定为 Float 类型
        scale2 = 2.0 // 这里 2.0 被推断为 Float，因为 scale2 是 Float 类型
        
        // Swift 是强类型语言，禁止一切默认类型转换，你需要清楚知道自己每一个变量的类型，需要类型转换时候需要显示转换
        //        scale1 = scale2 //Cannot assign value of type 'Float' to type 'Double'
        scale1 = Double(scale2) // 显示转换为Double
        
        let http404Error = (404, "Not Found") // 类型为 (Int, String)
        print("code:\(http404Error.0), message:\(http404Error.1)") // 可以通过.0, .1 访问对应位置元素
        
        var http404Error1 = (statusCode: 404, statusMessage: "Not Found")//为元组元素指定名字,类型为(Int,String)
        print("code:\(http404Error1.statusCode), message:\(http404Error1.statusMessage)") // 通过名字访问
        
        http404Error1 = http404Error // 由于两个元组类型都是 (Int, String)，因此可以赋值
        let (statusCode, statusMessage) = http404Error1 // 可以将元组分解成不同的变量或常量
        
        var card: String? = "1234567890" // 定义一个可选值，并初始化
        card = nil // 通过将 card 赋值为 nil，表示 card 值缺失
        
        
        message = ""
        age = 1
        var nnnn: String? = nil
        var array: NSArray = [nnnn]
        if array[0] is NSNull {
            print("")
        }
        print(array)
        
    }
}




/*
 Self Test
 */

struct SelfTest: Runable {
    static func run() {
        
    }
}

protocol ProtocolA {
    func createInstance() -> Self
//    var instance111: Self? { get } //会报错在class中没用final标记，后查原因
}

struct BigCake: ProtocolA {
//    var instance111: Self? {
//        return self
//    }
    
    static func printMessage() { }
    
    static func printMessage1() {
        Self.printMessage()
    }
    
    func printMessage2() {
        Self.printMessage()
    }
    
    func createInstance() -> Self {
        return Self()
    }
    
    static func printCakeMessage(cake: Self) {
        print(cake)
    }
    
    func becomeBigger() {
        Self.printCakeMessage(cake: self)
    }
}

class SmallCake: ProtocolA {
    
//    var instance111: SmallCake? {
//        return self
//    }
//
    var cake111: Self {
        return self
    }
    
    required init() {
        
    }
    func createInstance() -> Self {
        return Self() // 这里必须使用 required 构造器，避免子类等未实现
    }
    
    var cake: Self {
        return self
    }
    
    static func printCakeMessage(cake: SmallCake) {
        print(cake)
    }
    
    func becomeBigger() {
        Self.printCakeMessage(cake: self)
    }
}

final class SmallOneCake: SmallCake {
    static func printCaakeMessage(cake: SmallCake) {
        print(cake)
    }
    required init() {
        
    }
    override func createInstance() -> SmallOneCake {
        return SmallOneCake()
    }
    
    override var cake: Self {
        return self
    }
    
    var naem: String?
    
    override func becomeBigger() {
        Self.printCakeMessage(cake: self)
    }
}
