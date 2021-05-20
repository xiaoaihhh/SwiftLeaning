//
//  Person.m
//  SwiftLeaningFoundation
//
//  Created by fanshuaifei on 2020/7/31.
//  Copyright © 2020 SwiftLeaning. All rights reserved.
//

#import "Person.h"

@implementation Food

- (instancetype)init {
    if (self = [super init]) {
        _name = @"defaultName";
        
    }
    return self;
}

@end

@implementation Person

- (instancetype)init {
    if (self = [super init]) {
        if (@available(iOS 10, *)) {
            // 处理高于和等于 iOS10 的系统
        } else {
            // 处理低于 iOS10 的系统
        }
    }
    return self;
}

- (void)modifyAge:(NSInteger *)age {
    if (age != NULL) {
        *age = 10;
    }
}

- (void)someFunction:(NSInteger)age {
    age = 10;
}

+ (Person *)person {
    return nil;
}

- (NSString *)nameNonuull {
    return nil;
}

- (NSString *)nameNullable {
    return nil;
}

- (NSString *)nameNullUnspecified {
    return nil;
}

- (Food *)foodNonuull {
    return nil;
//    return [Food new];
}

- (Food *)foodNullable {
    return nil;
}

- (Food *)foodNullUnspecified {
    return nil;
}

- (NSArray *)personHobby {
    return nil;
}

+ (void)printObjects:(id)firstObj, ... {
    // 需要通过 va_list，va_start，
    // va_arg，va_end 一组宏来访问所有参数
    // 总之太麻烦了，没几个人能记住
}

@end
