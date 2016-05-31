//
//  SoleRecommendTableViewCell.m
//  Solemnness
//
//  Created by 911 on 16/4/25.
//  Copyright © 2016年 bin. All rights reserved.
//

#import "SoleRecommendTableViewCell.h"

@interface SoleRecommendTableViewCell ()
@property (weak, nonatomic) IBOutlet UIView *indicatorView;

@end


@implementation SoleRecommendTableViewCell



- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    if (self.selected) {
        self.textLabel.textColor = [UIColor redColor];
        self.indicatorView.hidden = NO;
    }else{
        self.textLabel.textColor = [UIColor blackColor];
        self.indicatorView.hidden = YES;
    }
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.textLabel.height -= 1;
}

@end
