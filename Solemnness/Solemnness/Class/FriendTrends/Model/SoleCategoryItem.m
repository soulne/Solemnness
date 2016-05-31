//
//  SoleCategoryItem.m
//  Solemnness
//
//  Created by 911 on 16/4/27.
//  Copyright © 2016年 bin. All rights reserved.
//

#import "SoleCategoryItem.h"

@implementation SoleCategoryItem

- (NSMutableArray *)usersArray{
    if (_usersArray == nil) {
        _usersArray = [[NSMutableArray alloc] init];
    }
    return _usersArray;
}


@end
