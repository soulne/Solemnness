//
//  SoleLoginTextField.m
//  Solemnness
//
//  Created by 911 on 16/4/28.
//  Copyright © 2016年 bin. All rights reserved.
//

#import "SoleLoginTextField.h"
static NSString * const XMGPlacerholderColorKeyPath = @"_placeholderLabel.textColor";


@implementation SoleLoginTextField


- (void)awakeFromNib{
    [self setTintColor:self.textColor];
    
    [self resignFirstResponder];
}

-(BOOL)becomeFirstResponder{
    [self setValue:self.textColor forKeyPath:XMGPlacerholderColorKeyPath];
    return [super becomeFirstResponder];
}

-(BOOL)resignFirstResponder{
    [self setValue:[UIColor grayColor] forKeyPath:XMGPlacerholderColorKeyPath];
    return [super resignFirstResponder];
}



@end
