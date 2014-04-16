//
//  UINavigationController+FYNavigationController.m
//  MoGanshan
//
//  Created by wang yangyang on 14-3-27.
//  Copyright (c) 2014年 wang yangyang. All rights reserved.
//

#import "UINavigationController+FYNavigationController.h"

@implementation UINavigationController (FYNavigationController)

#pragma mark - 让当前 viewcontroller 确定 statusbar的样式

- (UIViewController *)childViewControllerForStatusBarStyle {
    return self.visibleViewController;
}

- (UIViewController *)childViewControllerForStatusBarHidden {
    return self.visibleViewController;
}

@end
