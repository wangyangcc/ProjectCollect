//
//  UINavigationItem+FYNavigationItem.h
//  MoGanShan-1.3
//
//  Created by wang yangyang on 14-3-17.
//  Copyright (c) 2014年 wang yangyang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIButton+Block.h"

@interface UINavigationItem (FYNavigationItem)

//侧边栏按钮
- (void)customItemLeftListButton:(ButtonBlock)block
                    norImageName:(NSString *)norImageName
                    selImageName:(NSString *)selImageName;

@end
