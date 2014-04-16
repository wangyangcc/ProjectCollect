//
//  NSArray+FYLArray.m
//  MoGanShan-1.3
//
//  Created by wang yangyang on 14-4-9.
//  Copyright (c) 2014年 wang yangyang. All rights reserved.
//

#import "NSArray+FYLArray.h"

@implementation NSArray (FYLArray)

#pragma mark - 对数组排序
/**
 *    @brief 对数组排序
 *    @param 用于排序的 key
 *    @param 是否是升序排序
 **/
- (NSArray *)sortedArrayUsingKey:(NSString *)sortKey isAscending:(BOOL)isAscending
{
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:sortKey ascending:isAscending];
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    return [self sortedArrayUsingDescriptors:sortDescriptors];
}

#pragma mark - 根据状态删除没用的数组
/**
 *    @brief 根据状态删除没用的数组
 *    @param 正确的state值
 *
 **/
- (NSMutableArray *)stateCheckUpWithNum:(NSString *)num
{
    NSMutableArray *newAry = [self mutableCopy];
    
    NSEnumerator *enumerator = [newAry objectEnumerator];
    id object;
    while ((object = [enumerator nextObject]) != nil) {
        NSDictionary *oneObj = object;
        if ([oneObj customIntegerForKey:@"STATE"] != [num integerValue]) {
            [newAry removeObject:oneObj];
            enumerator = [newAry objectEnumerator];
        }
    }
    return newAry;
}

#pragma mark - 结果数组的处理
/**
 *    @brief 根据状态删除没用的数组
 *           然后排序
 *
 **/
- (NSMutableArray *)resultArrayDispose:(NSString *)sortKey
{
    NSArray *sortArray = [self sortedArrayUsingKey:sortKey isAscending:YES];
    return [sortArray stateCheckUpWithNum:@"1"];
}

@end
