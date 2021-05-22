//
//  Inheritance.swift
//  SwiftLeaningKit
//
//  Created by performance on 2021/5/21.
//  Copyright © 2021 SwiftLeaning. All rights reserved.
//

import Foundation

struct InheritanceTest: Runable {
    static func run() {
        print("\n\n=================== Inheritance ====================")
        defineSubClassTest()
        overridingTest()
        overridingPropertyGettersandSettersTest()
        overridingPropertyObserversTest()
        callOrderTest()
    }
    
    /// 1. Swift  中只有类可以被继承，结构体和枚举其他类型不能被继承；
    /// 2. Swift 中的类并不是从一个通用的基类继承而来的，如果不给自定义的类指定一个超类的话，这个类就会自动成为基类。
    
    
    /// 继承定义
    static func defineSubClassTest() {
        print("\n-----------------继承：继承定义----------------")
        class Superclass {
        }
        
        // 为了指明某个类的超类，将超类名写在子类名的后面，用冒号分隔
        class SubClass: Superclass {
        }
    }
    
    
    /// 重写
    /// 1. 子类可以重写父类的属性、方法、下标，如果重写某个特性，需要使用 override 关键词
    /// 2. 子类可以通过 super 关键词访问父类的方法、属性、下标；1） 通过 super.someMethod() 访问父类的方法； 2）通过 super.someProperty 访问父类的属性； 3） 通过 super[someIndex] 来访问父类的下标
    /// 3. 如果属性、方法、下标不想被重写，类不想被继承，可以使用 final 标记，例如 final var、final func、final class func、 final subscript、final class SomeClass。static 修饰的类型方法、下标、存储属性无法被重写。
    static func overridingTest() {
        print("\n-----------------继承：重写测试----------------")
        class Superclass {
            func someMethod() {
                print("SuperClass-someMethod")
            }
            
            // 使用 final 修饰无法被重写
            final func someFinalMethod() {
                print("SuperClass-someMethod")
            }
            
            // static修饰的类型方法无法被重写
            static func someTypeMethod() {
                print("SuperClass-someMethod")
            }
            
            // class 修饰的类型方法可以被访问
            class func someTypeMethod1() {
                print("SuperClass-someMethod")
            }
            
            var x = 0
            subscript(index: Int) -> Int {
                get { x }
                set { x = index * newValue }
            }
            
            // 静态下标无法被重写
            static subscript(index1: Int) -> Int {
                get { 10 }
                set {  }
            }
        }
        
        class SubClass: Superclass {
            // 重写实例方法
            override func someMethod() {
                super.someMethod()
            }
            
            // 重写类型方法
            override static func someTypeMethod1() {
                print("SuperClass-someMethod")
            }
            
            // 重写下标，如果父类是读写的子类也需要是读写的；如果父类是只读的，则子类可以是只读的，也可以是读写的
            override subscript(index: Int) -> Int {
                get { super[index] }
                set { super[index] = newValue }
            }
        }
    }
    
    
    /// 重写属性的 Getter 和 Setter
    /// 1. 无论父类是存储属性还是计算属性（不能是变量，变量无法被重写），子类都可以重写为计算属性； 如果父类是存储属性，则子类无法重写为存储属性。子类并不知道继承来的属性是存储型的还是计算型的，它只知道继承来的属性会有一个名字和类型，在重写一个属性时，必须将它的名字和类型都写出来，这样才能使编译器去检查重写的属性是与超类中同名同类型的属性相匹配的。
    /// 2. 如果在重写属性中提供了 setter，那么也一定要提供 getter。
    static func overridingPropertyGettersandSettersTest() {
        print("\n-----------------继承：重写属性的 Getter 和 Setter 测试----------------")
        class Superclass {
            var x = 10
            var y: Int {
                x
            }
            private(set) var z = 100
            
            // 常量无法被重写
            let i = 20 //
            
            // 类型存储属性只能用 static 修饰；类型计算属性可以使用 class 修饰；只有 class 修饰的类型计算属性才可以被重写
            static let j = 20
            static var k = 100
            static var h: Int {
                get { k }
                set { k = newValue }
            }
            class var m: Int {
                get { k }
                set { k = newValue }
            }
        }
        
        class SubClass: Superclass {
            // 将存储属性重写为计算属性
            override var x: Int {
                get { super.x }
                set { super.x = newValue }
            }
            
            // 将只读计算属性重写为读写计算属性，如果父类是读写的无法重写为只读
            override var y: Int {
                get { super.y }
                set { } // // 这里 super.y = newValue 报错，因为父类是只读的
            }
            
            // 将只读存储属性重写为读写计算属性，如果父类是读写的无法重写为只读
            override var z: Int {
                get { super.z }
                set { } // 这里 super.z = newValue 报错，因为父类是只读的
            }
            
            // class 修饰的类型计算属性可以被重写
            override class var m: Int {
                get { super.m }
                set { super.m = newValue }
            }
        }
    }
    
