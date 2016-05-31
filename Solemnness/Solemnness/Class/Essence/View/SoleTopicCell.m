//
//  SoleTopicCell.m
//  Solemnness
//
//  Created by 911 on 16/5/3.
//  Copyright © 2016年 bin. All rights reserved.
//

#import "SoleTopicCell.h"
#import <UIImageView+WebCache.h>
#import "SoleTopicPictureView.h"
#import "SoleTopicVoiceView.h"
#import "SoleTopicVideoView.h"


@interface SoleTopicCell ()
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UIButton *dingBtn;
@property (weak, nonatomic) IBOutlet UIButton *caiBtn;
@property (weak, nonatomic) IBOutlet UIButton *shareBtn;
@property (weak, nonatomic) IBOutlet UIButton *commentBtn;
@property (weak, nonatomic) IBOutlet UILabel *word;
@property (weak, nonatomic) IBOutlet UIImageView *sina_v;
@property (weak, nonatomic) IBOutlet UIView *hotView;
@property (weak, nonatomic) IBOutlet UILabel *hotViewLabel;

@property (nonatomic, weak) SoleTopicPictureView *pictureView;
@property (nonatomic, weak) SoleTopicVoiceView *voiceView;
@property (nonatomic, weak) SoleTopicVideoView *videoView;


@end

@implementation SoleTopicCell

- (SoleTopicPictureView *)pictureView{
    if (_pictureView == nil) {
        SoleTopicPictureView *imageView = [[[NSBundle mainBundle]loadNibNamed:@"SoleTopicPictureView" owner:nil options:nil]lastObject];
        [self.contentView addSubview:imageView];
        _pictureView = imageView;
    }
    return _pictureView;
}

- (SoleTopicVoiceView *)voiceView{
    if (_voiceView == nil) {
        SoleTopicVoiceView *voiceView = [[[NSBundle mainBundle]loadNibNamed:@"SoleTopicVoiceView" owner:nil options:nil]lastObject];
        [self.contentView addSubview:voiceView];
        _voiceView = voiceView;
    }
    return _voiceView;
}

- (SoleTopicVideoView *)videoView{
    if (_videoView == nil) {
        SoleTopicVideoView *videoView = [[[NSBundle mainBundle]loadNibNamed:@"SoleTopicVideoView" owner:nil options:nil]lastObject];
        
        [self.contentView addSubview:videoView];
        _videoView = videoView;
        
    }
    return _videoView;
}


- (void)setItem:(SoleTopicItem *)item{
    _item = item;
    
    [self.icon sd_setImageWithURL:[NSURL URLWithString:item.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    
    self.name.text = item.screen_name;
    self.time.text = item.create_time;
    
    [self.dingBtn setTitle:[NSString stringWithFormat:@"%zd",item.ding] forState:UIControlStateNormal] ;
    [self.caiBtn setTitle:[NSString stringWithFormat:@"%zd",item.cai] forState:UIControlStateNormal];
    [self.shareBtn setTitle:[NSString stringWithFormat:@"%zd",item.repost] forState:UIControlStateNormal];
    [self.commentBtn setTitle:[NSString stringWithFormat:@"%zd",item.comment] forState:UIControlStateNormal] ;
    self.word.text = item.text;
    
    self.sina_v.hidden = !item.sina_v;
    
    if (item.type == SoleTopicTypePicture) {
        self.pictureView.hidden = NO;
        self.voiceView.hidden = YES;
        self.videoView.hidden = YES;
        self.pictureView.item = item;
        self.pictureView.frame = item.pictureF;
    }else if(item.type == SoleTopicTypeVideo){
        self.pictureView.hidden = YES;
        self.voiceView.hidden = YES;
        self.videoView.hidden = NO;
        self.videoView.item = item;
        self.videoView.frame = item.videoF;
    }else if(item.type == SoleTopicTypeVoice){
        self.voiceView.hidden = NO;
        self.pictureView.hidden = YES;
        self.videoView.hidden = YES;
        self.voiceView.item = item;
        self.voiceView.frame = item.voiceF;
    }else{
        self.voiceView.hidden = YES;
        self.pictureView.hidden = YES;
        self.videoView.hidden = YES;
    }
    
    if (self.item.top_cmt) {
        self.hotView.hidden = NO;
        self.hotViewLabel.text = [NSString stringWithFormat:@"%@: %@",item.top_cmt.user.username,item.top_cmt.content];
    }else{
        self.hotView.hidden = YES;
    }
    
}

- (void)awakeFromNib{
    self.backgroundView =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"mainCellBackground"]];
    self.autoresizingMask = UIViewAutoresizingNone;
}

- (void)setFrame:(CGRect)frame{
    frame.origin.x = cellMargin;
    frame.size.height = self.item.cellHeight - cellMargin;
    frame.size.width = SCREENWIDTH - 2 * cellMargin;
    frame.origin.y += cellMargin;
    [super setFrame:frame];
}



- (IBAction)moreBtnClick:(id)sender {
}

@end
