//
//  SoleLoginButton.m
//  Solemnness
//
//  Created by 911 on 16/4/28.
//  Copyright © 2016年 bin. All rights reserved.
//

#import "SoleLoginButton.h"

@implementation SoleLoginButton

- (void)setup{
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self  = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)awakeFromNib{
    [self setup];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.imageView.frame = CGRectMake(0, 0, 70, 70);
    self.titleLabel.x = 0;
    self.titleLabel.y = self.imageView.height;
    self.titleLabel.width = self.imageView.width;
    self.titleLabel.height = self.height - self.imageView.height;
}

@end
