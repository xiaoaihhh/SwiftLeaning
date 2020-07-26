//
//  SwiftLeaningKit.swift
//  SwiftLeaningKit
//
//  Created by fanshuaifei on 2020/7/24.
//  Copyright © 2020 SwiftLeaning. All rights reserved.
//


public protocol Runable {
    static func run()
}

internal extension Runable {
    private static func run() {
        assert(false, "default run.")
    }
}


protocol Caculatorable {
    func add(num1: Int, num2: Int) -> Int
}

extension Caculatorable {
    func add(num1: Int, num2: Int) -> Int {
        return num1 + num2
    }
}

public class SwiftLeaningKit1 {
    public init() {
        
    }
}
