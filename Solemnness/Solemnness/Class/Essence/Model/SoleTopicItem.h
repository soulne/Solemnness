//
//  SoleTopicItem.h
//  Solemnness
//
//  Created by 911 on 16/5/3.
//  Copyright © 2016年 bin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SoleCommentItem.h"

@interface SoleTopicItem : NSObject
//评论dataID
@property (nonatomic, strong) NSString *ID;
//踩得次数
@property (nonatomic, assign) NSInteger cai;
//顶得次数
@property (nonatomic, assign) NSInteger ding;
//转发次数
@property (nonatomic, assign) NSInteger repost;
//评论
@property (nonatomic, assign) NSInteger comment;
//创建时间
@property (nonatomic, strong) NSString *create_time;
//帖子的类型，1为全部 10为图片 29为段子 31为音频 41为视频
@property (nonatomic, assign) SoleTopicType type;
//头像
@property (nonatomic, strong) NSString *profile_image;
//昵称
@property (nonatomic, strong) NSString *screen_name;
//视频播放次数
@property (nonatomic, assign) NSInteger playcount;
//音乐时长
@property (nonatomic, assign) NSInteger voicetime;
//文字内容
@property (nonatomic, strong) NSString *text;
//图片高度
@property (nonatomic, assign) CGFloat height;
//图片宽度
@property (nonatomic, assign) CGFloat width;
//图片
@property (nonatomic, strong) NSString *large_image;
@property (nonatomic, strong) NSString *small_image;
@property (nonatomic, strong) NSString *middle_image;
//是否新浪会员
@property (nonatomic, assign) BOOL sina_v;
//是否gif
@property (nonatomic, assign) BOOL is_gif;

//视频URL
@property (nonatomic, strong) NSString *videouri;
//音乐URL
@property (nonatomic, strong) NSString *voiceuri;

@property (nonatomic, strong) SoleCommentItem *top_cmt;


#pragma mark - 辅助属性
//cell高度
@property (nonatomic, assign) CGFloat cellHeight;

//图片高度
@property (nonatomic, assign) CGRect pictureF;

@property (nonatomic, assign, getter=isBigPicture) BOOL bigPicture;

@property (nonatomic, assign) CGFloat progress;

//音频高度
@property (nonatomic, assign) CGRect voiceF;
//视频高度
@property (nonatomic, assign) CGRect videoF;
@end
