//
//  SoleFriendViewController.m
//  Solemnness
//
//  Created by 911 on 16/4/24.
//  Copyright © 2016年 bin. All rights reserved.
//

#import "SoleFriendViewController.h"
#import "SoleRecommendViewController.h"
#import "SoleLoginViewController.h"
@interface SoleFriendViewController ()

@end

@implementation SoleFriendViewController



- (void)viewDidLoad {
    [super viewDidLoad];
        self.navigationItem.title = @"我的关注";
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImageName:@"friendsRecommentIcon" selImageName:@"friendsRecommentIcon-click" target:self selector:@selector(leftButtonClick)];
}




- (void)leftButtonClick{
    
    SoleRecommendViewController *recommend = [[SoleRecommendViewController alloc]init];
    
    
    
    [self.navigationController pushViewController:recommend animated:YES];
    self.navigationController.hidesBottomBarWhenPushed = YES;
    
}
- (IBAction)loginOrRegister:(id)sender {
    
    
    
    SoleLoginViewController *loginController = [[SoleLoginViewController alloc]init];
    
    [self presentViewController:loginController animated:YES completion:nil];
    
}



@end
