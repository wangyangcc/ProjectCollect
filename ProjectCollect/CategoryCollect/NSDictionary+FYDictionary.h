//
//  NSDictionary+FYDictionary.h
//  ProjectCollect
//
//  Created by wang yangyang on 14-3-13.
//  Copyright (c) 2014年 wang yangyang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (FYDictionary)

- (NSInteger)customIntegerForKey:(NSString *)key;

- (NSString *)customStringForKey:(NSString *)key;

- (NSNumber *)customNumberForKey:(NSString *)key;

- (NSString *)urlEncodedString;
@end
