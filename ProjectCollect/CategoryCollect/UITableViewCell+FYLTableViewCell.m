//
//  UITableViewCell+FYLTableViewCell.m
//  MoGanshan
//
//  Created by wang yangyang on 14-4-14.
//  Copyright (c) 2014年 wang yangyang. All rights reserved.
//

#import "UITableViewCell+FYLTableViewCell.h"
#import <objc/runtime.h>
#import "NSObject+LogDealloc.h"

@implementation UITableViewCell (FYLTableViewCell)

- (void)addBlackView
{
    UIView *viewBlack = objc_getAssociatedObject(self, @"FYLCellViewBlackTag");
    if (viewBlack == nil) {
        viewBlack = [[UIView alloc] init];
        viewBlack.backgroundColor = [UIColor whiteColor];
        CGRect viewBlackFreme = self.bounds;
        viewBlackFreme = self.bounds;
        viewBlackFreme.origin.x += 10.0f;
        viewBlackFreme.origin.y += 10.0f;
        viewBlackFreme.size.width -= 20.0f;
        viewBlackFreme.size.height -= 10.0f;
        viewBlack.frame = viewBlackFreme;
        [self addSubview:viewBlack];
        [self sendSubviewToBack:viewBlack];
        [viewBlack logOnDealloc];
        self.backgroundColor = kDefaultClearColor;
        objc_setAssociatedObject(self, @"FYLCellViewBlackTag", nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }

}

@end
