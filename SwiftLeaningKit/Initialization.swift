//
//  Initialization.swift
//  SwiftLeaningKit
//
//  Created by fanshuaifei on 2021/5/22.
//  Copyright © 2021 SwiftLeaning. All rights reserved.
//

import Foundation

struct InitializationTest: Runable {
    static func run() {
        print("\n\n=================== Initialization ====================")
        initializerDefineTest()
        defaultInitializersTest()
        initializerDelegationForClassTypes()
        initializerOverridingTest()
        automaticInitializerInheritanceTest()
        
        requiredInitializersTest()
    }
    
    /// 构造过程是使用类、结构体或枚举类型实例之前的准备过程，在新实例使用之前，必须为每个存储属性设置初始值和执行其它必须的设置工作。与 Objective-C 中的构造器不同，Swift 的构造器没有返回值，它的主要任务是保证某种类型的新实例在第一次使用前完成正确的初始化。
    
    /// 创建类和结构体实例时，必须为所有存储型属性设置合初始值。可以在构造器中设置初始值，或者在定义属性时设置默认值，这两种方式的值是直接设置的，不会触发属性观察者。
    
    
    /// 构造器的定义
    static func initializerDefineTest() {
        class SomeClass {
            // 非可选类型的存储属性必须在构造器或者定义时候设置初始值；可选类型的存储属性表示可以被设置为 nil，可以不在构造器或者定义时候设置默认值，因为默认为 nil。
            var x: Double = 0.0 // 定义时设置默认值
            var y: Int // 在构造器中设置初始值
            var z: String? // 可选类型的存储属性，默认初始化为 nil
            var i: String? = "i" // 可选类型的存储属性也可以设置默认值
            
            // 常量属性被赋值后将永远不可改变
            let j: Int = 10 // 常量也可以在定义时候设置初始值； 由于常量只能初始化一次，因此 j 不能在次在构造器中初始化。
            let k: Float // 常量也可以在构造器中设置初始值
            
            /// 构造器的参数列表定义方式和函数的参数列表定义一模一样，可以指定形参名字和实参标签名字，也可以省略实参标签
            
            // 由于只有 y 和 k 是非可选存储属性且没有设置默认值，因此构造器中必须设置 y 的初始值
            init() {
                y = 0
                k = 0
                // j = 0 // 编译报错，j 是常量，并且在定义时已经初始化，不能在初始化第二次
            }
            
            init(y: Int, k: Float) {
                self.y = y
                self.k = k
            }
            
            init(x: Double, y y0: Int, _ z: String?, i: String, k: Float) {
                self.x = x
                self.y = y0
                self.z = z
                self.i = i
                self.k = k
            }
        }
        
        class SomeSubClass: SomeClass {
            var m: Int
            
            override init() {
                // y = 0 //  编译报错，父类的成员属性必须在父类的构造器中完成初始化
                
                // 1. 必须先完成本身成员属性初始化
                m = 10
                // 2. 然后调用父类构造器，完成父类成员属性初始化
                super.init()
                
                // 1 和 2 完成后可以修改父类成员属性，如果是常量属性，由于是在父类完成构造后不能改变，因此不能在子类中修改。
                y = 10
            }
        }
    }
    
    
    /// 默认构造器
    /// 如果结构体或类为所有属性提供了默认值，又没有提供任何自定义的构造器，那么 Swift 会给这些结构体或类提供一个默认构造器。这个默认构造器将简单地创建一个所有属性值都设置为它们默认值的实例。
    static func defaultInitializersTest() {
        // 所有成员均有默认值，因此有一个默认构造器
        class SomeClass {
            let x = 10
            var y = 0
            var z: Int?
        }
        let _ = SomeClass()
        
        /// 结构体逐一成员构造器（memberwise initializer），为没有初始化值的属性生成一个默认的逐一成员构造器（包含可选成员）
        /// 1. 变量设置了默认值，逐一成员构造器参数列表中可以包含这个参数，也可以不包含这个参数;
        /// 2. 常量设置了默认值，逐一成员构造器参数列表中一定不包含这个参数
        /// 3. 不设置默认值（常量、变量、可选类型）逐一成员构造器参数列表中一定包含这个参数
        struct SomeStruct {
            let x: Int
            var y = 0 // 变量设置了默认值，逐一成员构造器参数列表中可以包含这个参数，也可以不包含这个参数;
            let z: Int?
            let i: String
            var j = 0 // 变量设置了默认值，逐一成员构造器参数列表中可以包含这个参数，也可以不包含这个参数;
            let k = 0 // 常量设置默认值，逐一成员构造器参数列表中一定不包含这个参数
        }
        let _ = SomeStruct(x: 10, z: 10, i: "i")
        let _ = SomeStruct(x: 10, z: 10, i: "i", j: 10)
        let _ = SomeStruct(x: 10, y: 10, z: 10, i: "i")
        let _ = SomeStruct(x: 10, y: 10, z: 10, i: "i", j: 10)
        
        /// 如果提供了自定义的构造器，则不会生成逐一成员构造器和默认构造器（对于类，如果提供了自定义构造器，则不会生成默认构造器，因为类没有逐一成员构造器）
        struct SomeStruct1 {
            var x = 0
            var y = 0
            init(y: Int) {
                self.y = y
            }
        }
        // let _ = SomeStruct1(x:0, y: 0) // 编译报错，没有生成逐一成员构造器
        // let _ = SomeStruct1() // 编译报错，没有生成默认构造器
        let _ = SomeStruct1(y: 0)
        
        /// 如果是在扩展中提供了自定义构造器，不影响生成默认构造器和逐一成员构造器，具体可以见扩展部分
    }
    
    
    /// 构造器可以通过调用其它构造器来完成实例的部分构造过程，这一过程称为构造器代理，它能避免多个构造器间的代码重复。
    
