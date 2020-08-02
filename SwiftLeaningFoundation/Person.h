//
//  Person.h
//  SwiftLeaningFoundation
//
//  Created by fanshuaifei on 2020/7/31.
//  Copyright © 2020 SwiftLeaning. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Food : NSObject
@property (nonatomic) NSString *name;
@end

@interface Person : NSObject

+ (Person *)person;

- (nullable NSString *)nameNullable;
- (nonnull NSString *)nameNonuull;
- (null_unspecified NSString *)nameNullUnspecified;

- (nullable Food *)foodNullable;
- (nonnull Food *)foodNonuull;
- (null_unspecified Food *)foodNullUnspecified;

- (NSArray *)personHobby;

@end

NS_ASSUME_NONNULL_END
