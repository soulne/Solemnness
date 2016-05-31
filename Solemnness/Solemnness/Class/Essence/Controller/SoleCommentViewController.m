//
//  SoleCommentViewController.m
//  Solemnness
//
//  Created by 911 on 16/5/7.
//  Copyright © 2016年 bin. All rights reserved.
//

#import "SoleCommentViewController.h"
#import "SoleCommentCell.h"
#import "SoleCommentItem.h"
#import "SoleCmtUserItem.h"
#import "SoleTopicCell.h"
#import <MJRefresh.h>
#import <MJExtension.h>
#import <AFNetworking.h>
#import "SVProgressHUD.h"



@interface SoleCommentViewController ()

@property (nonatomic, strong) NSMutableArray *commentArray;
@property (nonatomic, strong) NSMutableArray *hotArray;

@property (nonatomic, strong) SoleCommentItem *save_item;
@property (nonatomic, strong) AFHTTPSessionManager *manager;

@property (nonatomic, assign) NSInteger page;

@end

@implementation SoleCommentViewController

- (AFHTTPSessionManager *)manager{
    if (_manager == nil) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}


- (void)viewDidLoad {
    [super viewDidLoad];
 
    [self setupTableView];
    
    [self setupHeaderView];
    
    
}

- (void)viewDidDisappear:(BOOL)animated{
    self.topicItem.top_cmt = self.save_item;
    [self.topicItem setValue:@0 forKeyPath:@"cellHeight"];
}

- (void)setupTableView{
    
    [self.tableView registerNib:[UINib nibWithNibName:@"SoleCommentCell" bundle:nil] forCellReuseIdentifier:@"commentCell"];
    
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    self.tableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    self.tableView.estimatedRowHeight = 44;
    self.tableView.translatesAutoresizingMaskIntoConstraints = YES;
}


- (void)setupHeaderView{

    UIView *headerView = [[UIView alloc]init];
    
    //设置头部视图
    SoleTopicCell *cell = [[[NSBundle mainBundle]loadNibNamed:@"SoleTopicCell" owner:nil options:nil]lastObject];
    
    if (self.topicItem.top_cmt) {
        self.save_item = self.topicItem.top_cmt;
        self.topicItem.top_cmt = nil;
        [self.topicItem setValue:@0 forKeyPath:@"cellHeight"];
    }
    cell.item = self.topicItem;
    cell.size = CGSizeMake(SCREENWIDTH, self.topicItem.cellHeight) ;
    [headerView addSubview:cell];
    headerView.height = cell.height + cellMargin;
    
    self.tableView.tableHeaderView = headerView;
    
    [self.tableView.header beginRefreshing];
}


- (void)loadNewData{
    
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"dataList";
    parameters[@"c"] = @"comment";
    parameters[@"data_id"] = self.topicItem.ID;
    parameters[@"hot"] = @"1";
    
    [self.manager GET:REQUESTURL parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        
        [responseObject writeToFile:@"/Users/yang/Desktop/responseObject.plist" atomically:YES];
        
        self.commentArray = [SoleCommentItem objectArrayWithKeyValuesArray:responseObject[@"data"]];
        self.hotArray = [SoleCommentItem objectArrayWithKeyValuesArray:responseObject[@"hot"]];
        [self.tableView reloadData];
        
        [self.tableView.header endRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        
        [self.tableView.header endRefreshing];
    }];
    
}

- (void)loadMoreData{
    
    NSInteger page = self.page + 1;
    
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    SoleCommentItem *lastItem = self.commentArray.lastObject;
    parameters[@"a"] = @"dataList";
    parameters[@"c"] = @"comment";
    parameters[@"data_id"] = self.topicItem.ID;
    parameters[@"lastcid"] = lastItem.ID;
    parameters[@"page"] = @(page);
    
    [self.manager GET:REQUESTURL parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        
        if ([responseObject count] != 0) {
            NSArray *newComment = [SoleCommentItem objectArrayWithKeyValuesArray:responseObject[@"data"]];
            
            [self.commentArray addObjectsFromArray:newComment];
            
            [self.tableView reloadData];
            
            self.page++;
        }
        
        [self.tableView.footer endRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        
        [self.tableView.footer endRefreshing];
    }];
    
}

#pragma mark - tableview 代理



#pragma mark - tableview 数据源
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (self.hotArray.count)return 2;
    return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (self.hotArray.count && section == 0) {
        return @"最热评论";
    }else{
        return @"最新评论";
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
     SoleCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"commentCell"];
    
    if (self.hotArray.count && indexPath.section == 0) {
        cell.item = self.hotArray[indexPath.row];
    }else{
        cell.item = self.commentArray[indexPath.row];
    }
     return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (self.hotArray.count && section == 0) {
        return self.hotArray.count;
    }else{
        return self.commentArray.count;
    }
    
    
}




@end
