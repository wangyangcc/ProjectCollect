//
//  FYPhoneField.h
//  MoGanShan-1.3
//
//  Created by wang yangyang on 14-3-17.
//  Copyright (c) 2014年 wang yangyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FYPhoneField : UITextField

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;

- (NSString *)getPhoneNumber;

@end
