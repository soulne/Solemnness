//
//  UIBarButtonItem+Sole.h
//  Solemnness
//
//  Created by 911 on 16/4/25.
//  Copyright © 2016年 bin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Sole)

+(instancetype)itemWithImageName:(NSString *)imageName selImageName:(NSString *)selImageName target:(NSObject *) target selector:(SEL)selector;

@end
