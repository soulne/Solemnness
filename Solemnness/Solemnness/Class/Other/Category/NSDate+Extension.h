//
//  NSDate+Extension.h
//  Solemnness
//
//  Created by 911 on 16/5/7.
//  Copyright © 2016年 bin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Extension)

+ (NSDateComponents *)deltaFromDate:(NSDate *)date;
- (BOOL)isThisYear;
- (BOOL)isToday;
- (BOOL)isYestoday;


@end
