//
//  FYSystemInfoManage.h
//  ProjectCollect
//
//  Created by wang yangyang on 14-3-13.
//  Copyright (c) 2014年 wang yangyang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FYSystemInfoManage : NSObject

@property (copy, nonatomic) NSString *user_Id;

+ (instancetype)sharedInstance;

#pragma mark - 用户信息 相关

- (BOOL)isUserLogin:(UIViewController *)currentVC loginVC:(UIViewController *)loginVC;
- (void)userLoginOut;
- (void)saveUserDictionary:(NSDictionary *)userDic userIdKey:(NSString *)userIdKey;
- (NSDictionary *)readUserDictionary;

@end

#pragma mark - 用户信息 相关 常量

#define SYSTEM_USER_LOGINID        @"system_user_loginid"
#define SYSTEM_USER_INFOFILE       @"system_user_infofile"
