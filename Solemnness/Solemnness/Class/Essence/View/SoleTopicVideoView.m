//
//  SoleTopicVideoView.m
//  Solemnness
//
//  Created by 911 on 16/5/5.
//  Copyright © 2016年 bin. All rights reserved.
//

#import "SoleTopicVideoView.h"
#import "SoleTopicItem.h"
#import "SolePictureViewController.h"
#import <UIImageView+WebCache.h>

@interface SoleTopicVideoView ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *count;

@property (weak, nonatomic) IBOutlet UILabel *time;


@end

@implementation SoleTopicVideoView

- (void)setItem:(SoleTopicItem *)item{
    _item = item;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:item.large_image]];
    self.count.text = [NSString stringWithFormat:@"%zd",item.playcount];
    NSInteger minute = item.voicetime / 60;
    NSInteger second = item.voicetime % 60;
    self.time.text = [NSString stringWithFormat:@"%02zd:%02zd",minute,second];
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
