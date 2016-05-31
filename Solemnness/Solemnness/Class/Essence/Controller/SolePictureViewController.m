//
//  SolePictureViewController.m
//  Solemnness
//
//  Created by 911 on 16/5/4.
//  Copyright © 2016年 bin. All rights reserved.
//

#import "SolePictureViewController.h"
#import <UIImageView+WebCache.h>
#import <SVProgressHUD.h>


@interface SolePictureViewController ()<UIScrollViewDelegate>

@property (nonatomic, weak) UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIScrollView *contentView;

@property (nonatomic, assign) CGSize baseImageViewSize;

@end


@implementation SolePictureViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    UIImageView * iv = [[UIImageView alloc] init];
    iv.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:iv];
    self.imageView = iv;
    
   
    CGFloat imageW = SCREENWIDTH;
    CGFloat imageH = self.item.height * imageW / self.item.width;
   
    self.baseImageViewSize = CGSizeMake(imageW, imageH);
    
    self.contentView.delegate = self;
   
    self.imageView.userInteractionEnabled = YES;
    
    if (imageH > SCREENHEIGHT) {
        self.imageView.size = self.baseImageViewSize;
        self.contentView.contentSize = CGSizeMake(0, imageH);
        self.contentView.minimumZoomScale = 1.0;
        self.contentView.maximumZoomScale = self.item.height / imageH;

    }else{
        self.imageView.size = self.baseImageViewSize;
        self.imageView.center = CGPointMake(SCREENWIDTH * 0.5, SCREENHEIGHT * 0.5);
        self.contentView.minimumZoomScale = self.item.height / imageH;
        self.contentView.maximumZoomScale = 1.0;
    }
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:self.item.large_image] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
    }];
    
    
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return self.imageView;
}

- (void)pinch:(UIPinchGestureRecognizer *)pinch{
    
}

- (IBAction)tap:(UITapGestureRecognizer *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)longPress:(UILongPressGestureRecognizer *)sender {

    if (sender.state == UIGestureRecognizerStateBegan) {
        [self presentAlertVC];
    }
   
    
}

- (void)presentAlertVC{
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *saveAction = [UIAlertAction actionWithTitle:@"保存图片" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIImageWriteToSavedPhotosAlbum(self.imageView.image, self, @selector(image: didFinishSavingWithError: contextInfo:), nil);
    }];
    
    UIAlertAction *repostAction = [UIAlertAction actionWithTitle:@"转发" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    UIAlertAction *zanAction = [UIAlertAction actionWithTitle:@"赞" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [alertVC dismissViewControllerAnimated:YES completion:nil];
    }];
    
    [alertVC addAction:saveAction];
    [alertVC addAction:repostAction];
    [alertVC addAction:zanAction];
    [alertVC addAction:cancelAction];
    
    [self presentViewController:alertVC animated:YES completion:nil];
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    
    [SVProgressHUD showSuccessWithStatus:@"保存成功"];
    
}

- (IBAction)moreBtnClick {
    [self presentAlertVC];
}



@end
