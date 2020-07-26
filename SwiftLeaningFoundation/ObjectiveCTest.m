//
//  ObjectiveCTest.m
//  SwiftLeaningFoundation
//
//  Created by fanshuaifei on 2020/7/26.
//  Copyright © 2020 SwiftLeaning. All rights reserved.
//

#import "ObjectiveCTest.h"
#import <objc/runtime.h>


@interface SomeBaseClass: NSObject

@end

@implementation SomeBaseClass

- (void)instanceMethod {
    NSLog(@"this is instanceMethod");
}
+ (void)classMethod{
    NSLog(@"this is classMethod");
}

@end

@implementation ObjectiveCTest

+ (void)run {
    Arrow *arrow = [Arrow new];
    arrow.type = ArrowTypeBottom;
    SomeBaseClass *some = [SomeBaseClass new];
    // 获取类类型
    Class classType = [some class];
    [classType classMethod];
    // 获取元类类型
    Class metaClassType = object_getClass(SomeBaseClass.class); // object_getClass(classType)
    Class metaClassType1 = object_getClass(metaClassType.class);
    BOOL isMeta = class_isMetaClass(metaClassType1);
    NSLog(@"%p, %p", classType, metaClassType);
}

@end


@implementation Arrow

@end
