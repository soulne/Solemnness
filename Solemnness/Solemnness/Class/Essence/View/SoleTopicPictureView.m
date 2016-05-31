//
//  SoleTopicPictureView.m
//  Solemnness
//
//  Created by 911 on 16/5/3.
//  Copyright © 2016年 bin. All rights reserved.
//

#import "SoleTopicPictureView.h"
#import <UIImageView+WebCache.h>
#import "SoleProgressView.h"
#import "SolePictureViewController.h"

@interface SoleTopicPictureView ()
@property (weak, nonatomic) IBOutlet UIImageView *gitTip;
@property (weak, nonatomic) IBOutlet UIImageView *imageV;

@property (weak, nonatomic) IBOutlet UIButton *bigPictureBtn;
@property (weak, nonatomic) IBOutlet SoleProgressView *progressView;

@end

@implementation SoleTopicPictureView
- (IBAction)bigPictureBtnClick:(id)sender {
}

- (void)setItem:(SoleTopicItem *)item{
    _item = item;
    self.gitTip.hidden = !item.is_gif;
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:item.large_image] placeholderImage:nil options:SDWebImageAvoidAutoSetImage progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
        item.progress = 1.0 * receivedSize / expectedSize;
        self.progressView.progressLabel.text = [NSString stringWithFormat:@"%0.1f",item.progress];
        [self.progressView setProgress:item.progress animated:NO];
        
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        if (item.isBigPicture) {
            //开启上下文
            UIGraphicsBeginImageContext(self.imageV.size);
            
            //获取图片缩放尺寸
            CGFloat imageW = SCREENWIDTH - 4 * cellMargin;
            CGFloat imageH = item.height * imageW / item.width;
            
            [image drawInRect:CGRectMake(0, 0, imageW, imageH)];
            
            //获取上下文中的图片
            image = UIGraphicsGetImageFromCurrentImageContext();
            //设置图片
            self.imageV.image = image;
            //关闭上下文
            UIGraphicsEndImageContext();
        }else{
            self.imageV.image = image;
        }
        
    }];
    
    
    
    if (item.isBigPicture) { // 大图
        
        self.bigPictureBtn.hidden = NO;
    } else { // 非大图
        self.bigPictureBtn.hidden = YES;
    }
}

-(void)awakeFromNib{
    self.autoresizingMask = UIViewAutoresizingNone;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    SolePictureViewController *pictureVC = [[SolePictureViewController alloc]init];
    pictureVC.item = self.item;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:pictureVC animated:YES completion:nil];
}


@end
