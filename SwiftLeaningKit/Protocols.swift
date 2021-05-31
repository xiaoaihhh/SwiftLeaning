//
//  Protocols.swift
//  SwiftLeaningKit
//
//  Created by fanshuaifei on 2020/7/25.
//  Copyright © 2020 SwiftLeaning. All rights reserved.
//

import Foundation
import UIKit


struct ProtocolsTest: Runable {
    static func run() {
        print("\n\n=================== Protocols ====================")
        protocolSyntaxTest()
        propertyRequirementsTest()
        methodRequirementsTest()
        initializerRequirementsTest()
        protocolsAsTypesTest()
        addingProtocolConformanceWithAnExtensionTest()
        conditionallyConformingToAProtocolTest()
        protocolCompositionTest()
        checkingForProtocolConformance()
        protocolExtensionsTest()
    }
    /// 协议定义
    static func protocolSyntaxTest() {
        print("\n-----------------协议：协议定义----------------")
        // 使用关键词 protocol 定义
        // protocol SomeProtocol { }
        
        // 结构体、枚举、类遵循某个协议，在类型名称后加上协议名称，中间以冒号（:）分隔。遵循多个协议时，各协议之间用逗号分隔
        // struct SomeStructure: FirstProtocol, AnotherProtocol { }
        
        // 若是一个类遵守协议，并且拥有父类，应该将父类名放在遵循的协议名之前，以逗号分隔：
        // class SomeClass: SomeSuperClass, FirstProtocol, AnotherProtocol { }
        
        // 1. 协议不可作为嵌套类型定义
        // 2. 协议中定义方法时不能有默认参数
    }
    
    
    /// 协议定义属性
    static func propertyRequirementsTest() {
        print("\n-----------------协议：属性定义和遵守----------------")
        class SomeClass: SomeProtocolForProperty {
            /// 遵守协议，可读可写
            var name: String =  "defaultName"
            /// 遵守协议，因为是只读的，因此可以实现为只读的计算属性
            var description: String {
                "Name is " + name
            }
            /// 遵守协议，因为是只读的，尽管协议使用 var 声明属性，但是实现的类型仍可以使用 let
            let max = 1000
            // 遵守协议，因为是只读的，因此可以实现为只读的存储属性
            private(set) var min: Int = 0
            // 遵守协议，类型属性
            static var count: Int = 10
            // 遵守协议，类型计算属性可以使用 class 修饰
            class var total: Int {
                get { count }
                set { count = newValue }
            }
        }
    }
    
    /// 协议定义方法
    static func methodRequirementsTest() {
        print("\n-----------------协议：方法定义和遵守----------------")
        struct SomeStruct: SomeProtocolForMethod {
            func printName() { }
            static func maxCount() -> Int  { Int.max }
            mutating func changeSelf() { // 这里是结构体 && 修改了 self，因此实现协议时必须使用 mutating 修饰
                self = SomeStruct()
            }
        }
    }
    
    /// 协议定义构造器
    static func initializerRequirementsTest() {
        print("\n-----------------协议：构造器定义和遵守----------------")
        // 结构体直接实现协议定义好的构造器
        struct SomeStruct: SomeProtocolForInitializer {
            var x: Int = 0
            var y: Int = 0
            var z: Int = 0
            
            init(x: Int) {
                self.x = x
            }
            
            init?(y: Int) {
                if y < 0 {
                    return nil
                }
                self.y = y
            }
            
            init(z: Int) {
                self.z = z
            }
        }
        
        class SomeClass: SomeProtocolForInitializer {
            var x: Int = 0
            var y: Int = 0
            var z: Int = 0
            
            required init(x: Int) {
                self.x = x
            }
            
            required init?(y: Int) {
                self.y = y
            }
            
            required convenience init!(z: Int) { // 实现为便利构造器
                self.init(x: 0)
                self.z = z
            }
        }
    }
    
    
    /// 协议作为类型
    /// 尽管协议本身并未实现任何功能，但是协议可以被当做一个功能完备的类型来使用。可以理解为：存在着一个类型 T，T 遵循协议 。
    //  1. 作为函数、方法或构造器中的参数类型或返回值类型
    //  2. 作为常量、变量或属性的类型
    //  3. 作为数组、字典或其他容器中的元素类型
    static func protocolsAsTypesTest() {
        print("\n-----------------协议：协议作为类型----------------")
        struct SomeStruct: SomeProtocolForMethod {
            func printName() { }
            static func maxCount() -> Int  { Int.max }
            mutating func changeSelf() {
                self = SomeStruct()
            }
        }
        
        // 将 SomeProtocolForMethod 作为一个类型使用
        let instance: SomeProtocolForMethod = SomeStruct()
        instance.printName()
        
        let instances: [SomeProtocolForMethod] = [SomeStruct(), SomeStruct()]
        for item in instances {
            item.printName()
        }
    }
    
