//
//  NSString+FYString.m
//  MoGanShan-1.3
//
//  Created by wang yangyang on 14-3-17.
//  Copyright (c) 2014年 wang yangyang. All rights reserved.
//

#import "NSString+FYString.h"

@implementation NSString (FYString)

#pragma mark -
#pragma mark 空值 判断
/**
 *    @brief 空值 判断
 *
 **/

+ (BOOL ) stringIsEmpty:(NSString *) aString {
    
    if ((NSNull *) aString == [NSNull null])
    {
        return YES;
    }
    if (aString == nil)
    {
        return YES;
    }
    if ([aString isKindOfClass:[NSNumber class]])
    {
        aString = [(NSNumber *)aString stringValue];
    }
    if ([aString length] == 0) {
        return YES;
    } else {
        NSString *newString = nil;
        newString = [aString stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
        if ([newString length] == 0) {
            return YES;
        }
    }
    return NO;
}


#pragma mark -
#pragma mark 统计字符长度
/**
 *    @brief 统计字符长度
 *
 **/
+ (NSUInteger) unicodeLengthOfString: (NSString *) text {
    NSUInteger asciiLength = 0;
    
    if ([NSString stringIsEmpty:text]) {
        return 0;
    }
    for (NSUInteger i = 0; i < text.length; i++) {
        
        
        unichar uc = [text characterAtIndex: i];
        
        asciiLength += isascii(uc) ? 1 : 2;
    }
    
    NSUInteger unicodeLength = asciiLength / 2;
    
    if(asciiLength % 2) {
        unicodeLength++;
    }
    
    return unicodeLength;
}


#pragma mark -
#pragma mark 格式化字符串 为 yyyy-MM-dd 格式
/**
 *    @brief 格式化字符串 为 yyyy-MM-dd 格式
 *
 **/
- (NSString *)formatDayTimeString
{
    if ([NSString stringIsEmpty:self]) {
        return @"";
    }
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"yyyyMMdd"];
    NSDate *dateString = [outputFormatter dateFromString:[self substringToIndex:8]];
    
    [outputFormatter setDateFormat:@"yyyy-MM-dd"];
    return [outputFormatter stringFromDate:dateString];
}

#pragma mark -
#pragma mark 精确到小时 分钟 返回 NSDate

- (NSDate *)formatMainChoiceTimeDate
{
    if ([NSString stringIsEmpty:self]) {
        return [NSDate date];
    }
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"yyyyMMddHHmm"];
    NSDate *dateString = [outputFormatter dateFromString:[self substringToIndex:12]];
    
    return dateString;
}

#pragma mark -
#pragma mark 格式化字符串 为 yyyy年MM月dd日 格式
/**
 *    @brief 格式化字符串 为 yyyy年MM月dd日 格式
 *
 **/
- (NSString *)formatMiddlePageTimeString
{
    if ([NSString stringIsEmpty:self]) {
        return @"";
    }
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"yyyyMMdd"];
    NSDate *dateString = [outputFormatter dateFromString:[self substringToIndex:8]];
    
    [outputFormatter setDateFormat:@"yyyy年MM月dd日"];
    return [outputFormatter stringFromDate:dateString];
}

#pragma mark -
#pragma mark 格式化字符串 为 对比现在时间 格式
/**
 *    @brief 格式化字符串 为 对比现在时间 格式
 *
 **/
