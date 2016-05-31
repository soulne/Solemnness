//
//  SoleRecommendViewController.m
//  Solemnness
//
//  Created by 911 on 16/4/25.
//  Copyright © 2016年 bin. All rights reserved.
//

#import "SoleRecommendViewController.h"
#import "SoleRecommendTableViewCell.h"
#import "SoleUserCell.h"
#import "SoleCategoryItem.h"
#import "SoleUserItem.h"
#import <AFNetworking.h>
#import <MJExtension.h>
#import <MJRefresh.h>
#import <SVProgressHUD.h>
#import <UIImageView+WebCache.h>



@interface SoleRecommendViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *categoryTable;
@property (weak, nonatomic) IBOutlet UITableView *usersTable;

@property (nonatomic, strong) AFHTTPSessionManager *manager;

@property (nonatomic, strong) NSMutableArray *categoryItemArray;
@property (nonatomic, strong) NSMutableArray *userItemArray;

@property (nonatomic, strong) SoleCategoryItem *currentCategoryItem;

@property (nonatomic, strong) NSDictionary *parameters;

@end

@implementation SoleRecommendViewController

- (NSMutableArray *)categoryItemArray{
    if (_categoryItemArray == nil) {
        _categoryItemArray = [[NSMutableArray alloc] init];
    }
    return _categoryItemArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTableView];

    [self setRefresh];
    
    [self loadCategory];
    
    
    
}

- (void)setRefresh {
    self.usersTable.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewUser)];
    
    
    self.usersTable.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreUser)]; 
}


- (void)setupTableView{
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.usersTable.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.categoryTable.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    [self.categoryTable registerNib:[UINib nibWithNibName:@"SoleRecommendTableViewCell" bundle:nil] forCellReuseIdentifier:@"categoryCell"];
    [self.usersTable registerNib:[UINib nibWithNibName:@"SoleUserCell" bundle:nil] forCellReuseIdentifier:@"userCell"];
    
}

- (void)loadCategory{
    [SVProgressHUD showWithStatus:@"加载紧数据"];
    //网络请求
    self.manager = [AFHTTPSessionManager manager];
    
    NSMutableDictionary * parameters = [NSMutableDictionary dictionary];
    
    parameters[@"a"] = @"category";
    parameters[@"c"] = @"subscribe";
    
    [self.manager GET:REQUESTURL parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        
        NSArray *tempArray = responseObject[@"list"];
        
        self.categoryItemArray = [SoleCategoryItem objectArrayWithKeyValuesArray:tempArray];
        [self.categoryTable reloadData];
        [SVProgressHUD dismiss];
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        [self.categoryTable selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionTop];
        
        [self tableView:self.categoryTable didSelectRowAtIndexPath:indexPath];
        
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        
        [SVProgressHUD showErrorWithStatus:@"网速唔掂吖！"];
    }];
}


- (void)loadNewUser{
    
    SoleCategoryItem *categoryItem = self.categoryItemArray[[self.categoryTable indexPathForSelectedRow].row];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"list";
    parameters[@"c"] = @"subscribe";
    parameters[@"category_id"] = categoryItem.id;
    self.parameters = parameters;
    [self.manager GET:REQUESTURL parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        self.userItemArray = [SoleUserItem objectArrayWithKeyValuesArray:responseObject[@"list"]];
        categoryItem.usersArray = nil;
        [categoryItem.usersArray addObjectsFromArray:self.userItemArray];
        categoryItem.total = [responseObject[@"total"] integerValue];
        categoryItem.page = 1;
        
        if (self.parameters != parameters ) {
            return;
        }
        
//        self.currentCategoryItem = categoryItem;
        [self.usersTable reloadData];
        [self.usersTable.header endRefreshing];
        [self checkFootRefresh];
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"Holy shit烂鬼网速！"];
    }];
    
    
    
}


- (void)loadMoreUser{
    
    SoleCategoryItem *categoryItem = self.categoryItemArray[[self.categoryTable indexPathForSelectedRow].row];
    
    
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    NSInteger page = categoryItem.page;
    parameters[@"a"] = @"list";
    parameters[@"c"] = @"subscribe";
    parameters[@"category_id"] = categoryItem.id;
    parameters[@"page"] = @(page ++) ;
    self.parameters = parameters;
    [self.manager GET:REQUESTURL parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        self.userItemArray = [SoleUserItem objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [categoryItem.usersArray addObjectsFromArray:self.userItemArray];
        categoryItem.total = [responseObject[@"total"] integerValue];
        if (self.parameters != parameters ) {
            return;
        }
        
//            self.currentCategoryItem = categoryItem;
        [self.usersTable reloadData];
        [self checkFootRefresh];
        categoryItem.page ++;
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"Holy shit烂鬼网速！"];
    }];
   
    
}

- (void)checkFootRefresh{
    if (self.currentCategoryItem.usersArray.count != self.currentCategoryItem.total) {
        [self.usersTable.footer endRefreshing];
    }else{
        [self.usersTable.footer endRefreshingWithNoMoreData];
    }
}


#pragma mark tableViewDataSoure

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (tableView == self.categoryTable) {
        return self.categoryItemArray.count;
    }else{
        return self.currentCategoryItem.usersArray.count;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.categoryTable) {
        SoleRecommendTableViewCell *recommendCell = [self.categoryTable dequeueReusableCellWithIdentifier:@"categoryCell"];
    
        SoleCategoryItem *categoryItem = self.categoryItemArray[indexPath.row];
        recommendCell.textLabel.text = categoryItem.name;
        
        return recommendCell;
    }else{
        SoleUserCell *userCell = [self.usersTable dequeueReusableCellWithIdentifier:@"userCell"];

        SoleUserItem *userItem = self.currentCategoryItem.usersArray[indexPath.row];
        userCell.titleLabel.text = userItem.screen_name;
        userCell.detailLabel.text = userItem.fans_count;
        NSURL *imageUrl = [NSURL URLWithString: userItem.header];
        [userCell.iconView sd_setImageWithURL:imageUrl placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
        
        return userCell;
    }
}


#pragma mark tableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == self.categoryTable) {
        self.currentCategoryItem = self.categoryItemArray[self.categoryTable.indexPathForSelectedRow.row];
        [self.usersTable reloadData];
        [self.usersTable.header beginRefreshing];
        [self checkFootRefresh];
       
    }
}


- (void)viewWillDisappear:(BOOL)animated{
    [SVProgressHUD dismiss];
}


@end
