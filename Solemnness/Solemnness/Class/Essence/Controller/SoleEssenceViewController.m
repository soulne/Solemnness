//
//  SoleEssenceViewController.m
//  Solemnness
//
//  Created by 911 on 16/4/24.
//  Copyright © 2016年 bin. All rights reserved.
//

#import "SoleEssenceViewController.h"
#import "SoleRSSViewController.h"
#import "SoleBaseTopicViewController.h"

@interface SoleEssenceViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, weak) UIView *indicator;

@property (nonatomic, weak) UIButton *selButton;

@property (nonatomic, weak) UICollectionView *contentView;

@property (nonatomic, weak) UIView *titleView;
@end

@implementation SoleEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNav];
    
    [self setAllChildView];
    
    [self setupContentView];
    
    [self setupTitleView];
    
}


- (NSString *)dataParameter{
    return @"list";
}


- (void)setupTitleView{
    
    UIView *titleView = [[UIView alloc]init];
    titleView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.7];
    CGRect titleFrame = CGRectMake(0, 0, SCREENWIDTH, 44);
    if (!self.navigationController.navigationBar.hidden)titleFrame.origin.y = 64;
    titleView.frame = titleFrame;
    [self.view addSubview:titleView];
    
    UIView *indicator = [[UIView alloc]init];
    indicator.backgroundColor = [UIColor redColor];
    indicator.height = 2;
    indicator.y = titleView.height - indicator.height;
    self.indicator = indicator;
   
    
    
    NSInteger index = 0;
    for (UIViewController *vc in self.childViewControllers) {
        UIButton *button = [[UIButton alloc]init];
        [button setTitle:vc.title forState:UIControlStateNormal];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateDisabled];
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        CGFloat btnW = titleView.width / self.childViewControllers.count;
        CGFloat btnH = titleView.height;
        CGFloat btnY = 0;
        CGFloat btnX = index * btnW;
        button.frame = CGRectMake(btnX, btnY, btnW, btnH);
        button.tag = index;
        [button addTarget:self action:@selector(titleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [titleView addSubview:button];
        
        if (index == 0) {
            button.enabled = NO;
            self.selButton = button;
            
           indicator.width = [vc.title sizeWithAttributes:@{
                                          NSFontAttributeName:[UIFont systemFontOfSize:15]
                                          }].width;
            
            indicator.centerX = button.centerX;
            [self.view layoutIfNeeded];
        }
        
        index ++;
    }
    
    [titleView addSubview:indicator];
    self.titleView = titleView;
}


- (void)setAllChildView{
    SoleBaseTopicViewController *all = [[SoleBaseTopicViewController alloc]init];
    all.title = @"全部";
    all.dataParameter = self.dataParameter;
    all.type = SoleTopicTypeAll;
    [self addChildViewController:all];
    
    SoleBaseTopicViewController *picture = [[SoleBaseTopicViewController alloc]init];
    picture.type = SoleTopicTypePicture;
    picture.title = @"图片";
    picture.dataParameter = self.dataParameter;
    [self addChildViewController:picture];
    
    SoleBaseTopicViewController *voice = [[SoleBaseTopicViewController alloc]init];
    voice.title = @"声音";
    voice.dataParameter = self.dataParameter;
    voice.type = SoleTopicTypeVoice;
    [self addChildViewController:voice];
    
    SoleBaseTopicViewController *video = [[SoleBaseTopicViewController alloc]init];
    video.title = @"视频";
    video.dataParameter = self.dataParameter;
    video.type = SoleTopicTypeVideo;
    [self addChildViewController:video];
    
    SoleBaseTopicViewController *word = [[SoleBaseTopicViewController alloc]init];
    word.title = @"段子";
    word.dataParameter = self.dataParameter;
    word.type = SoleTopicTypeWord;
    [self addChildViewController:word];
}

- (void)setupContentView{
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    
    layout.itemSize = CGSizeMake(SCREENWIDTH, SCREENHEIGHT);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    
    UICollectionView *contentView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
    
    contentView.delegate = self;
    contentView.dataSource = self;
    contentView.pagingEnabled = YES;
    contentView.backgroundColor = [UIColor greenColor];
    
    [contentView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"collectionCell"];
    [self.view addSubview:contentView];
    self.contentView = contentView;
    self.automaticallyAdjustsScrollViewInsets = NO;
}


- (void)setupNav{
    [self.navigationItem setTitleView:[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"MainTitle"]]];
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImageName:@"MainTagSubIcon" selImageName:@"MainTagSubIconClick" target:self selector:@selector(leftButtonClick:)];
}




- (void)leftButtonClick:(UIButton *)button{
    
    SoleRSSViewController *RSSVC = [[SoleRSSViewController alloc]init];
    
    [self.navigationController pushViewController:RSSVC animated:YES];
    
}


- (void)titleBtnClick:(UIButton *)btn{
    
    self.selButton.enabled = YES;
    
    [UIView animateWithDuration:0.25 animations:^{
        self.indicator.centerX = btn.centerX;
        self.indicator.width = btn.titleLabel.width;
        
    }];
    
    self.contentView.contentOffset = CGPointMake(btn.tag * self.contentView.width, 0);
    
    btn.enabled = NO;
    self.selButton = btn;
}


#pragma mark - collectionView delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    
    
    
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    NSInteger index = scrollView.contentOffset.x / SCREENWIDTH;
    
    [self titleBtnClick:self.titleView.subviews[index]];
    
}

#pragma mark - collectionView dataSoure

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.childViewControllers.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collectionCell" forIndexPath:indexPath];
    [cell addSubview:self.childViewControllers[indexPath.row].view];
    return cell;
}


@end
