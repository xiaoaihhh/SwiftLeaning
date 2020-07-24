//
//  ObjcObject.h
//  SwiftLeaning
//
//  Created by fanshuaifei on 2020/7/22.
//  Copyright © 2020 SwiftLeaning. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

//NS_ASSUME_NONNULL_BEGIN

@interface ObjcViewController : UIViewController
// 明确 nonnull
@property(nonatomic, nonnull)  UIView *view1;
// 明确 nullable
@property(nonatomic, nullable) UIView *view2;
// 明确 null_unspecified 或者不声明
@property(nonatomic, null_unspecified) UIView *view3;

// 明确 nonnull
- (nonnull UIView *)createView1;
// 明确 nullable
- (nullable UIView *)createView2;
// 明确 null_unspecified 或者不声明
- (UIView *)createView3;

@end

//NS_ASSUME_NONNULL_END



