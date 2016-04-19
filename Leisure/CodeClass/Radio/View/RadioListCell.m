//
//  RadioListCell.m
//  Leisure
//
//  Created by 若愚 on 16/2/21.
//  Copyright © 2016年 xinghu_wang. All rights reserved.
//

#import "RadioListCell.h"

//*coverimg;isnew;*musicUrl;*ting_contentid;*tingid;*title;*musicVisit;

@implementation RadioListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.mainImage = [[UIImageView alloc]initWithFrame:CGRectMake(20, 12, 50, 50)];
        [self.contentView addSubview:_mainImage];
        
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(20 + 50 + 10, 12, KScreenWidth / 5 * 3, 20)];
        self.titleLabel.font = [UIFont systemFontOfSize:14 * Fit];
        [self.contentView addSubview:_titleLabel];
        
        self.listenerImage = [[UIImageView alloc]initWithFrame:CGRectMake(20 + 50 + 10, 12 + 20 + 10, 20, 20)];
        self.listenerImage.image = [UIImage imageNamed:@"listener"];
        [self.contentView addSubview:_listenerImage];
        
        self.listenerNum = [[UILabel alloc]initWithFrame:CGRectMake(20 + 50 + 10 + 20 + 5, 12 + 20 + 10, 100 * Fit, 20)];
        self.listenerNum.font = [UIFont systemFontOfSize:12 * Fit];
        self.listenerNum.textColor = [UIColor lightGrayColor];
        [self.contentView addSubview:_listenerNum];
        
        self.playButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.playButton.frame = CGRectMake(KScreenWidth - 20 - 40, 12 + 5, 40, 40);
        [self.playButton setBackgroundImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];
//        [self.playButton setImage:[UIImage imageNamed:@"u49"] forState:UIControlStateNormal];
        [self.contentView addSubview:_playButton];
        
        self.selectView = [[UIView alloc]initWithFrame:CGRectMake(5, (74 - 10) / 2, 10, 10)];
        self.selectView.backgroundColor = [UIColor clearColor];
        self.selectView.layer.cornerRadius = 5;
        [self.contentView addSubview:_selectView];
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(20, 12 + 50 + 11, KScreenWidth - 20, 1)];
        line.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:line];
    }
    return self;
}

- (void)cellConfigureModel:(RadioListModel *)model
{
    [self.mainImage sd_setImageWithURL:[NSURL URLWithString:model.coverimg]];
    self.titleLabel.text = model.title;
    self.listenerNum.text = model.musicVisit;
//    if (self.isDown) {
//        [self.playButton setBackgroundImage:[UIImage imageNamed:@"downland"] forState:UIControlStateNormal];
//    }
}

+ (CGFloat)heightForCellWithModel:(RadioListModel *)model
{
    return 12 + 50 + 11 + 1;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
