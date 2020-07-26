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


class vv: A {
    
}


