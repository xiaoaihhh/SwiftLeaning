//
//  StructTest.swift
//  SwiftLeaning
//
//  Created by fanshuaifei on 2020/7/21.
//  Copyright © 2020 SwiftLeaning. All rights reserved.
//

import Foundation
import UIKit

//NS_ASSUME_NONNULL_BEGIN

func min<T: Comparable>(x: T, y: T) -> T {
    return y < x ? y : x
}

public class ObjcViewControllerMy : UIViewController {

    // 明确 nonnull
    @objc public var view1: UIView = UIView()

    // 明确 nullable
    @objc public var view2: UIView?

    // nonnull 和 nullable 状态未知
    @objc public var view3: UIView!

    // 明确 nonnull
    @objc public func createView11() -> UIView {
        return UIView()
    }

    // 明确 nullable
    @objc public func createView22() -> UIView? {
        return nil
    }

    // nonnull 和 nullable 状态未知
    public func createView33() -> UIView! {
        return nil
    }
}

struct aAs {
//    UnitDuration
    
}


struct VoidTest {
    func func1(value: () -> ()) {
        value()
    }
    func func2(value: (Void) -> ()) {
        value(())
    }
    
    func func3() { }
    func func4(value: Void) { }
    
    func test() {
        func1(value: func3)
        func2(value: func3)
        func2(value: func4)
    }
    
}

func zipTest() -> Void{
    let arr1 = ["a", "b", "c"]
    let arr2 = ["d", "e", "f"]
    
    for (value1, value2) in zip(arr1, arr2) {
        print(value1, value2)
    }
}

struct StructAndClassTest: Runable {
    static func run() {
        print("\n\n=================== Struct And Class ====================")
        structTest()
        classTest()
        essenceOfInitialization()
        identityOperatorsTest()
        memoryLayoutOfStructTest()
//        Choosing Between Structures and Classes https://developer.apple.com/documentation/swift/choosing_between_structures_and_classes
    }
    
    static func structTest() {
        print("\n-----------------结构体测试----------------")
        // 通过 struct 关键词定义结构体
        struct SomeStructure {
            // 在这里定义结构体
        }
        
        struct Structure {
            var v1 = 0
            var v2: Int
            var v3: Int?
            var v4: Int = 10
        }
//        1. 所有结构体都有一个自动生成的成员逐一构造器，用于初始化新结构体实例中成员的属性。规则是对于没有默认值的成员变量必须在构造函数显示初始化，有默认值的成员变量可以在构造函数选择性初始化。
        //比如在下面这个例子中，只有v2是required的且没有默认值，则构造器中必须有v2这个成员变量的初始化，v1和v4有初始值，v3是Optional类型默认为nil，因此初始化构造器中可以没有这些参数；
        var s1 = Structure(v2: 10)
        s1 = Structure(v1:5, v2: 10)
        s1 = Structure(v2: 10, v3: 15)
        s1 = Structure(v1: 5, v2: 10, v3: 15)
        s1 = Structure(v1: 5, v2: 10, v3: 15, v4: 20)
        print(s1)
        
        // 2. 如果结构体自定义了构造函数，则编译器不会在生成其他默认的构造函数
        struct Resolution {
            var width = 0
            var height = 0
            init(width: Int, height: Int) {
                self.width = width
                self.height = height
            }
        }
        var resolution = Resolution(width: 10, height: 10)
//      resolution = Resolution()   编译报错，显示定义了构造函数，不再提供默认的构造函数
//      resolution = Resolution(width: 10)  编译报错，显示定义了构造函数，不再提供默认的构造函数
        print(resolution)
        
        // 3. 可以通过使用点语法访问实例的属性。其语法规则是，实例名后面紧跟属性名，两者以点号（.）分隔，不带空格
        resolution.width = 20
        print(resolution.width, resolution.height)
        
        let resolution1 = Resolution(width: 10, height: 10)
        // 4. 编译器报错，如果结构体变量被声明为了 let 常量，则结构体整体无法修改，因为结构体是值类型
//        resolution1.height = 10
        print(resolution1)
        
        // 结构体和枚举都是值类型
        var resolution2 = resolution // 将 resolution 赋值给 resolution2，因为结构体是值类型，因此会将 resolution 中的所有值拷贝到 resolution2中。现在 resolution 和 resolution2 是两个完全独立的实例，但是包含相同的值
        print(resolution)
        resolution2.width = 100 // 结构体是值类型，修改 resolution2 不会影响 resolution 中的值
        print("resolution:", resolution)
        print("resolution2:", resolution2)
        
        
        // 5. 标准库定义的集合，例如Array、Dictionary、String，都对复制进行了优化以降低性能成本。新集合不会立即复制，而是跟原集合共享同一份内存，共享同样的元素。在集合的某个副本要被修改前，才会复制它的元素。而你在代码中看起来就像是立即发生了复制 copy on write
        
    }
    
