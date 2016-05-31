//
//  SoleTopicVoiceView.m
//  Solemnness
//
//  Created by 911 on 16/5/5.
//  Copyright © 2016年 bin. All rights reserved.
//

#import "SoleTopicVoiceView.h"
#import "SoleTopicItem.h"
#import "SolePictureViewController.h"
#import <UIImageView+WebCache.h>


@interface SoleTopicVoiceView ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *count;
@property (weak, nonatomic) IBOutlet UILabel *time;



@end



@implementation SoleTopicVoiceView




- (void)setItem:(SoleTopicItem *)item{
    _item = item;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:item.large_image]];
    
    self.count.text = [NSString stringWithFormat:@"%zd",item.playcount];
    NSInteger minute = item.voicetime / 60;
    NSInteger second = item.voicetime % 60;
    self.time.text = [NSString stringWithFormat:@"%02zd:%02zd",minute,second];
    
    
}


- (void)awakeFromNib{
    self.autoresizingMask = UIViewAutoresizingNone;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    SolePictureViewController *pictureVC = [[SolePictureViewController alloc]init];
    pictureVC.item = self.item;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:pictureVC animated:YES completion:nil];
}
- (IBAction)musicPlay:(UIButton *)sender {
    
//    NSURL *url = [NSURL URLWithString:self.item.voiceuri];
//    self.player = [[AVAudioPlayer alloc]initWithContentsOfURL:url error:nil];
//    self.player.numberOfLoops = 1;
//    [self.player prepareToPlay];
//    [self.player play];
    
}

@end
