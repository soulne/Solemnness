//
//  SoleCategoryItem.h
//  Solemnness
//
//  Created by 911 on 16/4/27.
//  Copyright © 2016年 bin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SoleCategoryItem : NSObject

@property (nonatomic, strong) NSString *id;
@property (nonatomic, assign) NSInteger count;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) NSInteger total;
@property (nonatomic, strong) NSMutableArray *usersArray;
@property (nonatomic, assign) NSInteger page;

@end
