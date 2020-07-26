//
//  Protocols.swift
//  SwiftLeaningKit
//
//  Created by fanshuaifei on 2020/7/25.
//  Copyright © 2020 SwiftLeaning. All rights reserved.
//

import Foundation


protocol SomeProtocol {
    var mustBeSettable: Int { get set }
    var doesNotNeedToBeSettable: Int { get }
    static func printMessage()
    mutating func setValue(value: Int)
}

protocol RandomNumberGenerator {
    func random() -> Int
}

var obj: (SomeProtocol & RandomNumberGenerator & SomeObject)?
var things: [SomeProtocol] = []



internal struct SomeStruct: SomeProtocol {
    var mustBeSettable: Int = 0
    var doesNotNeedToBeSettable: Int = 1
    static func printMessage() {
        
    }
    mutating func setValue(value: Int) {
        mustBeSettable = value
    }
}

internal class SomeObject: SomeProtocol {
    var mustBeSettable: Int = 1
    var doesNotNeedToBeSettable: Int = 2
    static func printMessage() {
        print("Print Message")
    }
    func setValue(value: Int) {
        
    }
}

internal protocol SomeClassOnlyProtocol: class {
    var name: String { get set }
    
}

class SomeClassOnly: SomeClassOnlyProtocol {
    var name: String = "xiaoming"
}