    /// 在扩展里添加协议遵循
    static func addingProtocolConformanceWithAnExtensionTest() {
        print("\n-----------------协议：在扩展里添加协议遵循----------------")
        print(10.textualDescription)
    }
    
    /// 有条件地遵循协议
    static func conditionallyConformingToAProtocolTest() {
        print("\n-----------------协议：有条件地遵循协议----------------")
        // let array1 = ["lily", "lucy"].textualDescription // 编译报错，String 没有遵守 TextRepresentable 协议
        let _ = [1, 2].textualDescription
    }
    
    /// 协议组合
    static func protocolCompositionTest() {
        struct Person: Named, Aged { // 同时遵守两个协议
            var name: String
            var age: Int
        }
        
        func printPersonInfo(_ p: Named & Aged) {
            print("\(p.name) age is \(p.age)")
        }
        
        let p: Named & Aged = Person(name: "Lucy", age: 10)
        printPersonInfo(p)
    }
    
    
    /// 检查协议一致性
    /// 使用类型转换中描述的 is 和 as 来检查协议一致性，即是否遵循某协议，并且可以转换到指定的协议类型。
    //  1. is 用来检查实例是否遵循某个协议，若遵循则返回 true，否则返回 false；
    //  2. as? 返回一个可选值，当实例遵循某个协议时，返回类型为协议类型的可选值，否则返回 nil；
    //  3. as! 将实例强制向下转换到某个协议类型，如果强转失败，将触发运行时错误。
    static func checkingForProtocolConformance() {
        print("\n-----------------协议：检查协议一致性----------------")
        class Person: Named {
            var name: String
            init(name: String) {
                self.name = name
            }
        }
        class Dog {
            
        }
        
        let objects:[AnyObject] = [Person(name: "Lucy"), Person(name: "Lily"), Dog()]
        for object in objects {
            if let namedPerson = object as? Named {
                print("name is \(namedPerson.name)")
            } else {
                print("Dog")
            }
        }
    }
    
    
    /// 协议扩展
    static func protocolExtensionsTest() {
        print("\n-----------------协议：协议扩展----------------")
        struct SomeStruct: RandomNumberGenerator {
        }
        
        struct SomeAnotherStruct: RandomNumberGenerator {
            func random() -> UInt32 {
                print("SomeStruct Implementations RandomNumberGenerator UInt32.")
                return arc4random()
            }
            func randomBool() -> Bool {
                print("SomeStruct Implementations RandomNumberGenerator Bool.")
                return Double(arc4random()%10) / 10.0 > 0.5
            }
        }
        
        print(SomeStruct().random())
        print(SomeStruct().randomBool())
        print(SomeAnotherStruct().random())
        print(SomeAnotherStruct().randomBool())
        
        let equalNumbers = [100, 100, 100, 100, 100]
        print("equalNumbers: \(equalNumbers.allEquals())")
    }
}

