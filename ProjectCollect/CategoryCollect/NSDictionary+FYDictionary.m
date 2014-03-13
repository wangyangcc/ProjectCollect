//
//  NSDictionary+FYDictionary.m
//  ProjectCollect
//
//  Created by wang yangyang on 14-3-13.
//  Copyright (c) 2014年 wang yangyang. All rights reserved.
//

#import "NSDictionary+FYDictionary.h"

@implementation NSDictionary (FYDictionary)

- (NSInteger)customIntegerForKey:(NSString *)key
{
    NSObject *object = [self objectForKey:key];
    if ([object isKindOfClass:[NSString class]]) {
        return [(NSString *)object integerValue];
    }
    if ([object isKindOfClass:[NSNumber class]]) {
        return [(NSNumber *)object integerValue];
    }
    return 0;
}

- (NSString *)customStringForKey:(NSString *)key
{
    NSObject *object = [self objectForKey:key];
    if ([object isKindOfClass:[NSString class]]) {
        return (NSString *)object;
    }
    if ([object isKindOfClass:[NSNumber class]]) {
        return [(NSNumber *)object stringValue];
    }
    
    return @"";
}

- (NSNumber *)customNumberForKey:(NSString *)key
{
    NSObject *object = [self objectForKey:key];
    if ([object isKindOfClass:[NSString class]]) {
        return [NSNumber numberWithInteger:[(NSString *)object integerValue]];
    }
    if ([object isKindOfClass:[NSNumber class]]) {
        return (NSNumber *)object;
    }
    return [NSNumber numberWithInteger:0];
}

@end
