//
//  GoodProductCell.m
//  Leisure
//
//  Created by 若愚 on 16/2/11.
//  Copyright © 2016年 xinghu_wang. All rights reserved.
//

#import "GoodProductCell.h"

@implementation GoodProductCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.mainImageView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 20, KScreenWidth - 40, (KScreenWidth - 40) * 300 / 608)];
//        self.mainImageView.backgroundColor = [UIColor orangeColor];
        [self.contentView addSubview:_mainImageView];
        
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 20 + (KScreenWidth - 40) * 300 / 608 + 20, KScreenWidth - 80 - 20 - 20, 40)];
//        self.titleLabel.backgroundColor = [UIColor orangeColor];
        [self.contentView addSubview:_titleLabel];
        
        self.buyButton = [UIButton buttonWithType:UIButtonTypeSystem];
        self.buyButton.frame = CGRectMake(KScreenWidth - 80, _titleLabel.frame.origin.y + 10, 60, 20);
//        self.buyButton.backgroundColor = [UIColor orangeColor];
        [self.contentView addSubview:_buyButton];
        
        self.line = [[UIView alloc]initWithFrame:CGRectMake(0, 20 + (KScreenWidth - 40) * 300 / 608 + 20 + 60 - 1, KScreenWidth, 1)];
        self.line.backgroundColor = [UIColor grayColor];
        [self.contentView addSubview:_line];
    }
    return self;
}

- (void)cellConfigureModel:(GoodProductModel *)model
{
    [self.mainImageView sd_setImageWithURL:[NSURL URLWithString:model.coverimg]];
    self.titleLabel.text = model.title;
    [self.buyButton setTitle:@"立刻购买" forState:UIControlStateNormal];
    [self.buyButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.buyButton.titleLabel.font = [UIFont systemFontOfSize:12];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
