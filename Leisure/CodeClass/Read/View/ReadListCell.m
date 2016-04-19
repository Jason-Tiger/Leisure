//
//  ReadListCell.m
//  Leisure
//
//  Created by 若愚 on 16/2/12.
//  Copyright © 2016年 xinghu_wang. All rights reserved.
//

#import "ReadListCell.h"

@implementation ReadListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 25, (KScreenWidth - 20 - 20), 30)];
//        self.titleLabel.text = @"题目";
        [self.contentView addSubview:_titleLabel];
        
        self.mainImage = [[UIImageView alloc]initWithFrame:CGRectMake(20, 25 + 30 + 17, (KScreenWidth - 20 - 10 - 20) / 2, 60)];
//        self.mainImage.backgroundColor = [UIColor greenColor];
        [self.contentView addSubview:_mainImage];
        
        self.detailLabel = [[UILabel alloc]initWithFrame:CGRectMake(20 + (KScreenWidth - 20 - 10 - 20) / 2 + 10, 25 + 30 + 17, (KScreenWidth - 20 - 10 - 20) / 2, 60)];
        self.detailLabel.font = [UIFont systemFontOfSize:14];
        self.detailLabel.numberOfLines = 0;
//        self.detailLabel.text = @"换房间卡上的法哈萨克废话废话分化成本代发货我春节看撒谎较好的";
        self.detailLabel.textColor = [UIColor lightGrayColor];
        [self.contentView addSubview:_detailLabel];
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 25 + 30 + 17 + 17 + 60, KScreenWidth, 1)];
        line.backgroundColor = [UIColor grayColor];
        [self.contentView addSubview:line];
    }
    return self;
}

- (void)cellConfigureModel:(ReadListModel *)model
{
    self.titleLabel.text = model.title;
    [self.mainImage sd_setImageWithURL:[NSURL URLWithString:model.coverimg]];
    self.detailLabel.text = model.content;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
