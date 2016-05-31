//
//  SoleRSSViewController.m
//  Solemnness
//
//  Created by 911 on 16/4/29.
//  Copyright © 2016年 bin. All rights reserved.
//

#import "SoleRSSViewController.h"
#import "SoleRSSCell.h"
#import "SoleRSSItem.h"
#import <AFNetworking.h>
#import <MJExtension.h>
#import <SVProgressHUD.h>
@interface SoleRSSViewController ()

@property (nonatomic, strong) NSMutableArray *itemArray;

@end

@implementation SoleRSSViewController

- (NSMutableArray *)itemArray{
    if (_itemArray == nil) {
        _itemArray = [[NSMutableArray alloc] init];
    }
    return _itemArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:@"SoleRSSCell" bundle:nil] forCellReuseIdentifier:@"RSSCell"];
    self.tableView.rowHeight = 60;
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    parameters[@"a"] = @"tag_recommend";
    parameters[@"c"] = @"topic";
    [SVProgressHUD showWithStatus:@"加载紧数据"];
    
    [[AFHTTPSessionManager manager] GET:REQUESTURL parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        self.itemArray = [SoleRSSItem objectArrayWithKeyValuesArray:responseObject];
        [self.tableView reloadData];
        [SVProgressHUD dismiss];
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"加载失败"];
    }];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [SVProgressHUD dismiss];
}

#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.itemArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SoleRSSCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RSSCell"];
    
    cell.item = self.itemArray[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

@end