    static func classTest() {
        print("\n-----------------类测试----------------")
        // 通过 class 关键词定义类
        class SomeClass {
            // 在这里定义结构体
        }
        struct Resolution {
            var width = 0
            var height = 0
        }
        class VideoMode {
            var resolution = Resolution()
            var interlaced = false
            var frameRate = 0.0
            var name: String?
        }
        
        class VideoMode1 {
            var resolution = Resolution()
            var interlaced = false
            var frameRate = 0.0
            var name: String?
            init(resolution: Resolution, interlaced: Bool, frameRate: Double, name: String) {
                self.resolution = resolution
                self.interlaced = interlaced
                self.frameRate = frameRate
                self.name = name
            }
        }
        
        // 1. 与结构体不同，类实例没有默认的成员逐一构造器; 1）如果类的所有成员变量都有一个默认值，则会提供一个无参数的默认构造器；2）如果为类显示定义了构造器，则不会提供无参数的默认构造器
        let videoMode = VideoMode() // VideoMode所有成员变量有默认值，且没有显示定义构造器，因此有一个默认无参数构造器，但没有成员逐一构造器
        let videoMode1 = VideoMode1(resolution: Resolution(), interlaced: true, frameRate: 60.0, name: "DH") // VideoMode1 为类显示定义了构造器，则不会提供无参数的默认构造器
        print(videoMode, videoMode1)
        
//        videoMode = VideoMode(); // videoMode 是常量，无法修改，编译器报错，这里修改的是引用的对象，即 videoMode 这个常量值将改变
        videoMode.frameRate = 60.0 // videoMode 是引用类型，可以修改成员值，因为 videoMode 这个常量值本身没有改变，videoMode 本身不存储实例，只是引用了实力，改变的是底层 VideoMode 实例的 frameRate 属性，而不是指向 VideoMode 常量引用的值
        
        let videoModeCopy = videoMode // videoMode 是引用类型，因此是浅拷贝，只是指针的复制，videoModeCopy 和 videoMode 引用的同一个对象
        videoModeCopy.frameRate = 30.0 // videoMode.frameRate 跟着被改变
        print("videoModeCopy.frameRate:", videoModeCopy.frameRate)
        print("videoMode.frameRate:", videoMode.frameRate)
    }
    
    
    /// 初始化的本质
    static func essenceOfInitialization() {
        print("\n-----------------结构体&类：默认初始化值的本质----------------")
        // 下面定义的 Resolution 完全等价，第一个是直接将 width 和 height 设置默认值，第二个是在构造器中设置默认值。第一个的本质就是第二个，只不过是编译器帮助做了这件事，通过汇编可以看出两种形式定义 Resolution，初始化时候都是第二个那种形式的初始化。
        func defaultValue () {
            struct Resolution {
                var width = 10
                var height = 11
            }
            let resolution = Resolution()
            print(resolution)
        }
        
        func defalueValueWithInitialization() {
            struct Resolution {
                var width: Int
                var height: Int
                init() {
                    self.width = 10
                    self.height = 11
                }
            }
            let resolution = Resolution()
            print(resolution)
        }
        
        defaultValue()
        defalueValueWithInitialization()
    }
    
    
    static func memoryLayoutOfStructTest() {
        print("\n-----------------结构体：内存布局测试----------------")
        struct Resolution {
            var width = 10
            var height = 11
        }
        print("Resolution实际占用内存大小（Byte）：", MemoryLayout<Resolution>.size, // print 16
              "Resolution被分配内存大小（Byte）：", MemoryLayout<Resolution>.stride, // print 16
              "Resolution内存对齐大小（Byte）：", MemoryLayout<Resolution>.alignment) // print 8
        
        struct Resolution1 {
            var width = 10
            var height = 11
            var isHD = false
        }
        print("Resolution1实际占用内存大小（Byte）：", MemoryLayout<Resolution1>.size, // print 17
              "Resolution1被分配内存大小（Byte）：", MemoryLayout<Resolution1>.stride, // print 24
              "Resolution1内存对齐大小（Byte）：", MemoryLayout<Resolution1>.alignment) // print 8
        
        struct Resolution2 {
            var isHD = true // 占用一个字节
            var width: Int32 = 10 // 占用4个字节，但是isHD需要补齐3个字节
            var height = 11 // 8个字节
        }
        var r2 = Resolution2()
        print("Resolution2实际占用内存大小（Byte）：", MemoryLayout<Resolution2>.size, // print 16
              "Resolution2被分配内存大小（Byte）：", MemoryLayout<Resolution2>.stride, // print 16
              "Resolution2内存对齐大小（Byte）：", MemoryLayout<Resolution2>.alignment) // print 8
        
        
        struct Resolution3 {
            var isHD = true // 占用一个字节
            var width: Int32 = 10 // 占用4个字节，但是isHD需要补齐3个字节
            var height = 11 // 8个字节
            func test1() {
            }
            static func test2() {
            }
        }
        // Resolution3 和 Resolution2 占用内存大小一样，方法本身不占用对象的内存，方法函数都存在代码段
        print("Resolution3实际占用内存大小（Byte）：", MemoryLayout<Resolution3>.size, // print 16
              "Resolution3被分配内存大小（Byte）：", MemoryLayout<Resolution3>.stride, // print 16
              "Resolution3内存对齐大小（Byte）：", MemoryLayout<Resolution3>.alignment) // print 8
    }
    
    /// 恒等运算符，判定两个常量或者变量是否引用同一个类实例有时很有用。用于判断引用类型（class）是否引用同一个实例
    /// 相同（===）
    /// 不相同（!==）
    /// 对于值类型，直接使用 == 和 != 判断是否相同即可，== 表示两个实例的值是否相同。当在自定义结构体和类的时候，可以通过重载 == 运算符，决定两个实例“相等”的标准，即比较自己关心的自定义数据。
    static func identityOperatorsTest() {
        print("\n-----------------恒等运算符测试----------------")
        class Test {
            
        }
        let a = Test()
        let b = a
        let c = Test()
        print(a === b, a === c) // === 比较引用类型
        
        let a1 = 10
        let b1 = 10
        print(a1 == b1) // == 比较值类型
    }
}






