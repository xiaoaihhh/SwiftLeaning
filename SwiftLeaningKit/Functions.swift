//
//  Functions.swift
//  SwiftLeaningKit
//
//  Created by fanshuaifei on 2020/8/2.
//  Copyright © 2020 SwiftLeaning. All rights reserved.
//

import Foundation

struct FunctionsTest: Runable {
    static func run() {
        print("\n\n=================== Functions ====================")
        functionDefineTest()
        defaultParameterValuesTest()
        variadicParameterTest()
        inOutParametersTest()
        functionTypesTest()
        nestedFunctions()
    }
    
    /// 函数定义
    static func functionDefineTest() {
        //        通过func关键字定义，格式如下
        //        1）可以省略参数，表示无参数函数；
        //        2）可以省略返回值，表示无返回值的函数。严格地说，即使没有明确定义返回值，函数仍然返回一个值，即 Void 类型，Void 为一个空元组，Void 定义为：public typealias Void = ()
        //        3）函数可以通过返回元组来同时返回多个值；
        //        4）函数调用格式为 functionName(argumentLabel1:x, argumentLabel2:y)
        //        5）argumentLabel表示参数标签，函数调用时候使用；parameterName表示参数名称，函数体内部当作行参使用
        //        6）argumentLabel 和 parameterName 可以合并成一个，即作为参数标签，又作为参数名称；argumentLabel可以省略，使用 _ 代替，这样函数调用时候也可省略；
        //        7）如果一个函数的整个函数体是一个单行表达式，这个函数可以隐式地返回这个表达式，即可以省略 return 关键词。
        //        func functionName(argumentLabel1 parameterName1: Type, argumentLabel2 parameterName2: Type) -> returnType {}
        
        
        print("\n-----------------函数：定义测试----------------")
        
        func greetString() -> String { // 无参数函数
            return "hello"
        }
        print(greetString())
        
        func greet(person: String) -> Void { // 无返回值函数，等同于 func greet(person: String) -> Void {
            print("Hello, \(person)!")
        }
        greet(person: "Lily")
        
        func minMax(v1: Int, v2: Int) -> (min: Int, max: Int) { // 返回元组，并定义好元组成员名字
            return v1 > v2 ? (v2, v1) : (v1, v2)
        }
        let minMax = minMax(v1: 10, v2: 20)
        print("min:", minMax.min, "max:", minMax.max) // 可以直接使用元组成员名字
        func minMax1(v1: Int, v2: Int) -> (Int, Int) {  // 返回元组，只定义好元组返回类型
            return v1 > v2 ? (v2, v1) : (v1, v2)
        }
        let (min, max) = minMax1(v1: 20, v2: 30) // 调用时候给元组成员分解成不同常量
        print("min:", min, "max:", max)
        
        /// 可选元组返回类型
        // 可选元组类型如 (Int, Int)? 与元组包含可选类型如 (Int?, Int?) 是不同的。可选的元组类型，整个元组是可选的，而不只是元组中的每个元素值。
        // (Int, Int)? 元组可以说是 nil，但是如果元组不是 nil，元组成员一定不是 nil；
        // (Int?, Int?) 元组不能是 nil，但是元组成员可能是 nil；
        
        // 隐式返回的函数
        func greeting(for person: String) -> String {
            "Hello, " + person + "!" // 函数体是一个单行表达式，省略 return，隐式返回一个 String
        }
        
        // person即作为参数标签，又作为参数名称；from是第二个参数的标签，hometown是第二个参数的名称
        // 参数标签的使用能够让一个函数在调用时更有表达力，更类似自然语言，并且仍保持了函数内部的可读性以及清晰的意图
        func greet(person: String, from hometown: String) -> String {
            return "Hello \(person)!  Glad you could visit from \(hometown)."
        }
        print(greet(person: "Bill", from: "Cupertino"))
        
        // 通过 _ 省略参数标签
        func someFunction(_ firstParameterName: Int, secondParameterName: Int) {
            // 在函数体内，firstParameterName 和 secondParameterName 代表参数中的第一个和第二个参数值
        }
        someFunction(1, secondParameterName: 2)
    }
    
