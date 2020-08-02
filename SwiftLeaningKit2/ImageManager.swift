//
//  ImageManager.swift
//  SwiftLeaningKit2
//
//  Created by fanshuaifei on 2020/7/30.
//  Copyright © 2020 SwiftLeaning. All rights reserved.
//

import Foundation

public class ImageManager: NSObject {
    @objc public static let shared = ImageManager()
    @objc public private(set) var url: String?
    override init() {
        
    }
}