    /// 值类型的构造器代理
    /// 值类型（结构体和枚举类型）不支持继承，所以构造器代理的过程相对简单，因为它们只能代理给自己的其它构造器。
    static func initializerDelegationForValueTypesTest() {
        struct SomeStruct {
            var x: Int
            var y: Int
            var z: Int
            init(x: Int, y: Int, z: Int) {
                self.x = x
                self.y = y
                self.z = z
            }
            init(x: Int, y: Int) {
                self.init(x: x, y: y, z: 0) // 代理到 init(x: Int, y: Int, z: Int) 构造器
            }
        }
    }
    
    
    /// 类里面的所有存储型属性，包括所有继承自父类的属性，都必须在构造过程中设置初始值。Swift 为类类型提供了两种构造器来确保实例中所有存储型属性都能获得初始值，即指定构造器和便利构造器。
    //  1. 指定构造器是类中最主要的构造器，指定构造器将初始化类中提供的所有属性，并调用合适的父类构造器让构造过程沿着父类链继续往上进行。
    //  2. 每一个类都必须至少拥有一个指定构造器，类倾向于拥有极少的指定构造器，普遍的是一个类只拥有一个指定构造器。
    //  3. 便利构造器是类中比较次要的、辅助型的构造器。可以定义便利构造器来调用同一个类中的指定构造器，并为部分形参提供默认值。
    //  指定构造器的语法跟值类型构造器一样
    //  init(parameters) {
    //      statements
    //  }
    //  便利构造器使用 convenience 修饰
    //  convenience init(parameters) {
    //      statements
    //  }
    
    /// 类类型的构造器代理：指定构造器和便利构造器之间的调用关系遵循以下三条规则：
    //  1. 指定构造器必须调用其直接父类的的指定构造器
    //  2. 便利构造器必须调用同类中定义的其它构造器
    //  3. 便利构造器最后必须调用指定构造器
    //  总结：指定构造器必须向上代理，即调用父类的指定构造器；便利构造器必须横向代理，即调用同类中的便利构造器，并且最终应该代理到指定构造器
    
