//
//  UITextField+FYTextField.m
//  MoGanShan-1.3
//
//  Created by wang yangyang on 14-3-17.
//  Copyright (c) 2014年 wang yangyang. All rights reserved.
//

#import "UITextField+FYTextField.h"

@implementation UITextField (FYTextField)

- (void)setDefaultPlaceholderColor:(UIColor *)color placeholderString:(NSString *)placeholderString
{
    if ([self respondsToSelector:@selector(setAttributedPlaceholder:)]) {
        self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:placeholderString attributes:@{NSForegroundColorAttributeName: color}];
    } else {
        NSLog(@"Cannot set placeholder text's color, because deployment target is earlier than iOS 6.0");
        [color setValue:color
                 forKeyPath:@"_placeholderLabel.textColor"];
    }
}

@end
