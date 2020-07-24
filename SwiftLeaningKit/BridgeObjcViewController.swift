//
//  BridgeObjcViewController.swift
//  SwiftLeaning
//
//  Created by fanshuaifei on 2020/7/22.
//  Copyright © 2020 SwiftLeaning. All rights reserved.
//

import UIKit

@objc class BridgeObjcViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let fd = funopen(nil, nil, { [weak self] ctx, data, length in
            
            return length
        }, nil, nil)
    }
    
    @objc func performOperation(op: (Double) -> Double) {
        
    }
    
    @objc(performBinaryOperation:)
    func performOperation(op: (Double, Double) -> Double) {
        
    }
    
    @objc dynamic private var nametitle: String? {
        get {
            return nil
        }
        set {
            
        }
    }
    
    dynamic func tupleTest(p1: (Int, Int)) {
       
    }
    
    
}
