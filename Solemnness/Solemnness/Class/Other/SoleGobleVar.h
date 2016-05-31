//
//  SoleGobleVar.h
//  Solemnness
//
//  Created by 911 on 16/5/3.
//  Copyright © 2016年 bin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    SoleTopicTypeAll = 1,
    SoleTopicTypePicture = 10,
    SoleTopicTypeWord = 29,
    SoleTopicTypeVoice = 31,
    SoleTopicTypeVideo = 41
} SoleTopicType;

UIKIT_EXTERN CGFloat const SoleCellTextY;

UIKIT_EXTERN CGFloat const cellMargin;

UIKIT_EXTERN CGFloat const SoleCellBottomHeight;


/** 精华-cell-图片帖子的最大高度 */
UIKIT_EXTERN CGFloat const SoleTopicCellPictureMaxH;
/** 精华-cell-图片帖子一旦超过最大高度,就是用Break */
UIKIT_EXTERN CGFloat const SoleTopicCellPictureBreakH;