/// 协议中定义属性
protocol SomeProtocolForProperty {
    /// 1. 协议可以要求遵循协议的类型提供特定名称和类型的实例属性或类型属性，协议不指定属性是存储属性还是计算属性，它只指定属性的名称和类型，以及属性是只读的还是可读可写的。
    /// 2. 协议定义属性必须使用 var ，必修跟上 { set get } 标明是可读可写的，或者 { get } 是只读的；
    /// 3. 如果协议要求属性是可读可写的，那么实现协议的类型的属性必须是可读可写的；如果协议要求是只读的，则实现可以是只读的（只读计算属性、常量、只读存储属性都可以），也可是可读可写的（计算属性、可读可写的存储属性）；
    // 4. 在协议中定义类型属性时，总是使用 static 关键字修饰。如果是类类型遵循协议时，除了 static 关键字，还可以使用 class 关键字来声明类型属性。
    var name: String { set get }
    var description: String { get }
    var max: Int { get }
    var min: Int { get }
    static var count: Int { set get }
    static var total: Int { set get }
}

/// 协议中定义方法
protocol SomeProtocolForMethod {
    // 可以像编写普通方法那样，在协议的定义里写下方法的声明，但不需要写花括号和方法的实体
    func printName()
    // 如果是类型方法使用 static 修饰，其他特点和属性部分讲解一样
    static func maxCount() -> Int
    // 1. 如果是异变方法则使用 mutating 修饰
    // 2. 实现协议中的 mutating 方法时，如果是类类型，则不用写 mutating 修饰词；对于结构体和枚举，如果实现方法中修改了 self 或者 self 的属性则必须写 mutating 关键字，否则也可以省略。
    // 3. 如果协议中没使用 mutating 修饰为异变方法，则实现协议时候在该方法前加上 mutating 修饰，则编译器认为没有实现该方法，无法编译通过
    mutating func changeSelf()
    
    // func test(x: Int = 0) // 编译报错，Default argument not permitted in a protocol method
}


/// 协议中定义构造器
/// 协议可以要求遵循协议的类型实现特定的构造器，可以像编写普通构造器那样，在协议的定义里写下构造器的声明，但不需要写花括号和构造器的实体
protocol SomeProtocolForInitializer {
    init(x: Int) // 实现时候 init 或 init! 来满足
    init?(y: Int) // 实现时候可以通过 init 或者 init! 或者 init? 来满足
    init!(z: Int) // 实现时候 init 或 init! 来满足
    
    /// 1. 如果是值类型实现协议，可以直接实现构造器即可
    /// 2. 如果是类类型实现协议，可以实现为指定构造器，也可以实现为便利构造器，无论那种都需要在构造器前面加上 required 的修饰词，确保所有子类也必须提供此构造器实现，从而也能遵循协议。
    //   1) 如果类已经被标记为 final，那么不需要在协议构造器的实现中使用 required 修饰符，因为 final 类不能有子类。
    //   2) 如果一个子类重写了父类的指定构造器，并且该构造器遵守了某个协议的要求，那么该构造器的实现需要同时标注 required 和 override 修饰符。override 是隐式的当重写一个必要构造器时，因此可以省略，详见构造器-必要构造器部分。
}


protocol TextRepresentable {
    var textualDescription: String { get }
}

/// 在扩展里添加协议遵循
//  1. 即便无法修改源代码，依然可以通过扩展令已有类型遵循并符合协议，扩展可以为已有类型添加属性、方法、下标以及构造器，来符合协议中的要求。
//  2. 通过扩展令已有类型遵循并符合协议时，该类型的所有实例都会获得协议中定义的各项功能。
extension Int: TextRepresentable {
    var textualDescription: String {
        "The value is \(self)."
    }
}


/// 有条件地遵循协议
/// 泛型类型可以只在某些情况下满足一个协议的要求，比如当类型的泛型形式参数遵循对应协议时
extension Array: TextRepresentable where Element: TextRepresentable {
    var textualDescription: String {
        var str = ""
        for item in self {
            str += item.textualDescription + "\n"
        }
        return str
    }
}


