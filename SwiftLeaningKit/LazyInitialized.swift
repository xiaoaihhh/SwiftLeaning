//
//  LazyInitialized.swift
//  SwiftLeaning
//
//  Created by fanshuaifei on 2020/7/24.
//  Copyright © 2020 SwiftLeaning. All rights reserved.
//

import Foundation
import UIKit

struct LoadFile {
    init() {
        print("LoadFile object initialized")
    }
}

struct LoadModel {
    init() {
        print("LoadModel object initialized")
    }
}

struct LazyInitializedTest {
    static func test() {
        var test = LazyInitializedTest()
        DispatchQueue.global().async {
            print(test.file)
            print(test.model)
            print(test.button)
            UIView.init().removeFromSuperview()
        }
    }
    let cl = UIView.removeFromSuperview(UIView.init())
    
    lazy var file = LoadFile()
    // self-executing closures
    lazy var model: LoadModel = {
        let model = LoadModel()
        print("model closure")
        return model
    }()
    lazy var button = createButton()
    
    init() {
        print("LazyInitializedTest object initialized")
    }
    
    func createButton() -> UIButton {
        let btn = UIButton(type: .custom)
        btn .setTitle("button", for: .normal)
        return btn
    }
}