    /// 两段式构造过程：Swift 中类的构造过程包含两个阶段
    //  1. 为类（父类和子类）中的每个存储型属性设置初始值
    //  2. 给每个类一次机会，在新实例准备使用之前进一步自定义它们的存储型属性
    // 总结：两段式构造过程让构造过程更安全，每个存储属性都保证被设置了初始值，可以防止属性值在初始化之前被访问，也可以防止属性被另外一个构造器意外地赋予不同的值；同时在整个类层级结构中给予了每个类完全的灵活性。
    /// Swift 编译器将执行 4 种有效的安全检查，以确保两段式构造过程不出错地完成：
    //  1. 指定构造器必须保证它所在类的所有属性都必须先初始化完成，之后才能将构造任务向上代理给父类中的构造器。
    //  2. 指定构造器必须在为继承的属性设置新值之前向上代理调用父类构造器。如果没这么做，指定构造器赋予的新值将被父类中的构造器所覆盖。
    //  3. 便利构造器必须为任意属性（包括所有同类中定义的）赋新值之前代理调用其它构造器。如果没这么做，便利构造器赋予的新值将被该类的指定构造器所覆盖。
    //  4. 构造器在第一阶段构造完成之前，不能调用任何实例方法，不能读取任何实例属性的值，不能引用 self 作为一个值。类的实例在第一阶段结束以前并不是完全有效的，只有第一阶段完成后，类的实例才是有效的，才能访问属性和调用方法。
    
    static func initializerDelegationForClassTypes() {
        class SomeClass {
            var x = 0
            var y: Int
            var z: String
            init(x: Int, y: Int, z: String) { // 指定构造器
                self.x = x
                self.y = y
                self.z = z
            }
            init(y: Int, z: String) { // 指定构造器
                self.y = y
                self.z = z
                // self.init(x: 0, y:0, z: "z") // 编译报错，指定构造器必须向上代理
            }
            convenience init(y: Int) {
                self.init(x: 0, y:y, z: "z") // 便利构造器必须横向代理，调用同类中的指定构造器
            }
            convenience init() {
                self.init(y: 0) // 便利构造器必须横向代理，调用同类中的便利构造器
            }
        }
        
        class SomeSubClass: SomeClass {
            var i = 0
            var j: Int
            var k: String
            init(x: Int, y: Int, z: String, i: Int, j: Int, k: String) {
                // 在向上代理父类的指定构造器之前，必须完成本类存储属性的初始化
                self.i = i
                self.j = j
                self.k = k
                // self.x = x // 编译报错，向上代理父类的指定构造器之前，构造过程第一阶段还没完成，不允许修改父类属性
               
                super.init(x: x, y: y, z: z) // 向上代理父类的指定构造器
                
                self.x = x // 向上代理父类的指定构造器之后，开始构造过程第二阶段可以修改父类属性
            }
        }
        
        let _ = SomeClass()
        let _ = SomeClass(y: 10)
        let _ = SomeClass(y: 10, z: "z")
        let _ = SomeClass(x: 10, y: 10, z: "z")
        
        // Swift 中的子类默认情况下不会继承父类的构造器，这种机制可以防止一个父类的简单构造器被一个更精细的子类继承，而在用来创建子类实例时没有完全或被错误的初始化。
        // 父类的构造器仅会在安全和适当的某些情况下被继承。看后面的构造器的自动继承部分。
        let _ = SomeSubClass(x: 0, y: 0, z: "z", i: 0, j: 0, k: "k")
    }
    
