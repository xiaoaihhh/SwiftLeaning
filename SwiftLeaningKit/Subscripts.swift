//
//  Subscripts.swift
//  SwiftLeaningKit
//
//  Created by fanshuaifei on 2021/5/15.
//  Copyright © 2021 SwiftLeaning. All rights reserved.
//

import Foundation

struct SubscriptsTest: Runable {
    static func run() {
        print("\n\n=================== Subscripts ====================")
        subscriptDefineTest()
        subscriptOptions()
        typeSubscripts()
    }
    
    // 下标可以定义在类、结构体和枚举中，是访问集合、列表或序列中元素的快捷方式。一个类型可以定义多个下标，通过不同索引类型进行对应的重载。
    
    static func subscriptDefineTest() {
        print("\n-----------------下标：下标定义测试----------------")
        // 下标语法
        // 1. 和函数定义类似，通过 subscript 定义，后面跟参数和返回值类型（和函数的参数和返回值类型定义方式一样）。本质就是函数。
        // 2. 大括号内部和属性的 get 和 set 定义类似（可以没有 set，必须要有 get）
        //    1）set 可以省略参数，有一个隐式的参数 newValue。如果只有 get 则是只读下标，不可以通过下标设置值，定义时 get 也可以省略。
        //        subscript(paramater) -> return type {
        //            get {
        //
        //            }
        //            set(newValue) {
        //
        //            }
        //        }
        
        struct TimesTable {
            let multiplier: Int
            subscript(index: Int) -> Int {
                index * multiplier // 只读下标, 省略 get 关键词
                // get {
                //     index * multiplier
                // }
            }
        }
        let timesTable = TimesTable(multiplier: 10)
        print(timesTable[1], timesTable[10]) // 10 100
        // timesTable[1] = 10 // 编译报错，该下标是只读的
    }
    
    ///  下标选项
    static func subscriptOptions() {
        print("\n-----------------下标：下标选项测试----------------")
        struct Matrix {
            let rows: Int
            let columns: Int
            var grid: [Int]
            init(rows: Int, columns: Int) {
                self.rows = rows
                self.columns = columns
                grid = Array(repeating: 0, count: rows * columns)
            }
            func indexIsValid(rows: Int, columns: Int) -> Bool {
                return rows >= 0 && rows < self.rows && columns >= 0 && columns < self.columns
            }
            
            // 下标可以接受任意数量的入参，，并且为这些参数提供默认值，如在可变参数 和 默认参数值 中所述。这些入参可以是任何类型，下标的返回值也可以是任意类型。但是，下标不能使用 in-out 参数。
            subscript(rows: Int, columns: Int) -> Int { // 接受两个参数
                get {
                    assert(indexIsValid(rows: rows, columns: columns))
                    return grid[rows * self.columns + columns]
                }
                set {
                    assert(indexIsValid(rows: rows, columns: columns))
                    grid[rows * self.columns + columns] = newValue
                }
            }
            
            subscript(array: [Double]) -> Double { // 接受数组参数，返回 Double
                var sum = 0.0
                for element in array {
                    sum += element
                }
                return sum
            }
            
            subscript(strs: String ...) -> String { // 接受可变参数
                var appendStr = ""
                for str in strs {
                    appendStr += str
                }
                return appendStr
            }
            
            subscript(index1: Int = 0) -> Int { // 接受带有默认值的参数
                return 2021
            }
        }
        
        var matrix = Matrix(rows: 5, columns: 6)
        for row in 0..<matrix.rows {
            for column in 0..<matrix.columns {
                matrix[row, column] = row * matrix.columns + column
            }
        }
        for row in 0..<matrix.rows {
            for column in 0..<matrix.columns {
                print(matrix[row, column])
            }
        }
        
        print("--------\n", matrix[[1.0, 3.5, 8.9]])
        print("--------\n", matrix["hello", "world"])
        print("--------\n", matrix[])
    }
    
    
    /// 类型下标
    /// 可以定义一种在这个类型自身上调用的下标，称作类型下标。在 subscript 关键字之前使用 static 关键字修饰，来定义一个类型下标。类类型可以使用 class 关键词代替 static，使用 class 修饰的类型下标允许子类重写父类中对那个下标的实现。
    static func typeSubscripts() {
        print("\n-----------------下标：类型下标测试----------------")
        class SomeClass {
            static subscript(index: Int) -> Double {
                10.0
            }
            class subscript(str: String) -> String {
                get {
                    "hello world"
                }
                set {
                    
                }
            }
        }
        
        class SomeSubClass: SomeClass {
            // 重写 class 修饰的下标，如果父类是读写的子类也需要是读写的；如果父类是只读的，则子类可以是只读的，也可以是读写的
            override class subscript(str: String) -> String {
                get {
                    "SubClass: " + super[str]
                }
                set {
                    
                }
            }
        }
        print(SomeClass[-1])
        print(SomeClass["test"])
        print(SomeSubClass["test"])
    }
}
