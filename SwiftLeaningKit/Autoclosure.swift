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
        let test = AutoclosureTest()
        let code = {
            DispatchQueue.main.async {
                 print("AutoclosureTest:DispatchQueue.main.async")
            }
            print("AutoclosureTest:code")
        }

        test.voidReturn(closure: code())
        test.boolReturn(closure: 3 > 1)
        
        let code1 = { () -> Int in
            // 复杂的计算
            print("复杂的计算")
            return 10
        }
        test.intReturn(closure: code1())
    }
    
    
    func voidReturn(closure: @autoclosure () -> Void) {
        closure()
    }
    
    func boolReturn(closure: @autoclosure () -> Bool) {
        if closure() {
            print("AutoclosureTest:boolReturn")
        }
    }
    
    func intReturn(closure: @autoclosure () -> Int) {
        print("AutoclosureTest: \(closure())")
    }
}

