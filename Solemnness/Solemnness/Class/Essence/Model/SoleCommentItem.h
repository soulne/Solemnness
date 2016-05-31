//
//  SoleCommentItem.h
//  Solemnness
//
//  Created by 911 on 16/5/7.
//  Copyright © 2016年 bin. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SoleCmtUserItem.h"

@interface SoleCommentItem : NSObject

//data_id
@property (nonatomic, strong) NSString *ID;
//总评论数
//@property (nonatomic, strong) NSString *total;
//评论的内容
@property (nonatomic, strong) NSString *content;
//评论的创建时间
@property (nonatomic, strong) NSString *ctime;
//评论点赞的人数
@property (nonatomic, strong) NSString *like_count;
//评论音频
@property (nonatomic, strong) NSString *voiceuri;
//音频时长
@property (nonatomic, strong) NSString *voicetime;
//用户模型
@property (nonatomic, strong) SoleCmtUserItem *user;


@end
