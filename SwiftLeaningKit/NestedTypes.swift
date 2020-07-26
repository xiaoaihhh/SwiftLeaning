//
//  NestedTypes.swift
//  SwiftLeaningKit
//
//  Created by fanshuaifei on 2020/7/26.
//  Copyright © 2020 SwiftLeaning. All rights reserved.
//

import Foundation
import UIKit

// 嵌套类型可以让代码组织变的更清晰
// OC中必须全局枚举名字和枚举成员是唯一，Swift可通过嵌套类型和Moudle令定义更简洁和清晰
class Arrow: UIView {
    enum Direction {
        case left, right, top, bottom
    }
    
    var direction: Direction = .left
}

struct ArrowTest: Runable {
    static func run() {
        let arrow = Arrow()
        arrow.direction = .top
//        arrow.direction = Arrow.Direction.top
    }
}
