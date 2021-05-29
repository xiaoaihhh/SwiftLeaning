//
//  NestedTypes.swift
//  SwiftLeaningKit
//
//  Created by fanshuaifei on 2020/7/26.
//  Copyright © 2020 SwiftLeaning. All rights reserved.
//

import Foundation
import UIKit





struct NestedTypesTest: Runable {
    static func run() {
        let arrow = Arrow()
        // 外部引用嵌套类型时，在嵌套类型的类型名前加上其外部类型的类型名作为前缀
        arrow.direction = Arrow.Direction.top
        // 也可以根据类型推断省略前面的类型限定
        arrow.direction = .top
    }
}

/// 嵌套类型可以让代码组织变的更清晰（OC中必须全局名称唯一），将相关逻辑组织到一起。要在一个类型中嵌套另一个类型，将嵌套类型的定义写在其外部类型的 { } 内，而且可以根据需要定义多级嵌套。

// 定义一个箭头View
class Arrow: UIView {
    // 箭头有四个方向，这四个方向是个箭头类型本身相关联的，因此作为 Arrow 类型的嵌套类型，可以令逻辑更清晰
    enum Direction {
        case left, right, top, bottom
    }
    
    var direction: Direction = .left
}