    /// 默认参数值
    /// 可以在函数体中通过给参数赋值来为任意一个参数定义默认值（Deafult Value）。当默认值被定义后，调用这个函数时可以忽略这个参数。
    /// 没有默认值的参数一般更加的重要，通常将不带有默认值的参数放在函数参数列表的最前。其它语言参数默认值只允许放在参数列表最后面，Swift 只要函数调用没有歧义，可以将默认值放在任意位置
    static func defaultParameterValuesTest() {
        print("\n-----------------函数：默认值测试----------------")
        func someFunction(num: Int = 10, num1: Int) { // 将默认值放在第一个参数，因为没有默认值的参数有参数标签，可以避免歧义
        }
        someFunction(num1: 10)
        func someFunction(num: Int = 10, _ name: String) { // 将默认值放在第一个参数，因为没有默认值的类型与有默认值类型不同，可以避免歧义
        }
        someFunction("A")
        func someFunction(_ num: Int = 10, _ name: Int) { // 无法避免歧义，调用时候不能省略第一个参数，不然调用代码无法编译通过
        }
        someFunction(num1: 10)
        someFunction("A")
        someFunction(10, 20) // someFunction(20) 编译器将报错，因为无法避免歧义
        
        // 总之，调用时候能否省略默认值，就看能否避免歧义，例如最后一个 someFunction 可以定义，但是调用无法省略默认值
    }
    
    /// 可变参数 （swift5.3只能有一个可变参数，5.4开始变成可以有多个）
    /// 通过在变量类型名后面加入 ... 的方式来定义可变参数，可以接受零个或多个值
    /// 可变参数的传入值在函数体中变为此类型的一个数组。
    /// 一个函数可以有多个可变参数，但可变参数后面的参数定义一定要有参数标签，用来避免歧义；可变参数本身不要求有参数标签，但是如果连续定义两个可变参数，第二个要定义参数标签；
    static func variadicParameterTest() {
        print("\n-----------------函数：可变参数测试----------------")
        func add(_ values: Int ...) { // values 是一个 [Int] 类型的数组常量
            var count = 0
            for v in values {
                count += v;
            }
            print("add count:", count)
        }
        add()
        add(1, 2)
        add(1, 2, 3, 4)
        
        func test(_ v1: Int ..., v2: Int) { // 可变参数后面参数的定义一定要有参数标签，用来避免歧义，省略 v2 标签将编译报错
        }
        test(1, 2, v2: 3)
        
        func test(_ v0: Int, _ v1: Int ..., v2: String) {
        }
        test(0, 1, 2, v2: "")
        
        func test(_ v1: Int ..., v2: Int, _ v3: Int ...) { // 定义多个可变参数
        }
        test(1, 2, v2: 3, 4, 5)
    }
    
    
    /// 输入输出参数
    /// 1. 函数参数默认是常量，试图在函数体中更改参数值将会导致编译错误。一方面可以让编译根据 copy on write 特性更好的优化内存，另一方面使得内存访问也更加安全，可读性变高，避免拿输入参数作为其它的用途使用。
    /// 2. 如果想要在一个函数内修改参数的值，并且想要这些修改在函数调用结束后仍然存在，那么就应该把这个参数定义为输入输出参数（In-Out Parameters）。定义一个输入输出参数时，在参数定义前加 inout 关键字。输入输出参数类似C语言中的指针。
    static func inOutParametersTest() {
        print("\n-----------------函数：输入输出参数测试----------------")
        func swapTwoInts(_ a: inout Int, _ b: inout Int) { // 将 a 和 b 定义为 inout 参数，函数体内可以修改 a 和 b
            (b, a) = (a, b) // 交换 a 和 b
        }
        var a = 10, b = 20
        swapTwoInts(&a, &b)
        print("a:", a, "b:", b)
        
        // 1. 只能传递变量给输入输出参数，不能传入常量或字面量，因为常量或字面量是不能被修改的。当传入的参数作为输入输出参数时，需要在参数名前加 & 符，表示这个值可以被函数修改。
        // 2. 输入输出参数不能有默认值，可变参数不能用 inout 标记。
        // 3. 输入输出参数是函数对函数体外产生影响的另一种方式。
        // 4. 对于 inout 类型参数，本质是地址传递，即将需要修改变量的地址作为函数参数，函数体直接修改传入地址所在内存的数据。和 C 指针本质一样。
    }
    
