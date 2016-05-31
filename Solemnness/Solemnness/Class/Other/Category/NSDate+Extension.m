//
//  NSDate+Extension.m
//  Solemnness
//
//  Created by 911 on 16/5/7.
//  Copyright © 2016年 bin. All rights reserved.
//

#import "NSDate+Extension.h"

@implementation NSDate (Extension)

+ (NSDateComponents *)deltaFromDate:(NSDate *)date{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    
    return [calendar components:unit fromDate:date];
}

- (BOOL)isThisYear{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSInteger nowYear = [calendar component:NSCalendarUnitYear fromDate:[NSDate date]];
    NSInteger selfYear = [calendar component:NSCalendarUnitYear fromDate:self];
    
    return nowYear == selfYear;
    
}

- (BOOL)isToday{
    
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    fmt.dateFormat = @"yyyy-MM-dd";
    
    NSString *nowString = [fmt stringFromDate:[NSDate date]];
    NSString *selfString = [fmt stringFromDate:self];
    
    return [nowString isEqualToString: selfString];
}

- (BOOL)isYestoday{
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    fmt.dateFormat = @"yyyy-MM-dd";
    
    NSString *nowString = [fmt stringFromDate:[NSDate date]];
    NSString *selfString = [fmt stringFromDate:self];
    
    NSDate *nowDate = [fmt dateFromString:nowString];
    NSDate *selfDate = [fmt dateFromString:selfString];
    
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:unit fromDate:selfDate toDate:nowDate options:0];
    
    return components.year == 0 && components.month == 0 && components.day == 1;
    
}

@end