/// 在扩展里声明采纳协议，当一个类型已经遵循了某个协议中的所有要求，却还没有声明采纳该协议时，可以通过空的扩展来让它采纳该协议
struct Hamster {
    var name: String
    var textualDescription: String {
        return "A hamster named \(name)"
    }
}
// 即使满足了协议的所有要求，类型也不会自动遵循协议，必须显式地遵循协议。
extension Hamster: TextRepresentable {}


/// 协议继承（Protocol Inheritance），协议可以继承多个其它协议
protocol SomeProtocol { }
protocol AnotherProtocol { }
protocol InheritingProtocol: SomeProtocol, AnotherProtocol { // 继承自 SomeProtocol 和 AnotherProtocol
}

/// 类专属的协议（Class-Only Protocols），通过添加 AnyObject 关键字到协议的继承列表，就可以限制协议只能被类类型遵守。
/// 当协议定义的要求需要遵循协议的类型必须是引用语义而非值语义时，应该采用类类型专属协议。
protocol SomeClassOnlyProtocol: AnyObject, InheritingProtocol { // SomeClassOnlyProtocol 只能被类类型遵守，同时继承自 InheritingProtocol 协议
}

/// 协议组合（Protocol Composition）
/// 如果要求一个类型同时遵循多个协议，可以使用协议组合来复合多个协议到一起。协议组合使用符号（&）将多个协议组合到一起使用， SomeProtocol & AnotherProtocol 。除了协议列表，协议组合也能包含类类型，这允许标明一个需要的父类。
protocol Named {
    var name: String { get }
}
protocol Aged {
    var age: Int { get }
}

/// 可选的协议（Optional Protocol Requirements）
/// 可选要求用在需要和 Objective-C 打交道的代码中，协议和可选要求都必须使用 @objc 修饰。@objc 特性的协议只能被继承自 Objective-C 类的类或者 @objc 类遵循，其他类以及结构体和枚举均不能遵循这种协议。
@objc protocol SomeObjectiveCOnlyProtocol {
    @objc optional var name: String { get }
    @objc optional func test()
    @objc func test1()
}


/// 协议扩展（Protocol Extensions）
/// 协议扩展可以提供默认实现，但是不能声明该协议继承自另一个协议，也不能定义新的被遵守的属性或者方法等，这些只能在协议声明处进行指定。
protocol RandomNumberGenerator {
    func random() -> UInt32
}
extension RandomNumberGenerator {
    /// 1. 为协议要求的属性、方法以及下标的提供默认实现。通过这种方式，可以基于协议本身来实现这些功能，而无需在每个遵循协议的类型中都重复同样的实现。
    func random() -> UInt32 {
        print("RandomNumberGenerator UInt32 default Implementations.")
        return arc4random()
    }
    
    /// 2. 为协议没有要求的属性、方法以及下标的提供默认实现。
    func randomBool() -> Bool {
        print("RandomNumberGenerator Bool default Implementations.")
        return Double(arc4random()%10) / 10.0 > 0.5
    }
    
    /// 无论 1 还是 2， 如果遵循协议的类型为这些要求提供了自己的实现，那么这些自定义实现将会替代扩展中的默认实现被使用。
    /// 通过协议扩展为协议要求提供的默认实现和可选的协议要求不同。虽然在这两种情况下，遵循协议的类型都无需自己实现这些要求，但是通过扩展提供的默认实现可以直接调用，而无需使用可选链式调用。
}

/// 为协议扩展添加限制条件
/// 在扩展协议的时候，可以指定一些限制条件，只有遵循协议的类型满足这些限制条件时，才能获得协议扩展提供的默认实现，这些限制条件写在协议名之后，使用 where 子句来描述。
extension Collection where Element: Equatable {
    func allEquals() -> Bool {
        for element in self {
            if element != self.first {
                return false
            }
        }
        return true
    }
}

// 如果一个遵循的类型满足了为同一方法或属性提供实现的多个限制型扩展的要求， Swift 会使用最匹配限制的实现。如果调用时候会产生歧义，则编译报错。




