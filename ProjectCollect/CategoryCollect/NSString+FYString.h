//
//  NSString+FYString.h
//  MoGanShan-1.3
//
//  Created by wang yangyang on 14-3-17.
//  Copyright (c) 2014年 wang yangyang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (FYString)

#pragma mark -
#pragma mark 空值 判断
/**
 *    @brief 空值 判断
 *
 **/

+ (BOOL ) stringIsEmpty:(NSString *) aString;

#pragma mark -
#pragma mark 统计字符长度
/**
 *    @brief 统计字符长度
 *
 **/
+ (NSUInteger) unicodeLengthOfString: (NSString *) text;


#pragma mark -
#pragma mark 格式化字符串 为 yyyy-MM-dd 格式
/**
 *    @brief 格式化字符串 为 yyyy-MM-dd 格式
 *
 **/
- (NSString *)formatDayTimeString;

#pragma mark -
#pragma mark 精确到小时 分钟 返回 NSDate

- (NSDate *)formatMainChoiceTimeDate;

#pragma mark -
#pragma mark 格式化字符串 为 yyyy年MM月dd日 格式
/**
 *    @brief 格式化字符串 为 yyyy年MM月dd日 格式
 *
 **/
- (NSString *)formatMiddlePageTimeString;

#pragma mark -
#pragma mark 格式化字符串 为 对比现在时间 格式
/**
 *    @brief 格式化字符串 为 对比现在时间 格式
 *
 **/
- (NSString *)formatCompareTime;


#pragma mark -
#pragma mark 判断是否是手机 号码
/**
 *    @brief 判断是否是手机 号码
 *
 **/
+ (BOOL)isMobileNumber:(NSString *)mobileNum;

#pragma mark -
#pragma mark 编码 转换
/**
 *    @brief 编码 转换
 *
 **/

- (NSString *)URLEncodedString;



#pragma mark - 格式化歌曲的总时间

+ (NSString *)stringFromTimeInterval:(NSTimeInterval)interval;

@end
