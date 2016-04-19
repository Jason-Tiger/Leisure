//
//  RadioCell.m
//  Leisure
//
//  Created by 若愚 on 16/2/14.
//  Copyright © 2016年 xinghu_wang. All rights reserved.
//

#import "RadioCell.h"

@implementation RadioCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.mainImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 8.5, 83, 83)];
        self.mainImage.backgroundColor = [UIColor orangeColor];
        [self.contentView addSubview:_mainImage];
        
        self.typeLabel = [[UILabel alloc]initWithFrame:CGRectMake(10 + 83 + 7, 8.5 + 5, 140 * Fit, 20)];
        self.typeLabel.font = [UIFont systemFontOfSize:15 * Fit];
        self.typeLabel.text = @"每日精选";
        [self.contentView addSubview:_typeLabel];
        
        self.authorLabel = [[UILabel alloc]initWithFrame:CGRectMake(10 + 83 + 7, 8.5 + 5 + 20, 270 * Fit, 20)];
        self.authorLabel.font = [UIFont systemFontOfSize:13 * Fit];
        self.authorLabel.textColor = [UIColor lightGrayColor];
        self.authorLabel.text = @"by: 卡尔西法";
        [self.contentView addSubview:_authorLabel];
        
        self.sourceLabel = [[UILabel alloc]initWithFrame:CGRectMake(10 + 83 + 7, 8.5 + 5 + 20 + 20, 270 * Fit, 20)];
        self.sourceLabel.textColor = [UIColor grayColor];
        self.sourceLabel.text = @"一场西游的修行之路，一个声音的追光者";
        self.sourceLabel.font = [UIFont systemFontOfSize:14 * Fit];
        [self.contentView addSubview:_sourceLabel];
        
        self.listenerImage = [[UIImageView alloc]initWithFrame:CGRectMake((KScreenWidth - (10 + 100 + 5 + 20) * Fit), 8.5 + 5, 20 * Fit, 20 * Fit)];
//        self.listenerImage.backgroundColor = [UIColor orangeColor];
        self.listenerImage.image = [UIImage imageNamed:@"listener"];
        [self.contentView addSubview:_listenerImage];
        
        self.listenerLabel = [[UILabel alloc]initWithFrame:CGRectMake((KScreenWidth - (10 + 100) * Fit), 8.5 + 5, 100 * Fit, 20)];
        self.listenerLabel.text = @"5333333";
        self.listenerLabel.font = [UIFont systemFontOfSize:15 * Fit];
        self.listenerLabel.textColor = [UIColor lightGrayColor];
        [self.contentView addSubview:_listenerLabel];
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(10, 99, KScreenWidth - 10, 1)];
        line.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:line];
    }
    return self;
}

- (void)cellConfigureModel:(RadioModel *)model
{
    [self.mainImage sd_setImageWithURL:[NSURL URLWithString:model.coverimg]];
    self.typeLabel.text = model.title;
    self.authorLabel.text = [NSString stringWithFormat:@"by: %@", model.uname];
    self.sourceLabel.text = model.desc;
    self.listenerLabel.text = [NSString stringWithFormat:@"%ld", model.count];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
