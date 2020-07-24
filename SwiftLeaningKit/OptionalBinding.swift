//
//  OptionalBinding.swift
//  SwiftLeaning
//
//  Created by fanshuaifei on 2020/7/24.
//  Copyright © 2020 SwiftLeaning. All rights reserved.
//

import Foundation

struct OptionalBinding {
    static func test() {
        
    }
    
    struct IfOptionalBinding {
        
    }
    
    struct GuardOptionalBinding {
        
        func handleNamesWithPrefix(_ prefix: String, names: [String]?) {
            guard prefix.count > 0, let namesArr = names else {
                return
            }
            for name in namesArr {
                guard name.hasPrefix(prefix) else {
                    continue
                }
                // handle name operations
            }
        }
        
        func handleNamesWithPrefixIf(_ prefix: String, names: [String]?) {
            if prefix.count == 0 || names == nil {
                return
            }
            let namesArr = names!
            for name in namesArr {
                guard name.hasPrefix(prefix) else {
                    continue
                }
                // handle name operations
            }
            
//            if prefix.count > 0, let namesArr = names {
//                for name in namesArr {
//                    guard name.hasPrefix(prefix) else {
//                        continue
//                    }
//                    // handle name operations
//                }
//            }
        }
    }
    
    struct SwitchOptionalBinding {
        
        
        
        enum Color {
            case red
            case blue
            case green
        }
        
        func printColor(color: Color) {
            switch color {
            case .red:
                print(Color.red)
            case .blue:
                print(Color.blue)
            case .green:
                print(Color.green)
            }
        }
        
    }
}
