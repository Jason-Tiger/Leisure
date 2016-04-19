//
//  ReadCell.m
//  Leisure
//
//  Created by 若愚 on 16/2/12.
//  Copyright © 2016年 xinghu_wang. All rights reserved.
//

#import "ReadCell.h"

@implementation ReadCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame]) {
        self.mainImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, (KScreenWidth - 40) / 3, (KScreenWidth - 40) / 3)];
//        self.mainImage.userInteractionEnabled = YES;
        [self.contentView addSubview:_mainImage];
        
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, (KScreenWidth - 40) / 3 - 20, (KScreenWidth - 40) / 3, 20)];
        self.titleLabel.font = [UIFont systemFontOfSize:14];
        self.titleLabel.textColor = [UIColor whiteColor];
//        self.titleLabel.backgroundColor = [UIColor blackColor];
//        self.titleLabel.text = @"打死发送";
        [self.contentView addSubview:_titleLabel];
    }
    return self;
}

- (void)cellConfigureModel:(ReadModel *)model
{
    [self.mainImage sd_setImageWithURL:[NSURL URLWithString:model.coverimg]];
    self.titleLabel.text = [NSString stringWithFormat:@"%@ %@", model.name, model.enname];
}

@end
