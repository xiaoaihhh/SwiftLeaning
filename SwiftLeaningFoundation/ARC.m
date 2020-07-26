//
//  ARC.m
//  SwiftLeaningFoundation
//
//  Created by fanshuaifei on 2020/7/25.
//  Copyright © 2020 SwiftLeaning. All rights reserved.
//

#import "ARC.h"

@interface Personal ()
@property (nonatomic) NSString *name;
@property (nonatomic) NSObject *obj;
@property (nonatomic) void(^block)(void);

@end

@implementation Personal

- (instancetype)init {
    if (self = [super init]) {
        _name = @"xiaoming";
        __weak typeof(self) weakSelf = self;
        __unsafe_unretained typeof(self) unsafeSelf = self;
        self.block = ^{
            NSString *name = weakSelf.name;
            NSObject *obj = unsafeSelf.obj;
        };
    }
    return self;
}

- (void)dealloc {
    NSLog(@"Personal dealloc");
}

+ (void)run {
    Personal.alloc.init.block();
}

@end
