//
//  Autoclosure.swift
//  SwiftLeaning
//
//  Created by fanshuaifei on 2020/7/23.
//  Copyright © 2020 SwiftLeaning. All rights reserved.
//

import Foundation
import UIKit

struct AutoclosureTest {
    
    static func test() {
        let code = {
            print("AutoclosureTest:code")
        }
        voidReturn(closure: code())
        
        boolReturn(closure: 3 > 1)
        
        let code1 = { () -> Int in
            return 10
        }
        intReturn(closure: code1())
        intReturn(closure: 4)
    }
    
    
    static func voidReturn(closure: @autoclosure () -> Void) {
        closure()
    }
    static func boolReturn(closure: @autoclosure () -> Bool) {
        if closure() {
            print("AutoclosureTest:boolReturn")
        }
    }
    static func intReturn(closure: @autoclosure () -> Int) {
        print("AutoclosureTest: \(closure())")
    }
}


