//
//  FYSystemInfoManage.m
//  ProjectCollect
//
//  Created by wang yangyang on 14-3-13.
//  Copyright (c) 2014年 wang yangyang. All rights reserved.
//

#import "FYSystemInfoManage.h"
#import "NSDictionary+FYDictionary.h"

static FYSystemInfoManage *_sharedInstance = nil;

@implementation FYSystemInfoManage
@synthesize user_Id = _user_Id;

+ (instancetype)sharedInstance {
    
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[self alloc] init];
        
    });
    return _sharedInstance;
}

- (id)init
{
    self = [super init];
    if (self) {
        self.languageName = [self getCurrentLanguageTable];
    }
    return self;
}

- (void)dealloc
{
    self.user_Id = nil;
#if !__has_feature(objc_arc)
    [super dealloc];
#endif
}

#pragma mark - 用户信息 相关

- (NSString *)user_Id
{
    if (_user_Id == nil) {
        _user_Id = [[NSUserDefaults standardUserDefaults] stringForKey:SYSTEM_USER_LOGINID];
    }
    return _user_Id;
}

- (BOOL)isUserLogin:(UIViewController *)currentVC loginVC:(UIViewController *)loginVC
{
    NSString *user_login_sign = [[NSUserDefaults standardUserDefaults] stringForKey:SYSTEM_USER_LOGINID];
    BOOL isLogin = YES;
    if (user_login_sign == nil || [user_login_sign isEqualToString:@"0"]) {
        isLogin = NO;
    }
    if (!isLogin && currentVC && loginVC) {
        [currentVC presentViewController:loginVC animated:YES completion:nil];
    }
    return isLogin;
}

- (void)userLoginOut
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:SYSTEM_USER_LOGINID];
    [[NSUserDefaults standardUserDefaults] synchronize];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *_diskCachePath = [paths[0] stringByAppendingPathComponent:SYSTEM_USER_INFOFILE];
    [[NSFileManager defaultManager] removeItemAtPath:_diskCachePath error:nil];

    self.user_Id = nil;
}

- (void)saveUserDictionary:(NSDictionary *)userDic userIdKey:(NSString *)userIdKey
{
    if (userDic == nil) {
        return;
    }
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *_diskCachePath = [paths[0] stringByAppendingPathComponent:SYSTEM_USER_INFOFILE];
    [userDic writeToFile:_diskCachePath atomically:YES];
    
    [[NSUserDefaults standardUserDefaults] setValue:[userDic customStringForKey:userIdKey] forKey:SYSTEM_USER_LOGINID];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSDictionary *)readUserDictionary
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *_diskCachePath = [paths[0] stringByAppendingPathComponent:SYSTEM_USER_INFOFILE];
    if ([[NSFileManager defaultManager] fileExistsAtPath:_diskCachePath isDirectory:NO]) {
        return [NSDictionary dictionaryWithContentsOfFile:_diskCachePath];
    }
    return [NSDictionary dictionary];
}

#pragma mark - 多语言相关

- (void)setCurrentLanguageTo:(NSString *)language
{
    if ([language isEqualToString:[self getCurrentLanguageTable]])
    {
        return;
    }
    [[NSUserDefaults standardUserDefaults] setValue:language forKey:Current_Language_Table];
    [[NSUserDefaults standardUserDefaults] synchronize];
   // [[NSNotificationCenter defaultCenter] postNotificationName:kLanguage_Changed_Notification object:self];
}

- (NSString *)getCurrentLanguageTable
{
    NSString *languageTableName = [[NSUserDefaults standardUserDefaults] objectForKey:Current_Language_Table];
    if ([NSString stringIsEmpty:languageTableName]) {
        return Language_Chinese;
    }
    return languageTableName;
}


@end
