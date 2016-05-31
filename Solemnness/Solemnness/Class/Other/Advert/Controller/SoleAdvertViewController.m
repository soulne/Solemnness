//
//  SoleAdvertViewController.m
//  Solemnness
//
//  Created by 911 on 16/4/29.
//  Copyright © 2016年 bin. All rights reserved.
//

#import "SoleAdvertViewController.h"
#import "SoleTabBarViewController.h"
#import "SoleAdvertItem.h"
#import <AFNetworking.h>
#import <MJExtension.h>
#import <UIImageView+WebCache.h>

static NSString *url = @"http://mobads.baidu.com/cpro/ui/mads.php?code2=phcqnauGuHYkFMRquANhmgN_IauBThfqmgKsUARhIWdGULPxnz3vndtkQW08nau_I1Y1P1Rhmhwz5Hb8nBuL5HDknWRhTA_qmvqVQhGGUhI_py4MQhF1TvChmgKY5H6hmyPW5RFRHzuET1dGULnhuAN85HchUy7s5HDhIywGujY3P1n3mWb1PvDLnvF-Pyf4mHR4nyRvmWPBmhwBPjcLPyfsPHT3uWm4FMPLpHYkFh7sTA-b5yRzPj6sPvRdFhPdTWYsFMKzuykEmyfqnauGuAu95Rnsnbfknbm1QHnkwW6VPjujnBdKfWD1QHnsnbRsnHwKfYwAwiu9mLfqHbD_H70hTv6qnHn1PauVmynqnjclnj0lnj0lnj0lnj0lnj0hThYqniuVujYkFhkC5HRvnB3dFh7spyfqnW0srj64nBu9TjYsFMub5HDhTZFEujdzTLK_mgPCFMP85Rnsnbfknbm1QHnkwW6VPjujnBdKfWD1QHnsnbRsnHwKfYwAwiuBnHfdnjD4rjnvPWYkFh7sTZu-TWY1QW68nBuWUHYdnHchIAYqPHDzFhqsmyPGIZbqniuYThuYTjd1uAVxnz3vnzu9IjYzFh6qP1RsFMws5y-fpAq8uHT_nBuYmycqnau1IjYkPjRsnHb3n1mvnHDkQWD4niuVmybqniu1uy3qwD-HQDFKHakHHNn_HR7fQ7uDQ7PcHzkHiR3_RYqNQD7jfzkPiRn_wdKHQDP5HikPfRb_fNc_NbwPQDdRHzkDiNchTvwW5HnvPj0zQWndnHRvnBsdPWb4ri3kPW0kPHmhmLnqPH6LP1ndm1-WPyDvnHKBrAw9nju9PHIhmH9WmH6zrjRhTv7_5iu85HDhTvd15HDhTLTqP1RsFh4ETjYYPW0sPzuVuyYqn1mYnjc8nWbvrjTdQjRvrHb4QWDvnjDdPBuk5yRzPj6sPvRdgvPsTBu_my4bTvP9TARqnam";


@interface SoleAdvertViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *ADImageView;
@property (weak, nonatomic) IBOutlet UIButton *jumpBtn;

@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, strong) SoleAdvertItem *item;

@end

@implementation SoleAdvertViewController

static NSInteger count = 3;

- (NSTimer *)timer{
    if (_timer == nil) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(clock) userInfo:nil repeats:YES];
    }
    return _timer;
}

- (void)clock{
    if (count == 0) [self jumb];
    
    [self.jumpBtn setTitle:[NSString stringWithFormat:@"跳过(%ld)",count--] forState:UIControlStateNormal];
}


- (void)getAdvertImage{
    
    [[AFHTTPSessionManager manager] GET:url parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        NSArray *array = responseObject[@"ad"];
        self.item = [SoleAdvertItem objectWithKeyValues:array.lastObject];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.ADImageView sd_setImageWithURL:[NSURL URLWithString:self.item.w_picurl]];
            self.jumpBtn.hidden = NO;
        });
        
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        
    }];
}


- (IBAction)jumb {
    [UIApplication sharedApplication].windows.firstObject.rootViewController = [[SoleTabBarViewController alloc]init];
    
    [self.timer invalidate];
}

- (IBAction)tapImage:(UITapGestureRecognizer *)sender {
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.item.ori_curl]];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self getAdvertImage];
    
    self.timer.fireDate = [NSDate distantPast];
    
}


@end