    /// 构造器的重写
    static func initializerOverridingTest() {
        class SomeClass {
            var x: Int
            var y: Int
            init() {
                self.x = 0
                self.y = 0
            }
            init(x: Int, y: Int) {
                self.x = x
                self.y = y
            }
            convenience init(x: Int) {
                self.init(x: x, y:0)
            }
            convenience init(y: Int) {
                self.init(x: 0, y:y)
            }
        }
        
        class SomeSubClass: SomeClass {
            var z: Int
            // 将父类的指定构造器重写为指定构造器，需要加 override
            override init(x: Int, y: Int) {
                self.z = 0
                super.init(x: x, y: y)
            }
            
            // 将父类的指定构造器重写为便利构造器，需要加 override
            convenience override init() {
                self.init(x:0, y:0)
            }
            
            // 写一个和父类便利构造器名字、参数列表一样的便利构造器，不需要加 override
            convenience init(x: Int) {
                self.init(x: x, y:0)
            }
            
            // 写一个和父类便利构造器名字、参数列表一样的指定构造器，不需要加 override
            init(y: Int) {
                self.z = 0
                super.init(x: 0, y:y)
            }
            
            init(x: Int, y: Int, z:Int) {
                self.z = z
                super.init(x: x, y: y)
            }
        }
        
        let _ = SomeClass()
        let _ = SomeClass(x: 10)
        let _ = SomeClass(y: 10)
        let _ = SomeClass(x: 10, y: 10)
        
        let _ = SomeSubClass()
        let _ = SomeSubClass(x: 10)
        let _ = SomeSubClass(y: 10)
        let _ = SomeSubClass(x: 10, y: 10)
        let _ = SomeSubClass(x: 10, y: 10, z: 10)
        
        /// 总结
        // 当重写父类的指定初始化器时，无论重写为指定构造器还是便利构造器，都必须加上 override
        // 当子类写一个与父类便利构造器的名字、参数列表一样的构造器（便利或者指定）时，不用加上 override。因为子类不能直接调用父类的便利构造器，因此子类是无法重写父类的便利构造器的。
    }
    
    
    /// 构造器的自动继承
    /// 规则1.  子类没有定义任何指定构造器，将自动继承父类所有的指定构造器。
    /// 规则2.  子类提供了所有父类指定构造器的实现，将自动继承父类所有的便利构造器。
    ///       1）通过规则 1 继承过来指定构造器
    ///       2）通过重写父类所有指定构造器提供自定义实现（子类将父类的指定构造器重写为指定构造器或者便利构造都可以）。如果添加了新的自定义的指定构造器，不满足规则 1 无法继承指定构造器，因此就无法满足规则 2 无法继承便利构造器，如果想继承便利构造器，可以将父类的所有指定构造器进行重写。
    //  即使你在子类中添加了更多的便利构造器，这两条规则仍然适用。
    static func automaticInitializerInheritanceTest() {
        class SomeClass {
            var x: Int
            var y: Int
            init() {
                self.x = 0
                self.y = 0
            }
            init(x: Int, y: Int) {
                self.x = x
                self.y = y
            }
            convenience init(x: Int) {
                self.init(x: x, y:0)
            }
            convenience init(y: Int) {
                self.init(x: 0, y:y)
            }
        }
        
        // 子类没有定义任何指定构造器，将自动继承父类所有的指定构造器，以及便利构造器
        class SomeSub1Class: SomeClass {
            var z = 0
            convenience init(x: Int, y: Int, z: Int) { // 子类中添加了新的便利构造器，依然满足条件，可以继承所有便利构造器
                self.init(x: x, y: y)
                self.z = z
            }
        }
        let _ = SomeSub1Class()
        let _ = SomeSub1Class(x: 10)
        let _ = SomeSub1Class(y: 10)
        let _ = SomeSub1Class(x: 10, y: 10)
        let _ = SomeSub1Class(x: 10, y: 10, z: 10)
        
        // 子类重写父类的所有指定构造器（其中一个重写为了便利构造器），自动继承父类所有的便利构造器
        class SomeSub2Class: SomeClass {
            var z = 0
            override init() {
                super.init()
            }
            convenience override init(x: Int, y: Int) {
                self.init()
                self.x = x
                self.y = y
            }
        }
        let _ = SomeSub2Class()
        let _ = SomeSub2Class(x: 10)
        let _ = SomeSub2Class(y: 10)
        let _ = SomeSub2Class(x: 10, y: 10)
        
        
        // 只重写了父类其中一个指定构造器，没有重写另一个，不满足规则 1，无法继承指定构造器；也不满足规则 2，无法继承便利构造器
        class SomeSub3Class: SomeClass {
            var z = 0
            override init() {
                super.init()
            }
        }
        let _ = SomeSub3Class()
        // 没有继承指定和便利构造器，下面编译报错
        // let _ = SomeSub3Class(x: 10)
        // let _ = SomeSub3Class(y: 10)
        // let _ = SomeSub3Class(x: 10, y: 10)
        
        
        // 提供新的指定构造器，因此无法继承父类的指定和便利构造器
        class SomeSub4Class: SomeClass {
            var z = 0
            init(z: Int) {
                self.z = z
                super.init(x: 0, y: 0)
            }
        }
        let _ = SomeSub4Class(z: 10)
        // 没有继承指定和便利构造器，下面编译报错
        // let _ = SomeSub4Class()
        // let _ = SomeSub4Class(x: 10)
        // let _ = SomeSub4Class(y: 10)
        // let _ = SomeSub4Class(x: 10, y: 10)
        
        
        // 提供新的指定构造器，但是重写了父类所有置指定构造器，因此可以继承所有便利构造器
        class SomeSub5Class: SomeClass {
            var z = 0
            init(z: Int) {
                self.z = z
                super.init(x: 0, y: 0)
            }
            override init() {
                super.init()
            }
            convenience override init(x: Int, y: Int) {
                self.init()
                self.x = x
                self.y = y
            }
        }
        let _ = SomeSub5Class(z: 10)
        let _ = SomeSub5Class()
        let _ = SomeSub5Class(x: 10)
        let _ = SomeSub5Class(y: 10)
        let _ = SomeSub5Class(x: 10, y: 10)
    }
    
    
    /// 必要构造器
    /// 在类的构造器前添加 required 修饰符表明所有该类的子类都必须实现该构造器。
    static func requiredInitializersTest() {
        /// 必要构造器只要求所有类以及子类必须实现该构造器，但是并未要求实现的该构造器是指定构造还是便利构造器。重写要求参考构造器的重写部分。
        class SomeClass {
            var x: Int
            var y = 0
            var w = 0
            init(x: Int) {
                self.x = x
            }
            required init() { // 这是一个 required 的指定构造器
               x = 0
            }
            
            required init(x: Int, y: Int) {
                self.x = x
                self.y = y
            }
            
            required convenience init(w: Int) {
                self.init(x: 0)
            }
            
            required convenience init(y: Int) {
                self.init(x: 0)
            }
        }
        
        class SomeSubClass: SomeClass {
            var z: Int
            init(z: Int) {
                self.z = z
                super.init(x: 0)
            }
            
            // 子类必须实现父类的 required 构造器，是对父类 init() 指定构造的重写，但是 required 走造器可以省略 override 修饰符，override 是隐式的
            required init() {
                z = 0
                super.init()
            }
            
            required convenience init(x: Int, y: Int) {
                self.init()
                self.x = x
                self.y = y
            }
            
            required init(w: Int) {
                z = 0
                super.init(x: 0)
                self.w = w
            }
            
            required convenience init(y: Int) {
                self.init()
                self.y = y
            }
        }
        
        /// 子类继承的构造器能满足必要构造器的要求，则无须在子类中显式提供必要构造器的实现。继承规则参考构造器的自动继承部分。
        class Some1Class {
            var x: Int
            var y: Int
            required init(x: Int, y: Int) {
                self.x = x
                self.y = y
            }
        }

        class SomeSub1Class: Some1Class {
            // 自动继承了父类的指定构造器和便利构造器，无需在子类中显式提供必要构造器的实现
        }
    }
}
