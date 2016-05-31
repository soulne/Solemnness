//
//  SoleRSSCell.m
//  Solemnness
//
//  Created by 911 on 16/4/29.
//  Copyright © 2016年 bin. All rights reserved.
//

#import "SoleRSSCell.h"
#import <UIImageView+WebCache.h>


@interface SoleRSSCell ()
@property (weak, nonatomic) IBOutlet UIImageView *Image;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *detail;

@end

@implementation SoleRSSCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (IBAction)rSSClick:(id)sender {
    
    
}


- (void)setItem:(SoleRSSItem *)item{
    _item = item;
    
    self.title.text = item.theme_name;
    
    if (item.sub_number < 10000) {
        self.detail.text = [NSString stringWithFormat:@"订阅数:%ld",(long)item.sub_number];
    }else{
        self.detail.text = [NSString stringWithFormat:@"订阅数:%.1f万",(float)item.sub_number / 10000];
    }
    
    NSURL *url = [NSURL URLWithString:item.image_list];
    
    [self.Image sd_setImageWithURL:url completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        UIGraphicsBeginImageContext(image.size);
        
        CGContextRef ref = UIGraphicsGetCurrentContext();
        
        UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
        
        [path addClip];
        
        CGContextAddPath(ref, path.CGPath);
        
        [image drawAtPoint:CGPointZero];
        
        self.Image.image = UIGraphicsGetImageFromCurrentImageContext();
        
        UIGraphicsEndImageContext();

    }];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
