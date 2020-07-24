//
//  NestedNamespacing.swift
//  SwiftLeaning
//
//  Created by fanshuaifei on 2020/7/23.
//  Copyright © 2020 SwiftLeaning. All rights reserved.
//

import Foundation


public struct NestedNamespacing {
    public let uniqueLabel = "uniqueLabel"
    public enum AgeType {
        case young
        case old
    }
    public var ageType = AgeType.young
    public func printNestedNamespacing() {
        print("NestedNamespacing")
    }
}
