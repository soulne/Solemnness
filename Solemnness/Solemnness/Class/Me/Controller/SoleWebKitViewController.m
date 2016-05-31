//
//  SoleWebKitViewController.m
//  Solemnness
//
//  Created by 911 on 16/4/30.
//  Copyright © 2016年 bin. All rights reserved.
//

#import "SoleWebKitViewController.h"
#import <WebKit/WebKit.h>

@interface SoleWebKitViewController ()
@property (weak, nonatomic) IBOutlet UIProgressView *progress;
@property (weak, nonatomic) IBOutlet UIView *webView;
@property (nonatomic, strong) WKWebView *wkWebView;

@end

@implementation SoleWebKitViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    WKWebView *wkWebView = [[WKWebView alloc]initWithFrame:self.webView.bounds];
    self.wkWebView = wkWebView;
    
    [wkWebView loadRequest:[NSURLRequest requestWithURL:self.url]];
    
    [self.webView addSubview:wkWebView];
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    
}
-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    
    self.wkWebView.frame = self.webView.bounds;
    

    

}

- (IBAction)back:(UIBarButtonItem *)sender {
}

- (IBAction)forward:(UIBarButtonItem *)sender {
}
- (IBAction)refresh:(UIBarButtonItem *)sender {
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
