//
//  TypeCasting.swift
//  SwiftLeaningKit
//
//  Created by fanshuaifei on 2020/7/26.
//  Copyright © 2020 SwiftLeaning. All rights reserved.
//

import Foundation
import UIKit

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
        var some = SomeBaseClass()
//        TypeCastingTest.Type
        some.instanceMethod()
        // 获取类类型
        var classType: SomeBaseClass.Type = type(of: some)
        classType.classMethod()
        // 获取元类类型
        var metaClassType = type(of: classType);
        var metaClassType111 = type(of: metaClassType);
        print(metaClassType111)
//        SomeBaseClass.Type.Type.Type.Type
        print(SomeBaseClass.Type.Type.Type.self)
//        if SomeBaseClass.Type.Type.Type.self === SomeBaseClass.Type.Type.Type.self {
//            <#code#>
//        }
        
        var aaa = SomeBaseClass.Type.Type.Type.self
        var aa1a = SomeBaseClass.Type.Type.Type.Type.Type.self
        var aa2a = SomeBaseClass.Type.Type.Type.Type.Type.self
//        print(NSString(format: "%p", <#T##args: CVarArg...##CVarArg#>))
        withUnsafePointer(to: &classType) {
            print(" str value has address: \($0)")
        }
        withUnsafePointer(to: &metaClassType) {
            print(" str value has address: \($0)")
        }
        withUnsafePointer(to: &aaa) {
            print(" str value has address: \($0)")
        }
        withUnsafePointer(to: &aa1a) {
            print(" str value has address: \($0)")
        }
        withUnsafePointer(to: &aa2a) {
            print(" str value has address: \($0)")
        }
//        print(Unmanaged.passUnretained(some).toOpaque())
        print("")
    }
}
