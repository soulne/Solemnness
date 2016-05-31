//
//  SoleNewViewController.m
//  Solemnness
//
//  Created by 911 on 16/4/24.
//  Copyright © 2016年 bin. All rights reserved.
//

#import "SoleNewViewController.h"

@interface SoleNewViewController ()

@end

@implementation SoleNewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
     self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImageName:@"MainTagSubIcon" selImageName:@"MainTagSubIconClick" target:self selector:@selector(leftButtonClick:)];
    
}


- (void)leftButtonClick:(UIButton *)button{
    
    
    
}


- (NSString *)dataParameter{
    return @"newlist";
}

@end
