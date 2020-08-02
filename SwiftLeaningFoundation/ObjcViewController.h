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
@property(nonatomic, nonnull)  UIView *view1;
@property(nonatomic, nullable) UIView *view2;
@property(nonatomic, null_unspecified) UIView *view3;
- (nonnull UIView *)createView1;
- (nullable UIView *)createView2;
- (UIView *)createView3;
@end

//NS_ASSUME_NONNULL_END



