//
//  ObjectiveCTest.h
//  SwiftLeaningFoundation
//
//  Created by fanshuaifei on 2020/7/26.
//  Copyright © 2020 SwiftLeaning. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Runable.h"

NS_ASSUME_NONNULL_BEGIN

@interface ObjectiveCTest : NSObject <Runable>

@end

typedef NS_ENUM(NSUInteger, ArrowType) {
    ArrowTypeLeft, ArrowTypeRight, ArrowTypeTop, ArrowTypeBottom
};

@interface Arrow : UIView
@property (nonatomic, assign) ArrowType type;
@end

NS_ASSUME_NONNULL_END
