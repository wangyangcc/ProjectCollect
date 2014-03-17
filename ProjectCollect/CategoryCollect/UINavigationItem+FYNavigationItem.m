//
//  UINavigationItem+FYNavigationItem.m
//  MoGanShan-1.3
//
//  Created by wang yangyang on 14-3-17.
//  Copyright (c) 2014年 wang yangyang. All rights reserved.
//

#import "UINavigationItem+FYNavigationItem.h"

@implementation UINavigationItem (FYNavigationItem)

- (void)customItemLeftListButton:(ButtonBlock)block
                    norImageName:(NSString *)norImageName
                    selImageName:(NSString *)selImageName
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 47, 44);
    [button setImage:[UIImage imageNamed:norImageName] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:selImageName] forState:UIControlStateHighlighted];
    if (Ios7After)
    {
        [button setImageEdgeInsets:UIEdgeInsetsMake(0, -18, 0, Ios7After ? 5: 23)];
    }
    else
    {
        [button setImageEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 15)];
    }
    [button addAction:block];
    self.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
}

@end
