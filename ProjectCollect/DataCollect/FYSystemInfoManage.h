//
//  FYSystemInfoManage.h
//  ProjectCollect
//
//  Created by wang yangyang on 14-3-13.
//  Copyright (c) 2014年 wang yangyang. All rights reserved.
//

#import <Foundation/Foundation.h>

#define CustomLocalizedString(key) \
NSLocalizedStringFromTable(key, [[FYSystemInfoManage sharedInstance] languageName],nil)

@interface FYSystemInfoManage : NSObject

@property (copy, nonatomic) NSString *user_Id;

@property (copy, nonatomic) NSString *languageName;

+ (instancetype)sharedInstance;

#pragma mark - 用户信息 相关

- (BOOL)isUserLogin:(UIViewController *)currentVC loginVC:(UIViewController *)loginVC;
- (void)userLoginOut;
- (void)saveUserDictionary:(NSDictionary *)userDic userIdKey:(NSString *)userIdKey;
- (NSDictionary *)readUserDictionary;

#pragma mark - 多语言相关

- (void)setCurrentLanguageTo:(NSString *)language;
- (NSString *)getCurrentLanguageTable;

@end

#pragma mark - 用户信息 相关 常量

#define SYSTEM_USER_LOGINID        @"system_user_loginid"
#define SYSTEM_USER_INFOFILE       @"system_user_infofile"

#pragma mark - 多语言 相关 常量
#define Current_Language_Table  @"LanguageTableName"
#define Language_English  @"LanguageEnglish"
#define Language_Chinese  @"LanguageChinese"
#define kLanguage_Changed_Notification   @"LanguageChangedNotification"
