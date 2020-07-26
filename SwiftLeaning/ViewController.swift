//
//  ViewController.swift
//  SwiftLeaning
//
//  Created by fanshuaifei on 2020/7/21.
//  Copyright © 2020 SwiftLeaning. All rights reserved.
//

import UIKit
import SwiftLeaningKit


class ViewController: UIViewController {
    var name: UIView = UIView()
    
    override func viewDidLoad() {
        self.navigationController?.navigationBar.barStyle
        super.viewDidLoad()
//        AutoclosureTest.test()
//        LazyInitializedTest.test()
        
//        GCDOperations.run()
//        SwiftLeaningKit1()
//        Nested1.name
//        ARCTest.run()
//        Personal.run()
//        ExtensionsTest.run()
        TypeCastingTest.run()
        ObjectiveCTest.run()
    }
}


