//
//  Overload.swift
//  SwiftLeaningKit
//
//  Created by fanshuaifei on 2020/7/28.
//  Copyright © 2020 SwiftLeaning. All rights reserved.
//

import Foundation

class Overload: Runable {
    func doThing(value: Int) { }
    func doThing(value: Double) { }
    func doThing(value: inout Int) { }
    func doThing(_ value: Int) { }
    func doThing(value1: Int) { }
    func doThing(value: Int) -> Int { 5 }
    func doThing(value: Int) -> Double { 5.0 }
    func doThing(value: Int, value1: Double) { }
    func doThing(value: Double, value1: Int) { }
    func doThing(value: Int...) { }
    
    static func run() {
    }
    func run() {
        doThing(value: 0.1)
        doThing(value: 0.1, value1: 4)
//        let a = doThing(value: 5) 类型无法推断调用哪个
        let b:Int = doThing(value: 5)
    }
}
