//
//  SoleSquareCell.m
//  Solemnness
//
//  Created by 911 on 16/4/29.
//  Copyright © 2016年 bin. All rights reserved.
//

#import "SoleSquareCell.h"

@interface SoleSquareCell ()
@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation SoleSquareCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setImage:(UIImage *)image{
    
    _image = image;
    
    self.imageView.image = image;
    
}

- (void)setTitle:(NSString *)title{
    
    _title = title;
    
    self.label.text = title;
    
    
}

@end
