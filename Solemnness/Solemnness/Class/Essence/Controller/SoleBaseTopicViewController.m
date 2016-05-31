//
//  SoleBaseTopicViewController.m
//  Solemnness
//
//  Created by 911 on 16/5/3.
//  Copyright © 2016年 bin. All rights reserved.
//

#import "SoleBaseTopicViewController.h"
#import "SoleTopicItem.h"
#import "SoleTopicCell.h"
#import "SoleCommentViewController.h"
#import <AFNetworking.h>
#import <MJExtension.h>
#import <MJRefresh.h>
#import <UIImageView+WebCache.h>
#import <SVProgressHUD.h>

@interface SoleBaseTopicViewController ()

@property (nonatomic, strong) NSMutableArray *topicItemArray;
@property (nonatomic, strong) NSString *maxtime;
@property (nonatomic, strong) NSDictionary *parameters;

@end

@implementation SoleBaseTopicViewController

- (NSMutableArray *)topicItemArray{
    if (_topicItemArray == nil) {
        _topicItemArray = [[NSMutableArray alloc] init];
    }
    return _topicItemArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTableView];
    
    [self setupRefresh];
    
    
}


- (void)setupRefresh{
    
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    [self.tableView.header setAutomaticallyChangeAlpha:YES];
    
    [self.tableView.header beginRefreshing];
    
    self.tableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
}

- (void)loadNewData{
    [self.tableView.footer endRefreshing];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = self.dataParameter;
    parameters[@"c"] = @"data";
    parameters[@"type"] = @(self.type);
    self.parameters = parameters;
    [[AFHTTPSessionManager manager] GET:REQUESTURL parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
          [self.tableView.header endRefreshing];
        if (self.parameters != parameters) return ;
        
        self.topicItemArray = [SoleTopicItem objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        self.maxtime = responseObject[@"info"][@"maxtime"];
        [self.tableView reloadData];
      
        
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"加载失败"];
        [self.tableView.header endRefreshing];
    }];
}

- (void)loadMoreData{
    [self.tableView.header endRefreshing];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"list";
    parameters[@"c"] = @"data";
    parameters[@"type"] = @(self.type);
    parameters[@"maxtime"] = self.maxtime;
    self.parameters = parameters;
    [[AFHTTPSessionManager manager] GET:REQUESTURL parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
         [self.tableView.footer endRefreshing];
        if (self.parameters != parameters) return ;
        [self.topicItemArray addObjectsFromArray:[SoleTopicItem objectArrayWithKeyValuesArray:responseObject[@"list"]]];
        self.maxtime = responseObject[@"info"][@"maxtime"];
        [self.tableView reloadData];
       
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"加载失败"];
        [self.tableView.footer endRefreshing];
    }];
}


- (void)setupTableView{
    
    [self.tableView registerNib:[UINib nibWithNibName:@"SoleTopicCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1];
    self.tableView.contentInset =  UIEdgeInsetsMake(88, 0, 49, 0);
    self.tableView.scrollIndicatorInsets = UIEdgeInsetsMake(88, 0, 49, 0);
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.topicItemArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SoleTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    SoleTopicItem *item = self.topicItemArray[indexPath.row];
    
    cell.item = item;
    
    
    return cell;
}


- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //计算
    SoleTopicItem *item = self.topicItemArray[indexPath.row];
    
    return item.cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SoleCommentViewController *comVC = [[SoleCommentViewController alloc]init];
    comVC.topicItem = self.topicItemArray[indexPath.row];
    [self.navigationController pushViewController:comVC animated:YES];
}



@end
