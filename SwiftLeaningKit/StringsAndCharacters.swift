//
//  StringsAndCharacters.swift
//  SwiftLeaningKit
//
//  Created by performance on 2021/4/26.
//  Copyright © 2021 SwiftLeaning. All rights reserved.
//

import Foundation

//1. 在 Swift 中 String 类型是值类型。如果你创建了一个新的字符串，那么当其进行常量、变量赋值操作，或在函数/方法中传递时，会进行值拷贝
//2. Swift 默认拷贝字符串的行为保证了在函数/方法向你传递的字符串所属权属于你，无论该值来自于哪里。你可以确信传递的字符串不会被修改，除非你自己去修改它。
