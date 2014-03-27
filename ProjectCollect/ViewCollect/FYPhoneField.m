//
//  FYPhoneField.m
//  MoGanShan-1.3
//
//  Created by wang yangyang on 14-3-17.
//  Copyright (c) 2014年 wang yangyang. All rights reserved.
//

#import "FYPhoneField.h"
#import "NSString+FYString.h"

#define NUMBERSVALUE @"0123456789 "

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
    //限制输入的长度，并排除删除文字的情况
    if (textField.text.length >= 13 && ![NSString stringIsEmpty:string]) {
        return NO;
    }
    //限制输入的只能是数字
    if (![NSString stringIsEmpty:string]) {
        NSCharacterSet *cs= [[NSCharacterSet characterSetWithCharactersInString:NUMBERSVALUE] invertedSet];
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        if (![string isEqualToString:filtered]) {
            return NO;
        }
    }
    //如果是在中间输入的
    if (range.location < textField.text.length - 1) {
        NSMutableString *newPhone = [[NSMutableString alloc] initWithString:textField.text];
        //当是删除时候
        if (range.length != 0) {
            [newPhone deleteCharactersInRange:range];
        }
        //当是输入时候
        else {
            [newPhone insertString:string atIndex:range.location];
        }
        newPhone = [[NSMutableString alloc] initWithString:[newPhone stringByReplacingOccurrencesOfString:@" " withString:@""]] ;
        if (newPhone.length > 3) {
            [newPhone insertString:@" " atIndex:3];
        }
        if (newPhone.length > 8) {
            [newPhone insertString:@" " atIndex:8];
        }
        textField.text = newPhone;
        return NO;
    }
    //在尾部输入
    else {
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
    }
    
    
    return YES;
}

- (NSString *)getPhoneNumber
{
    return [self.text stringByReplacingOccurrencesOfString:@" " withString:@""] ;
}

@end
