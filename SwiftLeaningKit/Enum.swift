//
//  Enum.swift
//  SwiftLeaningKit
//
//  Created by fanshuaifei on 2021/5/6.
//  Copyright © 2021 SwiftLeaning. All rights reserved.
//

import Foundation
import UIKit

struct EnumTest: Runable {
    static func run() {
        print("\n\n=================== Enum ====================")
        enumDefineTest()
        iteratingOverEnumerationCasesTest()
        associatedValuesTest()
        rawValueTest()
        recursiveEnumerations()
        memoryLayoutOfEnumTest()
    }
    
    ///    枚举
    ///    1. C 语言中，枚举会为一组整型值分配相关联的名称。Swift 中的枚举更加灵活，不必给每一个枚举成员提供一个值，如果给枚举成员提供一个值（称为原始值），则该值的类型可以是字符串、字符，或是一个整型值或浮点数。
    ///    2. 枚举成员可以指定任意类型的关联值存储到枚举成员中，就像其他语言中的联合体（unions）和变体（variants）。你可以在一个枚举中定义一组相关的枚举成员，每一个枚举成员都可以有适当类型的关联值。
    ///    3.  Swift 中，枚举类型是一等（first-class）类型，可以提供计算属性、方法、构造函数、遵守协议
    
    /// 枚举定义
    static func enumDefineTest() {
        print("\n-----------------枚举：定义测试----------------")
        // Swift 的枚举成员在被创建时不会被赋予一个默认的整型值；north、south、east、west 不会被隐式地赋值为 0，1，2 和 3，每一个枚举成员本身就是已经明确定义好的 CompassPoint 类型。
        enum CompassPoint {
            case north // 通过关键词 case 后面跟枚举成员名，定义一个枚举成员
            case south, east // 关键词 case 后也可以跟多个枚举成员名，用逗号隔开
            case west
        }
        
        func printDirection(_ direction: CompassPoint) {
            switch direction {
            case .east:
                print("east")
            case .north:
                print("north")
            case .west:
                print("west")
            case .south:
                print("south")
            }
        }
        
        var direction = CompassPoint.north
        print(direction, direction.self)
        direction = direction == .east ? .north : .west
        printDirection(direction)
        printDirection(.east)
    }
    
    
    /// 遍历枚举成员
    static func iteratingOverEnumerationCasesTest() {
        print("\n-----------------枚举：遍历枚举成员测试----------------")
        // 1. 令枚举遵循 CaseIterable 协议，Swift 会生成一个 allCases 属性，用于表示一个包含枚举所有成员的集合。
        enum Beverage: CaseIterable {
            case coffee, tea, juice
        }
        for item in Beverage.allCases {
            print(item, "type is", type(of: item))
        }
    }
    
    
    /// 关联值（Associated Values），将枚举成员值和其他类型的值关联存储在一起，枚举的这种特性跟其他语言中的可识别联合（discriminated unions），标签联合（tagged unions），或者变体（variants）相似。
    /// 1. 可以定义 Swift 枚举来存储任意类型的关联值，如果需要的话，每个枚举成员的关联值类型可以各不相同。
    /// 2. 关联类型可以是任意类型，例如 Int、String、Array、Dictionary、其它枚举类型、类等等。
    /// 3.  关联类型不能遵循 CaseIterable 协议来获取所有的枚举成员
    /// 4.  可以使用 switch 语句来检查枚举常量/变量的类型，并在 case 分支代码中提取每个关联值作为一个常量（用 let 前缀）或者作为一个变量（用 var 前缀）来使用
    static func associatedValuesTest() {
        print("\n-----------------枚举：关联值测试----------------")
        // 枚举成员值为grade和points，将grade和换一个String类型的值关联存储起来，points和一个Int类型的值关联存储起来
        enum Score {
            case grade(Character) // 等级分数
            case points(Int)
        }
        
        func printScore(_ value: Score) {
            switch value {
            case let .grade(v): // 将关联值绑定到v这个变量中，方便case语句使用
                print(v)
            case let .points(v):
                print(v)
            }
        }
        
        var score = Score.grade("E") // 定义枚举时可以给每一个枚举值关联一个指定类型的数据，例如给grade关联一个Character类型的"E"
        printScore(score)
        score = .points(10)
        printScore(score)
        
        
        enum Barcode {
            case upc(Int, Int, Int, Int)
            case qrCode(String)
        }
        func printBarcode(_ barCode: Barcode) {
            switch barCode {
            case let .upc(x, y, z, h): // 使用 x, y, z, h 提取 .upc 类型中的关联值
                print(x, y, z, h)
            case let .qrCode(x):
                print(x)
            }
        }
        var productBarcode = Barcode.upc(8, 85909, 51226, 3) // 创建了一个名为 productBarcode 的变量，并将 Barcode.upc 赋值给它，Barcode.upc关联的元组值为 (8, 85909, 51226, 3)
        printBarcode(productBarcode)
        productBarcode = .qrCode("ABCDEFGHIJKLMNOP")
        printBarcode(productBarcode)
        enum Date {
            case digit(year: Int, month: Int, day: Int) // 可以给每一个关联值添加一个标签，和定义函数类似
            case string(String)
        }
        
        func printDate(_ date: Date) {
            switch date {
            case let .digit(year: x, month: y, day: z): // 也可以 .digit(year: let x, month: let y, day: let z):，把let写到前面更简洁；也可以使用 var 替代 let
                print(x, y, z, separator: "-")
            case .string(let x):
                print(x)
            }
        }
        printDate(.digit(year: 2021, month: 05, day: 10))
        printDate(.string("2021/05/10"))
    }
    
    
    /// 原始值（RawValue），枚举成员可以被默认值（称为原始值）预填充，这些原始值的类型必须相同。
    /// 1. 关联值和原始值是互斥关系，定义关联值就不能定义原始值，定义原始值就不能定义关联值的枚。
    /// 2. 原始值和关联值是不同的，原始值是在定义枚举时被预先填充的值，对于一个特定的枚举成员，它的原始值始终不变。关联值是创建一个基于枚举成员的常量或变量时才设置的值，枚举成员的关联值可以变化。
    /// 3. 原始值可以是字符串、字符，或者任意整型值或浮点型值。每个原始值在枚举声明中必须是唯一的。在枚举类型后面加 : Type 即可说明原始值类型。
    /// 4. 对于有原始值的枚举类型，可以通过枚举成员的 rawValue 属性访问该枚举成员的原始值
    static func rawValueTest() {
        print("\n-----------------枚举：原始值测试----------------")
        enum ASCIIControlCharacter: Character {
            case tab = "\t" //  可以为每一个枚举成员赋值一个默认值（原始值）
            case lineFeed = "\n"
            case carriageReturn = "\r"
        }
        
        print(ASCIIControlCharacter.tab, ASCIIControlCharacter.lineFeed, ASCIIControlCharacter.carriageReturn)
        
        
        /// 原始值的隐式赋值(Implicitly Assigned Raw Values)
        // 1. 在使用原始值为整数或者字符串类型的枚举时，不需要显式地为每一个枚举成员设置原始值，Swift 将会自动为你赋值。
        
        // 如果使用整形作为枚举成员，隐式赋值的值依次递增 1；
        enum Planet: Int {
            case mercury = 1, venus, earth, mars = 6, jupiter, saturn, uranus, neptune
      // 原始值依次为 1            2      3      6          7       8       9       10
        }
        
        // 当使用字符串作为枚举类型的原始值时，每个枚举成员的隐式原始值为该枚举成员的名称。
        enum CompassPoint: String {
            case north,    south,     east,    west
   // 原始值依次为 "north"   "south"    "east"   "west"
        }
        
        /// 对于有原始值的枚举类型，可以通过枚举成员的 rawValue 属性访问该枚举成员的原始值
        print(Planet.jupiter.rawValue)
        print(CompassPoint.south.rawValue)
        
        /// 如果在定义枚举类型的时候使用了原始值，那么将会自动获得一个初始化方法，这个方法接收一个叫做 rawValue 的参数，参数类型即为原始值类型，返回值则是枚举成员或 nil。你可以使用这个初始化方法来创建一个新的枚举实例。
        /// 原始值构造器是一个可失败构造器，因为并不是每一个原始值都有与之对应的枚举成员。
        let planet = Planet.init(rawValue: 7) // planet是可选类型的，这里构造成功，因为存在原始值为 7 的枚举成员
        print(planet ?? "原始值为 7 的枚举成员不存在")
        let point = CompassPoint(rawValue: "west1") //  point是可选类型的，这里构造失败，因为不存在原始值为 "west1" 的枚举成员
        print(point ?? "原始值为 west1 的枚举成员不存在")
    }
    
    
    /// 递归枚举（Recursive Enumerations）
    /// 递归枚举是一种枚举类型，它有一个或多个枚举成员使用该枚举类型的实例作为关联值。使用递归枚举时，编译器会插入一个间接层。你可以在枚举成员前加上 indirect 来表示该成员可递归。
    static func recursiveEnumerations() {
        print("\n-----------------枚举：递归枚举测试----------------")
        // indirect 可以放在 enum 前面，表示所有枚举成员都是可递归的，也可放在 case 前面，表示一个枚举成员是可递归的
        indirect enum ArithmeticExpression { // 算数表达式
            case number(Int) // 定义纯数字
            case addition(ArithmeticExpression, ArithmeticExpression) // 定义两个表达式相加
            case multiplication(ArithmeticExpression, ArithmeticExpression) // 定义两个表达式相乘
        }
        
        func evaluate(_ expression: ArithmeticExpression) -> Int { // 对算数表达式求值
            switch expression {
            case .number(let value):
                return value
            case .addition(let expression1, let expression2):
                return evaluate(expression1) + evaluate(expression2)
            case .multiplication(let expression1, let expression2):
                return  evaluate(expression1) * evaluate(expression2)
            }
        }
        
        // 计算 (5 + 4) * 2
        let five = ArithmeticExpression.number(5)
        let four = ArithmeticExpression.number(4)
        let constant = ArithmeticExpression.number(2)
        let sum = ArithmeticExpression.addition(five, four)
        let product = ArithmeticExpression.multiplication(sum, constant)
        print(evaluate(product))
    }
    
    
    /// 枚举内存布局分析
    static func memoryLayoutOfEnumTest() {
        print("\n-----------------枚举：内存布局测试----------------")
        /* -------------首先测试直接定义的枚举或者有原始值类型的枚举---------------------*/
        enum CompassPoint {
            case north, south, east, west
        }
        print("CompassPoint实际占用内存大小（Byte）：", MemoryLayout<CompassPoint>.size, // print 1
              "CompassPoint被分配内存大小（Byte）：", MemoryLayout<CompassPoint>.stride,  // print 1
              "CompassPoint内存对齐大小（Byte）：", MemoryLayout<CompassPoint>.alignment) // print 1
        
        enum PlanetMax8: Int {
            case mercury = 1, venus = 2, earth = 3, mars = 4, jupiter = 5, saturn = 6, uranus = 7, neptune = 8
        }
        print("PlanetMax8实际占用内存大小（Byte）：", MemoryLayout<PlanetMax8>.size, // print 1
              "PlanetMax8被分配内存大小（Byte）：", MemoryLayout<PlanetMax8>.stride, // print 1
              "PlanetMax8内存对齐大小（Byte）：", MemoryLayout<PlanetMax8>.alignment) // print 1
        
        enum PlanetString: String {
            case mercury, venus, earth, mars, jupiter, saturn, uranus, neptune = "xxxxxxxx" // 最后一个case原始值需要内存大小（Byte）大于 1 字节
        }
        print("PlanetString实际占用内存大小（Byte）：", MemoryLayout<PlanetString>.size, // print 1
              "PlanetString被分配内存大小（Byte）：", MemoryLayout<PlanetString>.stride, // print 1
              "PlanetString内存对齐大小（Byte）：", MemoryLayout<PlanetString>.alignment) // print 1
        
        enum PlanetMax800: Int {
            case mercury = 100, venus = 200, earth = 300, mars = 400, jupiter = 500, saturn = 600, uranus = 700, neptune = 800
        }
        print("PlanetMax800实际占用内存大小（Byte）：", MemoryLayout<PlanetMax800>.size, // print 1
              "PlanetMax800被分配内存大小（Byte）：", MemoryLayout<PlanetMax800>.stride, // print 1
              "PlanetMax800内存对齐大小（Byte）：", MemoryLayout<PlanetMax800>.alignment) // print 1
        
        print("Case300实际占用内存大小（Byte）：", MemoryLayout<Case300>.size, // print 2
              "Case300被分配内存大小（Byte）：", MemoryLayout<Case300>.stride, // print 2
              "Case300内存对齐大小（Byte）：", MemoryLayout<Case300>.alignment) // print 2
        
        // 结论1： 以上测试说明，对于直接定义的枚举或者有原始值类型的枚举，占用内存大小（Byte）只和枚举成员个数有关，字节表示无符号大小 >= 枚举个数，例如1 ~ 2^8 个 case 占用 1 字节，2^8 + 1 ~ 2^16 个 case 2 个字节，依此类推
        
        /* -------------下面测试具有关联值类型的枚举---------------------*/
        // 先了解下String占用内存大小（Byte）
        print("String实际占用内存大小（Byte）：", MemoryLayout<String>.size, // print 16
              "String被分配内存大小（Byte）：", MemoryLayout<String>.stride, // print 16
              "String内存对齐大小（Byte）：", MemoryLayout<String>.alignment) // print 8
        
        enum Barcode {
            case upc(Int64, Int, Int, Int)
            case qrCode(String)
        }
        print("Barcode实际占用内存大小（Byte）：", MemoryLayout<Barcode>.size, // print 33，upc占用4*8=32，qrCode占用16，取两者大的，即存储关联值需要32字节； 存储枚举成员本身需要1字节；共33字节
              "Barcode被分配内存大小（Byte）：", MemoryLayout<Barcode>.stride, // print 40，因为8字节对齐，因此最红实际被分配40字节
              "Barcode内存对齐大小（Byte）：", MemoryLayout<Barcode>.alignment) // print 8
        
        enum Barcode1 {
            case upc(String, String, String, String)
            case qrCode(String)
        }
        print("Barcode1实际占用内存大小（Byte）：", MemoryLayout<Barcode1>.size, // print 65，upc占用4*16=64，qrCode占用16，取两者大的，即存储关联值需要64字节； 存储枚举成员本身需要1字节；共65字节
              "Barcode1被分配内存大小（Byte）：", MemoryLayout<Barcode1>.stride, // print 72，因为8字节对齐，因此最红实际被分配72字节
              "Barcode1内存对齐大小（Byte）：", MemoryLayout<Barcode1>.alignment) // print 8
        
        enum Barcode2 {
            case qrCode(Int8)
            case qrCode1(Int8)
            case qrCode2(Int64)
            case upc(Int64, Int8, Int32, Int64) //(Int64, Int8, Int32, Int64) // (Int8, Int64, Int32, Int64)
        }
        var bar2 = Barcode2.upc(11,4,9,11)
        print(Mems.size(ofVal: &bar2))
        print(Mems.memStr(ofVal: &bar2))
        print("Barcode2实际占用内存大小（Byte）：", MemoryLayout<Barcode2>.size, // print 65，upc占用4*16=64，qrCode占用16，取两者大的，即存储关联值需要64字节； 存储枚举成员本身需要1字节；共65字节
              "Barcode2被分配内存大小（Byte）：", MemoryLayout<Barcode2>.stride, // print 72，因为8字节对齐，因此最红实际被分配72字节
              "Barcode2内存对齐大小（Byte）：", MemoryLayout<Barcode2>.alignment) // print 8
        
//        for i in 1...300 { // 生成case代码
//            print("case", i, ",", separator: "", terminator: " ")
//        }
    }
    
