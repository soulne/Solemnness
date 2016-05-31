//
//  UIBarButtonItem+Sole.m
//  Solemnness
//
//  Created by 911 on 16/4/25.
//  Copyright © 2016年 bin. All rights reserved.
//

#import "UIBarButtonItem+Sole.h"

@implementation UIBarButtonItem (Sole)

+(instancetype)itemWithImageName:(NSString *)imageName selImageName:(NSString *)selImageName target:(NSObject *) target selector:(SEL)selector{
    
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [leftButton setBackgroundImage:[UIImage imageNamed:selImageName] forState:UIControlStateHighlighted];
    [leftButton addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    leftButton.size = leftButton.currentBackgroundImage.size;
    return [[UIBarButtonItem alloc]initWithCustomView:leftButton];

}

@end
