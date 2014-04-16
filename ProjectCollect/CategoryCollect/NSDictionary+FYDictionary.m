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

#pragma mark - dic to url

// helper function: get the string form of any object
static NSString *toString(id object) {
    return [NSString stringWithFormat: @"%@", object];
}

// helper function: get the url encoded string form of any object
static NSString *urlEncode(id object) {
    NSString *string = toString(object);
    return [string stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

- (NSString *)urlEncodedString {
    NSMutableArray *parts = [NSMutableArray array];
    for (id key in self) {
        id value = [self objectForKey: key];
        NSString *part = [NSString stringWithFormat: @"%@=%@", urlEncode(key), urlEncode(value)];
        [parts addObject: part];
    }
    return [parts componentsJoinedByString: @"&"];
}

@end
