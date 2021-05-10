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
    int a = 10;
    int b = (a = 20);
    
    
    int c = b;
    
    int d = (a += 2);
    
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

+ (NSString *)imagePath {
    return nil;
}

@end


@implementation Arrow

@end

@interface ImageManager : NSObject

@end

@implementation ImageManager

+ (instancetype)sharedManager {
    static ImageManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
    });
    
    return manager;
}

+ (void)printMessage { }

+ (void)printMessage1 {
    [self printMessage1];
}

- (void)printMessage2 {
    [[self class] printMessage1];
}

+ (instancetype)createInstance {
    return [[self alloc] init];
}

- (void)test { }


@end

@protocol ProtocolA <NSObject>
+ (instancetype)createInstance;
@end



