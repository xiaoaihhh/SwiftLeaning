//
//  Closures.swift
//  SwiftLeaningKit
//
//  Created by fanshuaifei on 2021/5/9.
//  Copyright © 2021 SwiftLeaning. All rights reserved.
//

import Foundation

struct ClosuresTest: Runable {
    static func run() {
        print("\n\n=================== Closures ====================")
        
        
        let add: (Int) -> (Int, Int) = getAdd()
        add(5)
        add(10)
        print(MemoryLayout.size(ofValue: add))
    }
    
    static func closureExpressions() {
        
    }
    
    static func getAdd() -> (Int) -> (Int, Int) {
        var num: Int = 10
        var num1: Int = 11
        func add(_ i: Int) -> (Int, Int) {
            num1 += i
            num += i
            return (num, num1)
        }
        num1 = 21
        return add(_:)
    }
//    MemoryLayout.size
//    print()
}


