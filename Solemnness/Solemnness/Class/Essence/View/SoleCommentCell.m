//
//  SoleCommentCell.m
//  Solemnness
//
//  Created by 911 on 16/5/7.
//  Copyright © 2016年 bin. All rights reserved.
//

#import "SoleCommentCell.h"
#import "SoleCommentItem.h"
#import <UIImageView+WebCache.h>


@interface SoleCommentCell ()
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UIImageView *sexImage;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *commentText;
@property (weak, nonatomic) IBOutlet UILabel *dingCount;

@end


@implementation SoleCommentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setItem:(SoleCommentItem *)item{
    [self.icon sd_setImageWithURL:[NSURL URLWithString:item.user.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    if ([item.user.sex isEqualToString:@"m"]) {
        self.sexImage.image = [UIImage imageNamed:@"Profile_manIcon"];
    }else{
        self.sexImage.image = [UIImage imageNamed:@"Profile_womanIcon"];
    }
    self.userName.text = item.user.username;
    self.commentText.text = item.content;
    self.dingCount.text = item.like_count;
    _item = item;
}

@end
