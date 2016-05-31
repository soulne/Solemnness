//
//  SoleTabBar.m
//  Solemnness
//
//  Created by 911 on 16/4/24.
//  Copyright © 2016年 bin. All rights reserved.
//

#import "SoleTabBar.h"
#import "SolePublishView.h"


@interface SoleTabBar ()

@property (nonatomic, strong) UIButton *publishButton;

@end


@implementation SoleTabBar

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    self.publishButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [self.publishButton setImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
    [self.publishButton setImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
    [self addSubview:self.publishButton];
    
    [self.publishButton addTarget:self action:@selector(pubBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    return self;
    
    
}


- (void)pubBtnClick:(UIButton *)btn{
    [SolePublishView show];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.publishButton.width = self.publishButton.currentImage.size.width;
    self.publishButton.height = self.publishButton.currentImage.size.height;
    self.publishButton.center = CGPointMake(self.width * 0.5, self.height * 0.5);
    
    CGFloat y = 0;
    CGFloat width = self.width / 5;
    CGFloat height = self.height;

    int index = 0;
    for (UIButton *button in self.subviews) {
        if (![button isKindOfClass:NSClassFromString(@"UITabBarButton")])continue;
        CGFloat x = width * (index > 1?(index + 1):index);
        button.frame = CGRectMake(x, y, width, height);
        
        index++;
    }
}

@end