    enum Case300 {
        case case1, case2, case3, case4, case5, case6, case7, case8, case9, case10, case11, case12, case13, case14, case15, case16, case17, case18, case19, case20, case21, case22, case23, case24, case25, case26, case27, case28, case29, case30, case31, case32, case33, case34, case35, case36, case37, case38, case39, case40, case41, case42, case43, case44, case45, case46, case47, case48, case49, case50, case51, case52, case53, case54, case55, case56, case57, case58, case59, case60, case61, case62, case63, case64, case65, case66, case67, case68, case69, case70, case71, case72, case73, case74, case75, case76, case77, case78, case79, case80, case81, case82, case83, case84, case85, case86, case87, case88, case89, case90, case91, case92, case93, case94, case95, case96, case97, case98, case99, case100, case101, case102, case103, case104, case105, case106, case107, case108, case109, case110, case111, case112, case113, case114, case115, case116, case117, case118, case119, case120, case121, case122, case123, case124, case125, case126, case127, case128, case129, case130, case131, case132, case133, case134, case135, case136, case137, case138, case139, case140, case141, case142, case143, case144, case145, case146, case147, case148, case149, case150, case151, case152, case153, case154, case155, case156, case157, case158, case159, case160, case161, case162, case163, case164, case165, case166, case167, case168, case169, case170, case171, case172, case173, case174, case175, case176, case177, case178, case179, case180, case181, case182, case183, case184, case185, case186, case187, case188, case189, case190, case191, case192, case193, case194, case195, case196, case197, case198, case199, case200, case201, case202, case203, case204, case205, case206, case207, case208, case209, case210, case211, case212, case213, case214, case215, case216, case217, case218, case219, case220, case221, case222, case223, case224, case225, case226, case227, case228, case229, case230, case231, case232, case233, case234, case235, case236, case237, case238, case239, case240, case241, case242, case243, case244, case245, case246, case247, case248, case249, case250, case251, case252, case253, case254, case255, case256, case257, case258, case259, case260, case261, case262, case263, case264, case265, case266, case267, case268, case269, case270, case271, case272, case273, case274, case275, case276, case277, case278, case279, case280, case281, case282, case283, case284, case285, case286, case287, case288, case289, case290, case291, case292, case293, case294, case295, case296, case297, case298, case299, case300
    }
}

