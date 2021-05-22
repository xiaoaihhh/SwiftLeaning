//
//  Properties.swift
//  SwiftLeaningKit
//
//  Created by performance on 2021/5/13.
//  Copyright © 2021 SwiftLeaning. All rights reserved.
//

import Foundation

struct PropertiesTest: Runable {
    static func run() {
        print("\n\n=================== Properties ====================")
        storedPropertiesTest()
        lazyStoredPropertiesTest()
        computedPropertiesTest()
        propertyObserversTest()
        computedPropertiesObserversTest()
        inoutPropertyObserversTest()
        globalAndLocalVariablesTest()
        typePropertiesTest()
    }
    
    //    1. 属性：将值与特定的类、结构体或枚举关联，通常与特定类型的实例关联
    //      1）存储属性：将常量和变量存储为实例的一部分，可以用于类和结构体；
    //      2）计算属性：直接计算（而不是存储）值，可以用于类、结构体和枚举；
    //    2. 属性也可以直接与类型本身关联，这种属性称为类型属性。
    //    3. 在初始化类或结构体的实例时，必须为所有的存储属性设置初始值，可以在构造器中初始化，也可以在定义时候设置一个默认值。
    
    /// 存储属性
    /// 将常量和变量存储为实例的一部分，可以用于类和结构体；
    static func storedPropertiesTest() {
        print("\n-----------------属性：存储属性测试----------------")
        struct FixedLengthRange {
            // 存储属性可以是常量，也可以是变量
            var firstValue: Int = 0 // 在定义存储属性的时候指定默认值
            let length: Int
            init(firstValue: Int, length: Int) {
                self.length = length
                self.firstValue = firstValue
            }
        }
        
        var fixed1 = FixedLengthRange(firstValue: 1, length: 10)
        fixed1.firstValue = 2
        let fixed2 = FixedLengthRange(firstValue: 1, length: 10)
        print(fixed2)
        // fixed2.firstValue = 10 // 编译报错，当值类型的实例被声明为常量的时候，它的所有属性也就成了常量；当引用类型的实例被声明为常量的时候，它的变量属性可以修改
    }
    
    
    /// 延迟加载属性（与 Objective-C 中自己定义的懒加载类似）
    /// 延时加载存储属性是指当第一次被调用的时候才会计算其初始值的属性。在属性声明前使用 lazy 来标示一个延时加载存储属性。
    /// 必须将延时加载属性声明成变量（使用 var 关键字），因为属性的初始值可能在实例构造完成之后才会创建赋值，常量属性在构造过程完成之前必须要有初始值，因此无法声明成延时加载。
    /// 延迟加载属性只能用在存储属性，因此只能用在类和结构体上（枚举只能定义计算属性）
    static func lazyStoredPropertiesTest() {
        print("\n-----------------属性：延迟加载属性测试----------------")
        class DataImporter {
            let filename = "DataImporter-filename"
            init() {
                print("DataImporter init")
            }
        }
        
        class DataManager {
            lazy var dataImporter = DataImporter()
            func log() {
                print("Log")
            }
        }
        let dm = DataManager()
        dm.log()
        print("----------")
        print(dm.dataImporter.filename) // 第一次使用 DataImporter 被初始化
        
        // 如果一个被标记为 lazy 的属性在没有初始化时就同时被多个线程访问，则无法保证该属性只会被初始化一次。
        
        // 下面多线程同时访问，有可能能复现被初始化了多次（打印多条DataImporter init）
//        let dm1 = DataManager()
//        for _ in 1...1000 {
//            DispatchQueue.global().async {
//                print(dm1.dataImporter.filename)
//            }
//        }
    }
    
    
    /// 计算属性
    /// 直接计算（而不是存储）值，可以用于类、结构体和枚举；
    /// 计算属性不直接存储值，而是提供一个 getter 和一个可选的 setter，来间接获取和设置其他属性或变量的值。
    static func computedPropertiesTest() {
        print("\n-----------------属性：计算属性测试----------------")
        struct Point {
            var x = 0.0
            var y = 0.0
        }
        struct Size {
            var width = 0.0
            var height = 0.0
        }
        struct Rect {
            var origin = Point()
            var size = Size()
            // 计算属性定义时候必须指定类型；必须声明为 var，包括只读计算属性，因为它们的值不是固定的，let 关键字只用来声明常量属性，表示初始化后再也无法修改的值；
            var center: Point {
                get {
                    print("Rect:center:get")
                    return Point(x: origin.x + size.width / 2.0, y: origin.y + size.height / 2.0)
                }
                set(newCenter) {
                    print("Rect:center:set")
                    origin.x = newCenter.x - (size.width / 2)
                    origin.y = newCenter.y - (size.height / 2)
                }
            }
            
            // 简化 Setter 和 Getter 声明
            // 1. 如果计算属性的 setter 没有定义表示新值的参数名，则可以使用默认名称 newValue。
            // 2. getter 如果是单行表达式，可以省略 return，和函数一样
            var center1: Point {
                get {
                    Point(x: origin.x + size.width / 2.0, y: origin.y + size.height / 2.0)
                }
                set {
                    origin.x = newValue.x - (size.width / 2)
                    origin.y = newValue.y - (size.height / 2)
                }
            }
            
            // 只读计算属性。只有 getter 没有 setter 的计算属性叫只读计算属性。只读计算属性总是返回一个值，可以通过点运算符访问，但不能设置新的值。
            var centerReadOnly: Point {
                get {
                    Point(x: origin.x + size.width / 2.0, y: origin.y + size.height / 2.0)
                }
            }
            var centerReadOnly1: Point {
                // 也可以将 get {} 省略
                Point(x: origin.x + size.width / 2.0, y: origin.y + size.height / 2.0)
            }
        }
        
        var rect = Rect(origin: Point(x: 10, y: 10), size: Size(width: 10, height: 10))
        print(rect.center)
        rect.center = Point(x: 100, y: 100)
        print(rect.center)
    }
    
    
    /// 属性观察器
    /// 属性观察器监控和响应属性值的变化，每次属性被设置值的时候都会调用属性观察器
    static func propertyObserversTest() {
        print("\n-----------------属性：属性观察器测试----------------")
        class Point {
            init(x: Double, y:Double) {
                // 在自身构造器中初始化属性不会触发属性观察器，但如果是类，在父类中如果初始化完成属性，子类构造器中在修改属性会触发属性观察器
                self.x = x
                self.y = y
            }
            // 声明属性观察器时候不影响设置默认值
            var x = 0.0 { // 在定义属性时设置初始值不会触发属性观察器，如果是 lazy 的，在第一次用到属性时初始话属性也不会触发属性观察器
                // willset 在新的值被设置之前调用
                willSet(newX) { // 参数为属性即将设置的新值
                    print("Point-willSet: newX: ", newX)
                    print("Point-willSet: x: ", x)
                }
                // didSet 在新的值被设置之后调用
                didSet(oldX) { // 参数为属性被修改之前的老值
                    print("Point-didSet: oldX: ", oldX)
                    print("Point-didSet: x: ", x)
                }
            }
            var y: Double {
                // willSet 和 didSet 可以省略参数
                willSet {
                    print("Point-willSet: newY: ", newValue) // 使用默认名称 newValue，如果没省略参数，则无法访问newValue
                    print("Point-willSet: y: ", x)
                }
                didSet {
                    print("Point-didSet: oldY: ", oldValue) // 使用默认名称 oldValue，如果没省略参数，则无法访问oldValue
                    print("Point-didSet: y: ", x)
                }
            }
            
            // 在 willset 和 didset 中都可改变当前属性的值，但是不会触发属性观察器; 如果是在子类重写属性的 willSet / didSet / Getter / Setter 中通过 super.z = xxx 设值，则会触发属性观察器；
            var z: Double = 1.0 {
                willSet {
                    print("Point-willSet: newZ: ", newValue)
                    // z = z * 100 // 这里可以修改，但是没有意义，didSet马上回将 z 改成即将设置的新值
                    print("Point-willSet: newZ: ", z)
                }
                didSet {
                    print("Point-didSet: z-before: ", z)
                    z = z * 3
                    print("Point-didSet: z-after: ", z)
                }
            }
            var k = 10
            
        }
        
        let point = Point(x: 10, y: 10)
        print("---------自身构造器中初始化属性不会触发属性观察器\n")
        point.x = 20
        point.y = 20
        print("---------修改属性触发属性观察器\n")
        point.x = 20 // 新值和当前值相同也会触发属性观察器
        print("---------新值和当前值相同也会触发属性观察器\n")
        point.z = 10
        print("---------willset 和 didset 中可改变当前属性的值，但是不会触发属性观察器\n")
        
        class SubPoint: Point {
            override init(x: Double, y: Double) {
                super.init(x: x, y: y)
                self.x = x // 子类构造器中修改父类属性会触发属性观察器
            }
        }
        
        let _ = SubPoint(x: 10, y: 10)
        print("---------子类构造器中修改父类属性会触发属性观察器\n")
    }
    
    
    /// 计算属性观察器测试
    static func computedPropertiesObserversTest() {
        class SomeSuperClass {
            var x = 0
            var y: Int {
                get {
                    print("SomeSuperClass-get-y: ", x)
                    return x
                }
                set {
                    x = newValue
                    print("SomeSuperClass-set-y: ", newValue)
                }
            }
            var z: Int {
                get {
                    print("SomeSuperClass-get-z: ", x)
                    return x
                }
                set {
                    x = newValue
                    print("SomeSuperClass-set-z: ", newValue)
                }
            }
        }
        
        class SomeSubClass: SomeSuperClass {
            override var x: Int {
                willSet {
                    print("SomeSuperClass-willSet-x: ", newValue)
                }
                didSet {
                    print("SomeSuperClass-didSet-x: ", oldValue)
                }
            }
            override var y: Int {
                willSet {
                    print("SomeSuperClass-willSet-y: ", newValue)
                }
                didSet {
                    print("SomeSuperClass-didSet-y: ", oldValue)
                }
            }
        }
        
        let someSubCls = SomeSubClass()
        someSubCls.x = 100
        someSubCls.y = 200 //  由于 y 属性子类添加了属性观察器，didSet 中需要使用 oldValue，因此会先调用父类的 Getter 方法 -> 子类的 willSet -> 父类的 Setter  -> 子类的 didSet
        someSubCls.z = 200 // 由于 z 属性子类没有添加属性观察器，因此不需要保存 oldValue，因此直接调用父类的 Setter
        
        // 计算属性添加属性观察器: 会先调用 Getter 保存旧值(如果在属性观察器中需要使用旧值，否则不会调用Getter)，在 willSet -> Setter -> didSet
        // 存储属性添加属性观察器: 会直接调用 Setter，然后 willSet -> didSet
    }
    
    
    /// inout 参数和属性观察器测试
    static func inoutPropertyObserversTest() {
        print("\n-----------------属性：属性观察器-inout参数测试----------------")
        struct SomeStruct {
            var x = 0 {
                willSet {
                    print("SomeStruct-willSet-x")
                }
                didSet {
                    print("SomeStruct-didSet-x")
                }
            }
            var y = 0
            var z: Int {
                get {
                    print("SomeStruct-Getter-z")
                    return y
                }
                set {
                    print("SomeStruct-Setter-x")
                    y = newValue
                }
            }
        }
        
        func increaseOne(originNum: inout Int) {
            originNum += 1
        }
        
        var st = SomeStruct(x: 0, y: 0)
        // 将带有观察器的存储属性通过 in-out 方式传入函数，willSet 和 didSet 也会调用。这是因为 in-out 参数采用了拷入拷出(copy-in copy-out)内存模式：即在函数内部使用的是参数的 copy，函数结束后，又对参数重新赋值。1）先将属性赋值给临时变量，将临时变量作为参数传入inout函数，函数执行结束后，将临时变量赋值给属性
        increaseOne(originNum: &st.x)
        print("x:", st.x)
        // 存储属性没有属性观察器，这直接将属性的地址作为参数传入inout函数，直接修改属性，不需要 copy-in copy-out 内存模式
        increaseOne(originNum: &st.y)
        print("y:", st.x)
        // 计算属性本质是 Setter 和 Getter 函数，没有实际存储变量的物理地址，也采用 copy-in copy-out 内存模式
        increaseOne(originNum: &st.z) // 调用了一次 Getter 和一次 Setter
        print("z:", st.z)
    }
    
    
    /// 属性包装器
    static func propertyWrapper() {
        // 局部和全局变量也可以定义属性包装器
    }
    
    
    /// 计算属性和属性观察器也可用于局部和全局变量，使用方式和属性一样
    static func globalAndLocalVariablesTest() {
        print("\n-----------------属性：全局和局部变量测试----------------")
        // 局部存储变量可以定义属性观察器，如果定义了属性观察器必须定义时候进行初始化，因为局部变量没有构造器
        var localX = 0 {
            willSet {
                print("willSet: newLocalX: ", newValue)
                print("willSet: localX: ", localX)
            }
            didSet {
                print("didSet: old:ocalX: ", oldValue)
                print("didSet: localX: ", localX)
            }
        }
        print("localX: ", localX)
        localX = 1
        print("---------局部变量也可以定义属性观察器\n")
        
        print("globalX: ", globalX)
        globalX = 2
        print("---------全局变量也可以定义属性观察器\n")
        
        // 局部计算变量（computed variables）
        var localX1: Int {
            get {
                localX
            }
            set {
                localX = newValue
            }
        }
        print("localX1: ", localX1)
        localX1 = 10
        print("localX1: ", localX1)
        print("globalX1: ", globalX1)
        globalX1 = 120
        print("globalX1: ", globalX1)
        
        // 全局的常量或变量都是延迟计算的，跟延时加载存储属性相似，不同的地方在于，全局的常量或变量不需要标记 lazy 修饰符。
        // 局部范围的常量和变量从不延迟计算。
    }
    
    
    /// 类型属性
    /// 类型属性属于类型，无论创建多少个该类型的实例，类型属性都只有唯一一份。类型属性用于定义某个类型所有实例共享的数据。类似 C 中的静态常量或者变量。
    static func typePropertiesTest() {
        print("\n-----------------属性：类型属性测试----------------")
        // 1. 必须给存储型类型属性指定默认值，因为类型本身没有构造器，无法在初始化过程中使用构造器给类型属性赋值。
        // 2. 存储型类型属性是延迟初始化的，只有在第一次被访问的时候才会被初始化。即使被多个线程同时访问，系统也能保证只会对其进行一次初始化，并且不需要对其使用 lazy 修饰符。类型属性初始化不会触发属性观察器。
        // 3. 类型属性的定义只需要在定义属性时加上 static 或者 class 关键词，其他用法（属性观察器、计算属性）和实例属性类似
            // 1) static 可以用于结构体、枚举、类的存储属性和计算属性，class只能用于类的计算属性，并且可以被子类重写；
            // 2）枚举既可以定义存储类型属性（不能定义实例存储属性），也可以定义计算类型属性；
            // 3）类只有计算类型属性才可以用 class 修饰，并且可以被子类重写；存储属性不能子类被重写，因此只能使用 static 修饰
        
        struct SomeStruct {
            static var x = 0 {
                willSet { print("SomeStruct.x willSet") }
                didSet { print("SomeStruct.x didSet") }
            }
            static var y: Int {
                get { x }
                set { x = newValue }
            }
        }
        
        enum SomeEnum {
            case one, two
            static var x = 0 { // 枚举可以定义存储类型属性，但不能定义存储实例属性
                willSet { print("SomeEnum.x willSet") }
                didSet { print("SomeEnum.x didSet") }
            }
            static var y: Int {
                get { x }
                set { x = newValue }
            }
        }
        
        class SomeClass {
            static var x = 0 {
                willSet { }
                didSet { }
            }
            static var y: Int {
                get { x }
                set { x = newValue }
            }
            static var x1 = 0 {
                willSet { }
                didSet { }
            }
            class var y1: Int {
                get { x }
                set { x = newValue }
            }
        }
        
        class SomeSubClass: SomeClass {
            override static var y1: Int { // 重写父类用 class 修饰的计算属性
                get { x }
                set { x = newValue }
            }
        }
        
        // 类型属性直接通过类型访问
        print("SomeStruct.x", SomeStruct.x)
        SomeStruct.x = 10
        print("SomeStruct.x", SomeStruct.x)
    }
    
}


/// 全局存储变量也可以定义属性观察器，如果定义了属性观察器必须定义时候进行初始化，因为全局变量没有构造器
var globalX: Int = 0 {
    willSet {
        print("willSet: newGlobalX: ", newValue)
        print("willSet: globalX: ", globalX)
    }
    didSet {
        print("didSet: oldGlobalX: ", oldValue)
        print("didSet: globalX: ", globalX)
    }
}
/// 局部计算变量（computed variables）
var globalX1: Int {
    get {
        globalX
    }
    set {
        globalX = newValue
    }
}
