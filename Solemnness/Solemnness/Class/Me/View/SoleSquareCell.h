//
//  SoleSquareCell.h
//  Solemnness
//
//  Created by 911 on 16/4/29.
//  Copyright © 2016年 bin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SoleSquareCell : UICollectionViewCell

@property (nonatomic, strong) UIImage *image;


@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (nonatomic, strong) NSString *title;

@end
