//
//  CommunityCell.m
//  Leisure
//
//  Created by 若愚 on 16/2/14.
//  Copyright © 2016年 xinghu_wang. All rights reserved.
//
#import "CommunityCell.h"

@implementation CommunityCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 25, KScreenWidth - 40, 30)];
        self.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:17 * Fit];
        self.titleLabel.numberOfLines = 0;
        self.titleLabel.text = @"没有可以分享秘密的朋友是什么感觉";
        [self.contentView addSubview:_titleLabel];
        
        self.mainImage = [[UIImageView alloc]initWithFrame:CGRectMake(20, 25 + 30 + 20, 60, 60)];
        self.mainImage.backgroundColor = [UIColor cyanColor];
        [self.contentView addSubview:_mainImage];
        
        self.detailLabel = [[UILabel alloc]initWithFrame:CGRectMake(20 + 60 + 10, 25 + 30 + 20, KScreenWidth - 40 - 60 - 10, 60)];
        self.detailLabel.font = [UIFont systemFontOfSize:14 * Fit];
        self.detailLabel.text = @"返回酒店看撒谎发个废话vjhievhjdksbebvbe卡死机读卡机刷卡风格化付金额可费劲啊时空裂缝";
        self.detailLabel.numberOfLines = 0;
        [self.contentView addSubview:_detailLabel];
        
        self.timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 25 + 30 + 20 + 60 + 20, 120, 30)];
        self.timeLabel.textColor = [UIColor grayColor];
        self.timeLabel.text = @"5分钟前";
        self.timeLabel.font = [UIFont systemFontOfSize:14 * Fit];
        [self.contentView addSubview:_timeLabel];
        
        self.commentButton = [UIButton buttonWithType:UIButtonTypeSystem];
        self.commentButton.frame = CGRectMake(KScreenWidth - 20 - 50 - 30, 25 + 30 + 20 + 60 + 20 + 5, 30, 25);
        [self.commentButton setBackgroundImage:[UIImage imageNamed:@"08-chat"] forState:UIControlStateNormal];
        [self.contentView addSubview:_commentButton];
        
        self.commentNumLabel = [[UILabel alloc]initWithFrame:CGRectMake(KScreenWidth - 20 - 50, 25 + 30 + 20 + 60 + 20, 50, 30)];
        self.commentNumLabel.textColor = [UIColor grayColor];
        self.commentNumLabel.text = @"215";
        self.commentNumLabel.textAlignment = 1;
        self.commentNumLabel.font = [UIFont systemFontOfSize:14 * Fit];
        [self.contentView addSubview:_commentNumLabel];
        
        self.line = [[UIView alloc]initWithFrame:CGRectMake(0, 25 + 30 + 20 + 60 + 17 + 30 + 20, KScreenWidth, 1)];
        self.line.backgroundColor = [UIColor grayColor];
        [self.contentView addSubview:_line];
    }
    return self;
}

- (void)cellConfigureModel:(CommunityModel *)model
{
    CGRect bounds = [model.title boundingRectWithSize:CGSizeMake(KScreenWidth - 40, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:17] forKey:NSFontAttributeName] context:nil];
    self.titleLabel.frame = CGRectMake(20, 25, KScreenWidth - 40, bounds.size.height);
    
    self.titleLabel.text = model.title;
    if (model.isrecommend) {
        self.titleLabel.text = [NSString stringWithFormat:@"|🌟| %@", model.title];
    }
    if (model.coverimg.length != 0) {
        self.mainImage.hidden = NO;
        [self.mainImage sd_setImageWithURL:[NSURL URLWithString:model.coverimg]];
        self.mainImage.frame = CGRectMake(20, 25 + bounds.size.height + 20, 60, 60);
        self.detailLabel.frame = CGRectMake(20 + 60 + 10, 25 + bounds.size.height + 20, KScreenWidth - 40 - 60 - 10, 60);
        self.detailLabel.text = model.content;
        self.timeLabel.frame = CGRectMake(20, 25 + bounds.size.height + 20 + 60 + 20, 120, 30);
        self.timeLabel.text = model.addtime_f;
        
        self.commentButton.frame = CGRectMake(KScreenWidth - 20 - 50 - 30, 25 + bounds.size.height + 20 + 60 + 20 + 5, 30, 25);
        self.commentNumLabel.frame = CGRectMake(KScreenWidth - 20 - 50, 25 + bounds.size.height + 20 + 60 + 20, 50, 30);
        self.commentNumLabel.text = [NSString stringWithFormat:@"%ld", model.commentNum];
        self.line.frame = CGRectMake(0, 25 + bounds.size.height + 20 + 60 + 17 + 30 + 20, KScreenWidth, 1);
    }
    else {
        self.mainImage.hidden = YES;
        CGRect bounds1 = [model.content boundingRectWithSize:CGSizeMake(KScreenWidth - 40, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:14 * Fit] forKey:NSFontAttributeName] context:nil];
        self.detailLabel.frame = CGRectMake(20, 25 + bounds.size.height + 20, KScreenWidth - 40, bounds1.size.height);
        self.detailLabel.text = model.content;
        self.timeLabel.frame = CGRectMake(20, 25 + bounds.size.height + 20 + bounds1.size.height + 20, 120, 30);
        self.timeLabel.text = model.addtime_f;
        self.commentButton.frame = CGRectMake(KScreenWidth - 20 - 50 - 30, 25 + bounds.size.height + 20 + bounds1.size.height + 20 + 5, 30, 25);
        self.commentNumLabel.frame = CGRectMake(KScreenWidth - 20 - 50, 25 + bounds.size.height + 20 + bounds1.size.height + 20, 50, 30);
        self.commentNumLabel.text = [NSString stringWithFormat:@"%ld", model.commentNum];
        self.line.frame = CGRectMake(0, 25 + bounds.size.height + 20 + bounds1.size.height + 17 + 30 + 20, KScreenWidth, 1);
    }
    
    
    
}

+ (CGFloat)heightOfRowWithModel:(CommunityModel *)model
{
    if (model.coverimg.length != 0) {
        CGRect bounds = [model.title boundingRectWithSize:CGSizeMake(KScreenWidth - 40, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:17] forKey:NSFontAttributeName] context:nil];
        return 25 + bounds.size.height + 20 + 60 + 20 + 30 + 20 + 1;
    }
    else {
        CGRect bounds = [model.title boundingRectWithSize:CGSizeMake(KScreenWidth - 40, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:17] forKey:NSFontAttributeName] context:nil];
        CGRect bounds1 = [model.content boundingRectWithSize:CGSizeMake(KScreenWidth - 40, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:14 * Fit] forKey:NSFontAttributeName] context:nil];
        return 25 + bounds.size.height + 20 + bounds1.size.height + 20 + 30 + 20 + 1;
    }
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
