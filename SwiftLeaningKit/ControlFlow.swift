//
//  ControlFlow.swift
//  SwiftLeaningKit
//
//  Created by fanshuaifei on 2020/8/2.
//  Copyright © 2020 SwiftLeaning. All rights reserved.
//

import Foundation

public struct ControlFlow: Runable {
    public static func run() {
        SwitchTest.run()
    }
}

enum Color {
    case red
    case green
    case blue
    case white
}

enum BarCode {
    case up(Int, Int)
    case low(String)
}

struct SwitchTest {
    static func run() {
        var color: Color?
        color = Color.red
        switch color! {
        case .red:
            print("red")
        case .green:
            print("green")
        case .blue:
            print("blue")
        case .white:
            print("white")
        }
        
        switch BarCode.low("low") {
        case .low(let str):
            print(str)
        case .up(let a, let b):
            print("\(a), \(b)")
        }
        
        let money = 0.0
        switch money {
        case 0:
            print("zero money")
        case let x where x > 0:
            print("has money")
        default:
            print("no money")
        }
        
        
        
//        func arithmeticMean(numbers: Double..., numbers: Double...) -> Double {
//            var total: Double = 0
//            for number in numbers {
//                total += number
//            }
//            return total / Double(numbers.count)
//        }
    }
}