- (NSString *)formatCompareTime
{
    if (nil == self) {
        return @"";
    }
    NSString *displayTime = nil;
    
    NSDateFormatter *outputFormatterTime = [[NSDateFormatter alloc] init];
    [outputFormatterTime setDateFormat:@"yyyyMMddHHmmss"];
    NSDate *needFormatDate = [outputFormatterTime dateFromString:self];
    
    /*** 初始化 NSDateFormatter ***/
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh-hans"] ];
    
    /***  判断 刚刚 分钟前  小时前 ***/
    double withNowInterval = fabs([needFormatDate timeIntervalSinceNow]);
    if (withNowInterval < 60) {
        displayTime = @"刚刚";
        return displayTime;
    }else if(withNowInterval/60 <60){
        displayTime = [NSString stringWithFormat:@"%d分钟前",(NSInteger)withNowInterval/60];
        return displayTime;
    }else if(withNowInterval/60/60 < 3){
        displayTime = [NSString stringWithFormat:@"%d小时前",(NSInteger)withNowInterval/60/60];
        return displayTime;
    }
    
    /***  计算今天凌晨的时间 ***/
    NSDate *todayOneTimeDate = nil;
    {
        NSDateFormatter *todayOutputFormatter = [[NSDateFormatter alloc] init];
        [todayOutputFormatter setDateFormat:@"yyyy-MM-dd"];
        NSString *riNum = [todayOutputFormatter stringFromDate:[NSDate date]];
        [todayOutputFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        [todayOutputFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh-hans"]];
        [todayOutputFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
        todayOneTimeDate = [todayOutputFormatter dateFromString:[NSString stringWithFormat:@"%@ 00:00:01",riNum]];
    }
    
    needFormatDate = [NSDate dateWithTimeInterval:60*60*8 sinceDate:needFormatDate];
    
    /***  判断 是否是今天的 ***/
    NSComparisonResult todayResultCom = [needFormatDate compare:todayOneTimeDate];
    if (todayResultCom != NSOrderedAscending) {
        [outputFormatter setDateFormat:@"今天 HH:mm"];
        needFormatDate = [NSDate dateWithTimeInterval:-60*60*8 sinceDate:needFormatDate];
        displayTime = [outputFormatter stringFromDate:needFormatDate];
        return displayTime;
    }
    
    /***  判断 是否是昨天的 ***/
    double yesterdayOneTimeInterVal = fabs([todayOneTimeDate timeIntervalSince1970]- 60*60*24);
    NSDate *yesterdayDate = [NSDate dateWithTimeIntervalSince1970:yesterdayOneTimeInterVal];
    NSComparisonResult yesterdayResultCom = [needFormatDate compare:yesterdayDate];
    if (yesterdayResultCom != NSOrderedAscending) {
        [outputFormatter setDateFormat:@"昨天 HH:mm"];
        needFormatDate = [NSDate dateWithTimeInterval:-60*60*8 sinceDate:needFormatDate];
        displayTime = [outputFormatter stringFromDate:needFormatDate];
        return displayTime;
    }
    
    /***  判断 是否是两天前 ***/
    double twoDayOneTimeInterVal = fabs([todayOneTimeDate timeIntervalSince1970]- 60*60*48);
    NSDate *twoDayDate = [NSDate dateWithTimeIntervalSince1970:twoDayOneTimeInterVal];
    NSComparisonResult twoDayResultCom = [needFormatDate compare:twoDayDate];
    if (twoDayResultCom != NSOrderedAscending) {
        [outputFormatter setDateFormat:@"两天前 HH:mm"];
        needFormatDate = [NSDate dateWithTimeInterval:-60*60*8 sinceDate:needFormatDate];
        displayTime = [outputFormatter stringFromDate:needFormatDate];
        return displayTime;
    }
    
    /***  判断 是否是三天前 ***/
    double threeDayOneTimeInterVal = fabs([todayOneTimeDate timeIntervalSince1970]- 60*60*72);
    NSDate *threeDayDate = [NSDate dateWithTimeIntervalSince1970:threeDayOneTimeInterVal];
    NSComparisonResult threeDayResultCom = [needFormatDate compare:threeDayDate];
    if (threeDayResultCom != NSOrderedAscending) {
        [outputFormatter setDateFormat:@"三天前 HH:mm"];
        needFormatDate = [NSDate dateWithTimeInterval:-60*60*8 sinceDate:needFormatDate];
        displayTime = [outputFormatter stringFromDate:needFormatDate];
        return displayTime;
    }
    
    needFormatDate = [NSDate dateWithTimeInterval:-60*60*8 sinceDate:needFormatDate];
    
    /***  计算今年的时间 ***/
    NSDate *thisYearDate = nil;
    {
        NSDateFormatter *thisYearOutputFormatter = [[NSDateFormatter alloc] init];
        [thisYearOutputFormatter setDateFormat:@"yyyy"];
        NSString *yearDate = [thisYearOutputFormatter stringFromDate:[NSDate date]];
        [thisYearOutputFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        [thisYearOutputFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh-hans"]];
        [thisYearOutputFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
        thisYearDate = [thisYearOutputFormatter dateFromString:[NSString stringWithFormat:@"%@-01-01 00:01:01",yearDate]];
    }
    
    /***  判断 是否是今年的 还是今年以前 ***/
    NSComparisonResult resultCom = [needFormatDate compare:thisYearDate];
    if (resultCom == NSOrderedDescending) {
        [outputFormatter setDateFormat:@"MM-dd HH:mm"];
        displayTime = [outputFormatter stringFromDate:needFormatDate];
    } else {
        [outputFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
        displayTime = [outputFormatter stringFromDate:needFormatDate];
    }
    
    return displayTime;
}

#pragma mark -
#pragma mark 判断是否是手机 号码
/**
 *    @brief 判断是否是手机 号码
 *
 **/
+ (BOOL)isMobileNumber:(NSString *)mobileNum
{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189
     22         */
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

#pragma mark -
#pragma mark 编码 转换
/**
 *    @brief 编码 转换
 *
 **/

- (NSString *)URLEncodedString
{
    NSString *result = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                                             (CFStringRef)self,
                                                                                             NULL,
                                                                                             CFSTR("!*'();:@&=+$,/?%#[]"),
                                                                                             kCFStringEncodingUTF8));
	return result;
}

#pragma mark - 格式化歌曲的总时间

+ (NSString *)stringFromTimeInterval:(NSTimeInterval)interval {
    NSInteger ti = (NSInteger)interval;
    NSInteger seconds = ti % 60;
    NSInteger minutes = (ti / 60) % 60;
    //    NSInteger hours = (ti / 3600);
    //    return [NSString stringWithFormat:@"%02i:%02i:%02i", hours, minutes, seconds];
    return [NSString stringWithFormat:@"%02i:%02i", minutes, seconds];
}

@end
