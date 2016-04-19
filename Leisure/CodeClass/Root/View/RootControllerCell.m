//
//  RootControllerCell.m
//  Leisure
//
//  Created by 若愚 on 16/2/10.
//  Copyright © 2016年 xinghu_wang. All rights reserved.
//


#import "RootControllerCell.h"

@implementation RootControllerCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.typeImage = [[UIImageView alloc]initWithFrame:CGRectMake(20, 20, 30, 30)];
        self.typeImage.layer.masksToBounds = YES;
        self.typeImage.layer.cornerRadius = 8;
        [self.contentView addSubview:_typeImage];
        
        self.typeLabel = [[UILabel alloc]initWithFrame:CGRectMake(60, 20, 100, 30)];
        [self.contentView addSubview:_typeLabel];
        
        self.line = [[UIView alloc]initWithFrame:CGRectMake(0, 69, KScreenWidth - 100, 1)];
        self.line.backgroundColor = [UIColor grayColor];
        [self.contentView addSubview:_line];
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
