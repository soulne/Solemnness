//
//  SolePublishView.m
//  Solemnness
//
//  Created by 911 on 16/5/5.
//  Copyright © 2016年 bin. All rights reserved.
//

#import "SolePublishView.h"
#import "SoleVerticallyButton.h"
#import "POP.h"

@implementation SolePublishView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    [self setup];
    
    return self;
}

- (void)setup{
    self.userInteractionEnabled = NO;
    //设置取消按钮
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelBtn setImage:[UIImage imageNamed:@"shareButtonCancel"] forState:UIControlStateNormal];
    [cancelBtn setImage:[UIImage imageNamed:@"shareButtonCancelClick"] forState:UIControlStateHighlighted];
    [cancelBtn sizeToFit];
    [cancelBtn addTarget:self action:@selector(cancelBtnClick) forControlEvents:UIControlEventTouchUpInside];
    cancelBtn.center = CGPointMake(SCREENWIDTH * 0.5, SCREENHEIGHT * 0.9);
    [self addSubview:cancelBtn];
    
    //设置功能按钮
    NSArray *btnImages =  @[@"publish-video", @"publish-picture", @"publish-text", @"publish-audio", @"publish-review", @"publish-offline"];
    NSArray *btnTitles = @[@"发视频", @"发图片", @"发段子", @"发声音", @"审帖", @"离线下载"];
    
    NSInteger maxCol = 3;
    for (int i = 0; i < 6; ++i) {
        SoleVerticallyButton *btn = [[SoleVerticallyButton alloc]init];
         [self addSubview:btn];
        btn.frame = CGRectMake(0, -200, 0, 0);
        [btn setImage:[UIImage imageNamed:btnImages[i]] forState:UIControlStateNormal];
        [btn setTitle:btnTitles[i] forState:UIControlStateNormal];
        [btn setTitleColor: [[UIColor blackColor] colorWithAlphaComponent:0.7] forState:UIControlStateNormal];
        
        btn.size = CGSizeMake(70, 90);
        NSInteger row = i / maxCol;
        NSInteger col = i % maxCol;
        CGFloat btnMargin = (SCREENWIDTH - maxCol * btn.width) / 4;
        
        CGFloat btnX = (btn.width + btnMargin) * col + btnMargin;
        CGFloat btnY = row * (btn.height + btnMargin) + (SCREENHEIGHT - 2 * btn.height) / 2;
        CGFloat btnBeginY = btnY - SCREENHEIGHT;
        
        
        POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
        anim.fromValue = [NSValue valueWithCGRect:CGRectMake(btnX, btnBeginY, btn.width, btn.height)];
        anim.toValue = [NSValue valueWithCGRect:CGRectMake(btnX, btnY, btn.width, btn.height)];
        anim.beginTime = CACurrentMediaTime() + 0.1 * i;
        anim.springBounciness = 10;
        [btn pop_addAnimation:anim forKey:nil];
        
        if (i == 5) {
            [anim setCompletionBlock:^(POPAnimation *anim, BOOL finshed) {
                self.userInteractionEnabled = YES;
            }];
        }
       
    }
    
}

static UIWindow *window_;

+ (void)show{
    
    window_ = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    window_.hidden = NO;
    
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *blurView = [[UIVisualEffectView alloc]initWithEffect:effect];
    blurView.frame = window_.bounds;
    [window_ addSubview:blurView];

    SolePublishView *publishView = [[SolePublishView alloc]init];
    publishView.frame = window_.bounds;
    [window_ addSubview:publishView];
}

- (void)cancelBtnClick{
    
    [self cancelWithBlock:nil];
    
}

- (void)cancelWithBlock:(void (^)())block{
    
    self.userInteractionEnabled = NO;
    
    int beginIndex = 1;
    
    for (int i = beginIndex; i < self.subviews.count; ++i) {
        SoleVerticallyButton *btn = self.subviews[i];
        POPBasicAnimation *anim = [POPBasicAnimation animationWithPropertyNamed:kPOPViewFrame];
        anim.fromValue = [NSValue valueWithCGRect:CGRectMake(btn.x, btn.y, btn.width, btn.height)];
        anim.toValue = [NSValue valueWithCGRect:CGRectMake(btn.x, btn.y + SCREENHEIGHT, btn.width, btn.height)];
        anim.beginTime = CACurrentMediaTime() + 0.1 * (i - 1);
        
        if (i == self.subviews.count - 1) {
            [anim setCompletionBlock:^(POPAnimation *anim, BOOL finshed) {
                window_.hidden =YES;
                window_ = nil;
            }];
            
        }
        [btn pop_addAnimation:anim forKey:nil];
    }
   
}

@end
