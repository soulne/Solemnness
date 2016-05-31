//
//  SoleTopicItem.m
//  Solemnness
//
//  Created by 911 on 16/5/3.
//  Copyright © 2016年 bin. All rights reserved.
//

#import "SoleTopicItem.h"
#import "NSDate+Extension.h"

@interface SoleTopicItem ()



@end

@implementation SoleTopicItem

+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{
             @"small_image" : @"image0",
             @"large_image" : @"image1",
             @"middle_image" : @"image2",
             @"top_cmt" : @"top_cmt[0]",
             @"ID" : @"id"
             };
}


- (CGFloat)cellHeight{
    NSMutableDictionary *attribute = [NSMutableDictionary dictionary];
    attribute[NSFontAttributeName] = [UIFont systemFontOfSize:15];
    CGSize maxSize = CGSizeMake(SCREENWIDTH - 4 * cellMargin, MAXFLOAT);
    //文字高度
    CGFloat textHeight = [self.text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil].size.height;
    
    _cellHeight = SoleCellTextY + textHeight + cellMargin;
    
    if (self.type == SoleTopicTypePicture) {
        
        CGFloat pictureW = maxSize.width;
        CGFloat pictureH = pictureW * self.height / self.width;
        if (pictureH > SoleTopicCellPictureMaxH) {
            pictureH = SoleTopicCellPictureBreakH;
            self.bigPicture = YES;
        }
        CGFloat pictureX = cellMargin;
        CGFloat pictureY = SoleCellTextY + textHeight + cellMargin;
        self.pictureF = CGRectMake(pictureX, pictureY, pictureW, pictureH);
        
        _cellHeight += self.pictureF.size.height + cellMargin;
    }else if (self.type == SoleTopicTypeVideo){
        CGFloat videoW = maxSize.width;
        CGFloat videoH = videoW * self.height / self.width;
        CGFloat videoX = cellMargin;
        CGFloat videoY = SoleCellTextY + textHeight + cellMargin;
        
        self.videoF = CGRectMake(videoX, videoY, videoW, videoH);
        _cellHeight += self.videoF.size.height + cellMargin;
        
        
    }else if (self.type == SoleTopicTypeVoice){
        CGFloat voiceW = maxSize.width;
        CGFloat voiceH = voiceW * self.height / self.width;
        CGFloat voiceX = cellMargin;
        CGFloat voiceY = SoleCellTextY + textHeight + cellMargin;
        
        self.voiceF = CGRectMake(voiceX, voiceY, voiceW, voiceH);
         _cellHeight += self.voiceF.size.height + cellMargin;
    }
    
    if (self.top_cmt) {
        NSMutableDictionary *attribute = [NSMutableDictionary dictionary];
        attribute[NSFontAttributeName] = [UIFont systemFontOfSize:13];
        //文字高度
        CGFloat contentHeight = [self.top_cmt.content boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil].size.height;
        
        _cellHeight += 20 + contentHeight + cellMargin;
    }
    
    _cellHeight += cellMargin + SoleCellBottomHeight;
    
    return _cellHeight;
}

//- (NSString *)created_time{
//    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
//    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
//    NSDate *createDate = [fmt dateFromString:_create_time];
//    
//    if (createDate.isToday) {
//        NSDateComponents *components = [NSDate deltaFromDate:createDate];
//        if (components.hour >= 1) {
//            return [NSString stringWithFormat:@"%zd小时前",components.hour];
//        }else if(components.minute >= 1){
//            return [NSString stringWithFormat:@"%zd分钟前",components.minute];
//        }else{
//            return @"刚刚";
//        }
//        
//    }else if (createDate.isYestoday){
//        fmt.dateFormat = @"昨天 HH-mm-ss";
//        return [fmt stringFromDate:createDate];
//        
//    }else if (createDate.isThisYear){
//        fmt.dateFormat = @"MM-dd";
//        return [fmt stringFromDate:createDate];
//        
//    }else{
//        return _create_time;
//    }
//    
//}


- (NSString *)create_time{
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *createDate = [fmt dateFromString:_create_time];
    
    if (createDate.isThisYear) {
        if (createDate.isToday) {
            NSDateComponents *components = [NSDate deltaFromDate:createDate];
            if (components.hour >= 1) {
                return [NSString stringWithFormat:@"%zd小时前",components.hour];
            }else if(components.minute >= 1){
                return [NSString stringWithFormat:@"%zd分钟前",components.minute];
            }else{
                return @"刚刚";
            }
        }else if (createDate.isYestoday){
            fmt.dateFormat = @"昨天 HH:mm:ss";
            return [fmt stringFromDate:createDate];
            
        }else {
            fmt.dateFormat = @"MM-dd HH:mm:ss";
            return [fmt stringFromDate:createDate];
            
        }
    }else{
        return _create_time;
    }
}


@end
