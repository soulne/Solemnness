//
//  SoleLoginViewController.m
//  Solemnness
//
//  Created by 911 on 16/4/28.
//  Copyright © 2016年 bin. All rights reserved.
//

#import "SoleLoginViewController.h"

@interface SoleLoginViewController ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leading;

@end

@implementation SoleLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)loginOrRegister:(UIButton *)sender {
    
    if (self.leading.constant == 0) {
        [UIView animateWithDuration:0.25 animations:^{
            
            self.leading.constant = -[UIScreen mainScreen].bounds.size.width;
            [self.view layoutIfNeeded];
        }];
        sender.selected = YES;
        
    }else{
        [UIView animateWithDuration:0.25 animations:^{
            
            self.leading.constant = 0;
            [self.view layoutIfNeeded];
        }];
        sender.selected = NO;
    }
    
}

- (IBAction)close {
    [self.view endEditing:YES];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
}

@end
