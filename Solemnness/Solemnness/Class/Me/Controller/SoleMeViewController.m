//
//  SoleMeViewController.m
//  Solemnness
//
//  Created by 911 on 16/4/24.
//  Copyright © 2016年 bin. All rights reserved.
//

#import "SoleMeViewController.h"
#import "SoleSquareItem.h"
#import "SoleSquareCell.h"
#import "SoleWebKitViewController.h"
#import <AFNetworking.h>
#import <MJExtension.h>
#import <UIImageView+WebCache.h>
#import <WebKit/WebKit.h>


@interface SoleMeViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) NSMutableArray *itemArray;

@property (nonatomic, strong) UICollectionView *squareView;



@end

@implementation SoleMeViewController


static NSInteger col = 4;

- (NSMutableArray *)itemArray{
    if (_itemArray == nil) {
        _itemArray = [[NSMutableArray alloc] init];
    }
    return _itemArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupView];
    
    [self setupFootView];
    
    [self requestData];
}

- (void)requestData{
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    parameters[@"a"] = @"square";
    parameters[@"c"] = @"topic";
    
    [[AFHTTPSessionManager manager] GET:REQUESTURL parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        
        self.itemArray = [SoleSquareItem objectArrayWithKeyValuesArray:responseObject[@"square_list"]];
        
        CGFloat height = ((self.itemArray.count - 1) / col + 1) * ((SCREENWIDTH - (col - 1)) / col + 1);
        self.squareView.frame = CGRectMake(0, 0, SCREENWIDTH, height);
        
        self.tableView.tableFooterView = self.squareView;
        
        [self.squareView reloadData];
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        
    }];
}

- (void)setupFootView{
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    
    flowLayout.itemSize = CGSizeMake((SCREENWIDTH - (col - 1)) / col,(SCREENWIDTH - (col - 1)) / col);
    flowLayout.minimumLineSpacing = 1;
    flowLayout.minimumInteritemSpacing = 1;
    
    CGRect rect = CGRectMake(0, 0, SCREENWIDTH, 100 );
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:rect collectionViewLayout:flowLayout];

    collectionView.backgroundColor = [UIColor grayColor];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.bounces = NO;

    self.squareView = collectionView;
    
    [collectionView registerNib:[UINib nibWithNibName:@"SoleSquareCell" bundle:nil] forCellWithReuseIdentifier:@"squareCell"];
    
    
    
    self.tableView.tableFooterView = collectionView;
}

- (void)setupView{
    self.navigationItem.title = @"我的";
    self.tableView.bounces = NO;
    self.tableView.contentInset = UIEdgeInsetsMake(-20, 0, 0, 0);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - collectionView DateSource

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    SoleSquareCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"squareCell" forIndexPath:indexPath];
    
    SoleSquareItem *item = self.itemArray[indexPath.row];
    NSURL *imageUrl = [NSURL URLWithString:item.icon];
    [cell.imageView sd_setImageWithURL:imageUrl placeholderImage:[UIImage imageNamed:@"mine_icon_nearby"]];
    
    cell.title = item.name;
    
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.itemArray.count;
}

#pragma mark - collectionView Delegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    SoleSquareItem *item = self.itemArray[indexPath.row];
    
    if ([item.url containsString:@"http:"]) {
        
        SoleWebKitViewController *webKitVC = [[SoleWebKitViewController alloc]init];
        
        webKitVC.url = [NSURL URLWithString: item.url];
        [self.navigationController pushViewController:webKitVC animated:YES];
    }
}


@end
