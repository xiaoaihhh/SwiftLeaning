//
//  StructTest.swift
//  SwiftLeaning
//
//  Created by fanshuaifei on 2020/7/21.
//  Copyright © 2020 SwiftLeaning. All rights reserved.
//

import Foundation
import UIKit

//NS_ASSUME_NONNULL_BEGIN

func min<T: Comparable>(x: T, y: T) -> T {
    return y < x ? y : x
}

public class ObjcViewControllerMy : UIViewController {

    // 明确 nonnull
    @objc public var view1: UIView = UIView()

    // 明确 nullable
    @objc public var view2: UIView?

    // nonnull 和 nullable 状态未知
    @objc public var view3: UIView!

    // 明确 nonnull
    @objc public func createView11() -> UIView {
        return UIView()
    }

    // 明确 nullable
    @objc public func createView22() -> UIView? {
        return nil
    }

    // nonnull 和 nullable 状态未知
    public func createView33() -> UIView! {
        return nil
    }
}

struct aAs {
//    UnitDuration
    
}


struct VoidTest {
    func func1(value: () -> ()) {
        value()
    }
    func func2(value: (Void) -> ()) {
        value(())
    }
    
    func func3() { }
    func func4(value: Void) { }
    
    func test() {
        func1(value: func3)
        func2(value: func3)
        func2(value: func4)
    }
    
}

func zipTest() -> Void{
    let arr1 = ["a", "b", "c"]
    let arr2 = ["d", "e", "f"]
    
    for (value1, value2) in zip(arr1, arr2) {
        print(value1, value2)
    }
}




