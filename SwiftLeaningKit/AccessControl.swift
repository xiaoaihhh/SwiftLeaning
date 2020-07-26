//
//  AccessControl.swift
//  SwiftLeaningKit
//
//  Created by fanshuaifei on 2020/7/25.
//  Copyright © 2020 SwiftLeaning. All rights reserved.
//

import Foundation

/*
 1. 如果类型修饰为 private/fileprivate，类型成员则默认是 fileprivate；如果类型修饰为 internal/public/open，类型成员则默认是 internal。 private修饰的类型也可以在同一个文件中访问。
 2. 元组的访问级别将由元组中访问级别最严格的元素类型来决定。
 3. 函数的访问级别根据访问级别最严格的参数类型或返回类型的访问级别来决定，成员变量的访问级别不能高于成员变量类型访问级别
 4. 如果struct的默认逐一构造器的访问级别是由所有成员属性的最低访问级别决定，因此默认逐一构造器最高访问级别是iternal，如果想是 public 只能手动定义。类的默认构造器同理。
 5. 枚举成员的访问级别和枚举类型相同，不能为枚举成员单独指定不同的访问级别。枚举定义中的任何原始值或关联值的类型的访问级别至少不能低于枚举类型的访问级别。
 6. 嵌套类型的访问级别可以参考1，可以把嵌套的类型当作外围类型的一个成员来看。
 7. 类：可以继承同一模块中的所有有访问权限的类，也可以继承不同模块中被 open 修饰的类。可以通过重写给所继承类的成员提供更高的访问级别，在同一模块中，你可以在符合当前访问级别的条件下重写任意类成员（方法、属性、构造器、下标等）。在不同模块中，你可以重写类中被 open 修饰的成员。
 8. 常量、变量、属性不能拥有比它们的类型更高的访问级别。如果常量、变量、属性、下标的类型是 private 级别的，那么它们必须明确指定访问级别为 private。
 9. 协议的访问级别只能在声明协议时指定，不能为单独的协议成员指定，协议中的每个方法或属性都必须具有和该协议相同的访问级别。如果一个继承自其它协议，那么新协议的访问级别最高只能和被继承协议的访问级别相同。一个类型可以遵循比它级别更低的协议，遵循协议时方法实现的访问级别要大于等于类型和协议中级别最小的那个。协议扩展中的默认实现访问级别不受限制，但是如果访问级别比协议声明访问级别低，由于不能对更高级别暴露，起不到默认实现作用。
 10. Extension 的访问级别默认与类型的访问级别一样，可以重新指定扩展的默认访问级别（但不能高于类型的访问级别），如果扩展用来遵守协议，则不能指定访问级别。
 11. 泛型类型或泛型函数的访问级别取决于泛型类型或泛型函数本身的访问级别，还需结合类型参数的类型约束的访问级别，根据这些访问级别中的最低访问级别来确定。
 12. 类型成员的访问级别可以定义的比类型的访问级别高，但是最高只能起到类型访问级别的作用，比如类型是internal，一个成员函数是public的，那么这个成员函数也不可能被其它模块访问。
 */

private enum Sex { // 枚举成员的访问级别和枚举类型相同，不能为枚举成员单独指定不同的访问级别。
    case boy
    case girl
}

internal enum Sex1 {
    case boy
    case girl
}

private struct PersonalInfo {  // private修饰的类型也可以在同一个文件中访问。成员默认是fileprivate级别，如果成员不想被访问需要显示指定为private
    let name: String
    private let age: Int // 如果struct的一个成员访问级别比类型访问级别低，则不会生成默认逐一构造器，需要显示定义
    let sex: Sex
    
    init(name: String, age: Int, sex: Sex) {
        self.name = name
        self.age = age
        self.sex = sex
    }
    
    func printInfo() {
        print(sex)
    }
}

extension PersonalInfo {
    func test() {
    
    }
}


struct AccessControlStructTest: Runable {
    static func run() {
//        PersonalInfo(age: <#T##Int#>, sex: <#T##Sex#>
        PersonalInfo(name: "", age: 4, sex: .boy).test()
//        let test = AccessControlStructTest(personalInfo: nil)
//        print(test.personalInfo?.sex ?? .boy)
    }
    fileprivate let personalInfo: PersonalInfo? // 成员变量的访问级别不能高于成员变量类型访问级别
    fileprivate let sexTuple: (Sex, Sex1)? // 元组的访问级别将由元组中访问级别最严格的元素类型来决定。
    fileprivate func sexTest(sex: Sex, sex1: Sex1) -> (Sex, Int) { // 函数的访问级别根据访问级别最严格的参数类型或返回类型的访问级别来决定
        return (.boy,4)
    }
}

public struct Nested1 {
    public static let name: String = ""
    
    public struct Neste2 {
        let name: String
        
        private struct Neste2 {
            let age = 0
            
        }
    }

    enum Sex {
        case boy
        case girl
    }
}

public class A {
    var name: String {
        "xiaoming"
    }
    
    fileprivate func someMethod() {
        
    }
}

fileprivate class B: A {
    fileprivate override var name: String {
        get {
            super.name
        }
        set {
           
        }
    }
    
    open override func someMethod() {
        
    }
}

open class A1 {
    open var name: String {
        "xiaoming"
    }
    
    public func someMethod() {
        
    }
}

open class A2: P1 {
    open func test() {
        
    }
    
    open var name: String {
        "xiaoming"
    }
    
    open func someMethod() {
        
    }
}

public protocol P1 {
    func test()
}

protocol P2: P1 {
    func test1()
}

public struct PP: P2 {
    public func test() {
        
    }
    
    public func test1() {
        
    }
    
}

public protocol O1 {
    func test()
}

private struct PP1 {
    private let name = "xiaoming"
    func hahaha() {
        print(age)
    }
}

extension PP1: P1 {
    private var age: Int {
        10
    }
    func test() {
        print(name)
    }
}

