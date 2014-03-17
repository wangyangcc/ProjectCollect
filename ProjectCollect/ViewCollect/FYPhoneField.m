//
//  FYPhoneField.m
//  MoGanShan-1.3
//
//  Created by wang yangyang on 14-3-17.
//  Copyright (c) 2014年 wang yangyang. All rights reserved.
//

#import "FYPhoneField.h"

#define NUMBERSVALUE @"0123456789 \n"

@implementation FYPhoneField

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (range.location == 3 || range.location == 8) {
        if (range.length != 0) {
            //当是删除时候，去掉两边空格
            textField.text = [textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        }
        else {
            //当是输入时候，添加空格
            textField.text = [textField.text stringByAppendingString:@" "];
        }
    }
    //限制输入的长度
    if (range.location == 13) {
        return NO;
    }
    //限制输入的只能是文字
    if (string) {
        NSCharacterSet *cs= [[NSCharacterSet characterSetWithCharactersInString:NUMBERSVALUE] invertedSet];
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        return [string isEqualToString:filtered];
    }
    return YES;
}

- (NSString *)getPhoneNumber
{
    NSCharacterSet *whitespace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    return [self.text stringByTrimmingCharactersInSet:whitespace];
}

@end
