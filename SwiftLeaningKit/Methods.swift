//
//  Methods.swift
//  SwiftLeaningKit
//
//  Created by performance on 2021/5/13.
//  Copyright © 2021 SwiftLeaning. All rights reserved.
//

import Foundation

struct MethodsTest: Runable {
    static func run() {
        print("\n\n=================== Methods ====================")
        instanceMethodsTest()
        typeMethodsTest()
        selfTest()
        modifyingValueTypesFromWithinInstanceMethods()
    }
    
    // 方法是与特定类型相关联的函数。Swift可以为类、结构体、枚举定义方法，Objective-C 只能给类定义方法。
    // 1. 实例方法（Instance Methods）: 为给定类型的实例相关联。 相当于 Objective-C 中的实例方法（instance methods）。
    // 2. 类型方法（Type Methods）: 与类型本身相关联。相当于 Objective-C 中的类方法（class methods）。
    
    /// 实例方法，定义和函数完全一样，只是定义在特定类型内部，即定义的函数与某个类型相关联了。
    static func instanceMethodsTest() {
        print("\n-----------------方法：实例方法----------------")
        class Counter {
            var count = 0
            func increment() {
                count += 1
            }
            func increment(by amount: Int) {
                count += amount
            }
        }
        // 通过点语法调用
        let counter = Counter()
        counter.increment()
        counter.increment(by: 10)
    }
    
    /// 类型方法，定义和函数完全一样，只是定义在特定类型内部，即定义的函数与某个类型相关联了。
    static func typeMethodsTest() {
        print("\n-----------------方法：类型方法----------------")
        // 通过关键字 static 或者 class 来指定类型方法。
        // 1. static：可以用在类、结构体、枚举，如果用在类上，子类不可以overrid这个类型方法；
        // 2. class：只能用于类，允许子类重写父类该方法的实现；
        class SomeClass {
            static func someTypeMethod() {
            }
            class func someTypeMethod1() {
            }
        }
        // 通过点语法调用
        class SomeClassSubClass: SomeClass {
            // override static func someTypeMethod() { // 编译报错，static修饰的无法 overrid
            // }
            override static func someTypeMethod1() { // 子类既可以使用class，也可以使用 static，使用 static 该类的子类无法 overrid 改类型方法；
            }
        }
    }
    
    // self属性
    static func selfTest() {
        print("\n-----------------方法：self 属性----------------")
        // 1. 实例方法或者构造函数的方法体（body）中，self 属性指向这个实例本身
        // 2. 类型方法的方法体（body）中，self 属性指向这个类型本身
        class Counter {
            var count = 0
            private static let maxCount = Int.max
            init(count: Int) {
                self.count = count // 消除歧义，因为参数和属性同名
            }
            func increment(by amount: Int) {
                count += amount
            }
            func increment() {
                self.increment(by: 1) // 通过self显示调用increment(by:)方法
                // 不必在代码里面经常写 self，在一个方法中使用一个已知的属性或者方法名称，即使没有明确地写 self，Swift 假定使用当前实例的属性或者方法。
                increment(by: 0)
            }
            
            
            static func getMaxCount() -> Int {
                print(maxCount) // 类型方法中直接访问类型属性
                print(Counter.maxCount) // 通过类型名字访问
                return self.maxCount // self 表示类型本身，可以调用类型属性 maxCount
            }
            
            static func printMaxCount() {
                print(getMaxCount()) // 类型方法中直接类型方法
                print(Counter.getMaxCount()) // 通过类型名字访问
                print(self.getMaxCount()) // self 表示类型本身，可以调用类型方法
            }
        }
    }
    
    // 在实例方法中修改值类型
    static func modifyingValueTypesFromWithinInstanceMethods() {
        print("\n-----------------方法：实例方法中修改值类型 ----------------")
        // 默认情况下，值类型的属性不能在它的实例方法中被修改。如果需要在某个特定的方法中修改结构体或者枚举的属性，可以为这个方法选择 可变（mutating）行为，然后就可以从其方法内部改变它的属性；方法还可以给它隐含的 self 属性赋予一个全新的实例，这个新实例在方法结束时会替换现存实例。
        struct Point {
            var x = 0
            var y = 0
            mutating func setX(x: Int) { // 修改属性
                self.x = x
            }
            mutating func setNewPoint(point: Point) { // 修改 self
                self = point
            }
            // static mutating func test() {} // 类型方法无法使用 mutating 修饰，Static functions must not be declared mutating
        }
        
        var point = Point(x: 10, y: 10) // 必须是 变量+mutating 才可以修改
        print(point)
        point.setX(x: 20)
        print(point)
        point.setNewPoint(point: Point(x: 30, y: 30))
        print(30)
        
        let point2 = Point(x: 3, y: 3)
        //  point2.setX(x: 20) // let 类型不可以修改
        print(point2)
    }
    
}
