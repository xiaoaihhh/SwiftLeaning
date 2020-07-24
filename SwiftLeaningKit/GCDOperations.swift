//
//  GCDOperations.swift
//  SwiftLeaning
//
//  Created by fanshuaifei on 2020/7/23.
//  Copyright © 2020 SwiftLeaning. All rights reserved.
//

import Foundation

public struct GCDOperations: Runable, Caculatorable {
    public static func run() {
        //        DispatchQueue.main.async {
        //            print("DispatchQueue.main.async")
        //        }
        //
        //        DispatchQueue.global(qos: .background).async {
        //            print("DispatchQueue.global(qos: .background).async")
        //        }
        //
        //        dispatchPrecondition(condition: DispatchPredicate.onQueue(DispatchQueue.main))
        GCDOperations().cancelTask()
    }
    
    func cancelTask() {
        let workItem = DispatchWorkItem {
            print("DispatchWorkItem excuted")
        }

        DispatchQueue.global().asyncAfter(deadline: .now() + 0.5, execute: workItem)
        DispatchQueue.global().asyncAfter(deadline: .now() + 2, execute: workItem)
        Thread.sleep(forTimeInterval: 1)
        workItem.cancel()
    }
    
    public func add(num1: Int, num2: Int) -> Int {
        return num1 + num2
    }
}