    /// 函数类型
    /// 每个函数都有种特定的函数类型，函数的类型由函数的参数类型和返回类型组成。
    static func functionTypesTest() {
        print("\n-----------------函数：函数类型测试----------------")
        func addTwoInts(_ a: Int, _ b: Int) -> Int { return a + b }
        func multiplyTwoInts(_ a: Int, _ b: Int) -> Int { return a * b }
        // 上面两个函数的函数类型都是 (Int, Int) -> Int， 即输入两个 Int 类型数据，返回一个 Int 类型数据
        
        // 如果一个函数没有返回值，则返回值默认是 Void 类型（上面函数定义有详细讲解），因此下面函数的函数类型是 () -> Void
        func printHelloWorld() { print("hello, world") }
        
        // 函数类型可以当作普通类型一样使用
        var mathFunction: (Int, Int) -> Int = addTwoInts(_:_:) // 也可以直接写成 addTwoInts，省略后面的 (_:_:)
        print("addTwoInts:", mathFunction(10, 10))
        mathFunction = multiplyTwoInts // 重新赋值，现在 mathFunction 引用 multiplyTwoInts 函数
        print("multiplyTwoInts:", mathFunction(10, 10))
        let mathFunctionAnother = addTwoInts // 使用类型推断，推断出 mathFunctionAnother 常量的类型为 (Int, Int) -> Int
        print("addTwoInts mathFunctionAnother:", mathFunctionAnother(100, 100))
        
        // 函数类型可以作为函数的参数，函数类型也可以被标记为 inout 参数
        func printMathResult(_ mathFunc: (Int, Int) -> Int, _ a: Int, _ b: Int) {
            print("函数类型作为参数", mathFunc(a, b))
        }
        printMathResult(addTwoInts(_:_:), 10, 10)
        printMathResult(multiplyTwoInts, 10, 10)
        
        // 函数类型作为返回值
        func stepForward(_ input: Int) -> Int { return input + 1 }
        func stepBackward(_ input: Int) -> Int { return input - 1 }
        func chooseStepFunction(backward: Bool) -> (Int) -> Int {
            return backward ? stepBackward : stepForward
        }
        print("chooseStepFunction:", chooseStepFunction(backward: true)(10))
        print("chooseStepFunction:", chooseStepFunction(backward: false)(10))
    }
    
    
    /// 嵌套函数（Nested Functions），即把函数定义在别的函数体中
    /// 1. 默认情况下，嵌套函数对外界不可见，但是可以被它们的直接外围函数（enclosing function）调用。一个函数也可以返回它的某一个嵌套函数，使得这个函数可以在其他域中被使用。
    /// 2. public 等访问控制不可以用在嵌套函数中
    static func nestedFunctions() {
        print("\n-----------------函数：嵌套函数测试----------------")
        func chooseStepFunction(backward: Bool) -> (Int) -> Int {
            func stepForward(input: Int) -> Int { return input + 1 }
            func stepBackward(input: Int) -> Int { return input - 1 }
            return backward ? stepBackward : stepForward
        }
        print("Nested Functions chooseStepFunction:", chooseStepFunction(backward: true)(10))
        print("Nested Functions chooseStepFunction:", chooseStepFunction(backward: false)(10))
        
        func nested1() {
            func nested2() {
                func nested3() {
                    // public func nested4() { } // 编译报错，public 等访问控制不可以用在嵌套函数中
                }
            }
            nested2()
            // nested3()  编译报错，对 nested1 不可见，嵌套函数只能被直接外围函数可见。
        }
    }
}