    /// 重写属性观察器
    /// 1. 通过重写属性为一个继承来的属性添加属性观察器，无论被继承的属性原本是如何实现的，当其属性值发生改变时，就会被通知。、
    /// 2. 不可以为继承来的常量存储型属性或只读计算型属性添加属性观察器，这些属性的值是不可以被设置的，为它们提供 willSet 或 didSet 实现是不恰当。
    /// 3. 不可以同时提供重写的 setter 和重写的属性观察器，如果想观察属性值的变化，并且已经为那个属性提供了定制的 setter，那么在 setter 中就可以观察到任何值变化了。
    static func overridingPropertyObserversTest() {
        print("\n-----------------继承：重写属性观察器测试----------------")
        class Superclass {
            // 常量存储型属性无法添加属性观察器
            let x = 0
            static let y = 10
            
            // 只读计算属性无法添加属性观察器
            var z: Int {
                x
            }
            class var h: Int {
                y
            }
            
            // 只读存储属性无法添加属性观察器
            private(set) var m = 1
            
            // 其它可被重写的情况（可以参考重写 setter 和 getter 部分）可以添加属性观察器
            var i = 10 // 读写实例存储属性
            var j: Int { // 读写实例计算属性
                get { i }
                set { i = newValue }
            }
            class var k: Int { // 读写类型计算属性
                get { y }
                set {  }
            }
            
            
        }
        class SubClass: Superclass {
            override var i: Int {
                willSet { }
                didSet {}
            }
            override var j: Int {
                willSet { }
                didSet { }
            }
            override class var k: Int {
                willSet { }
                didSet { }
            }
        }
    }
    
    
    /// 属性 Getter / Setter / willSet / didSet 调用顺序
    static func callOrderTest() {
        print("\n-----------------继承：Getter / Setter / willSet / didSet 调用顺序测试----------------")
        class Superclass {
            var x = 0 {
                willSet { print("Superclass-willSet-x") }
                didSet { print("Superclass-didSet-x") }
            }
            var y: Int {
                get { print("Superclass-Getter-y"); return 10 }
                set { print("Superclass-Setter-y") }
            }
            
            var z: Int {
                get {
                    print("Superclass-Getter-z")
                    return 100
                }
                set {
                    print("Superclass-Setter-z")
                }
            }
        }
        class SubClass: Superclass {
            override var x: Int {
                willSet { super.x = 100; print("SubClass-willSet-x") }
                didSet { print("SubClass-didSet-x") }
            }
            
            override var y: Int {
                get {
                    print("SubClass-Getter-y")
                    return super.y
                }
                set {
                    print("SubClass-Setter-y")
                    super.y = newValue
                }
            }
            
            override var z: Int {
                willSet { print("SubClass-willSet-z") }
                didSet { print("SubClass-didSet-z", oldValue) }
            }
        }
        
        let cls1 = SubClass()
        cls1.x = 10
        // willSet 先调用子类->在调用父类
        // didSet 先调用父类->在调用子类
        
        print("\n-------------\n")
        let _ = cls1.y
        print("\n-------------\n")
        cls1.y = 20
        // Getter/Setter 如果子类调用super: 先调用子类->在调用父类; 如果子类不调用super则可以中断调用父类；
       
        print("\n-------------\n")
        cls1.z = 100
        // 计算属性设置值：Getter（属性观察器中使用了 oldValue，不使用不会调用） -> willSet -> Setter -> didSet
        // 存储属性设置值：Setter -> willSet -> didSet
    }
}
