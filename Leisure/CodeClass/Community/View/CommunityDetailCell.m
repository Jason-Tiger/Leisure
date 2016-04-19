//
//  CommunityDetailCell.m
//  Leisure
//
//  Created by 若愚 on 16/2/19.
//  Copyright © 2016年 xinghu_wang. All rights reserved.
//
#import "CommunityDetailCell.h"

@implementation CommunityDetailCell

//titleLabel; lz_Image; lz_nameButton; lz_idenLabel; lz_timeLabel; lz_web; functionView; onlyLzButton; sortButton; hotButton; headImage; nameButton; timeLabel; detailLabel;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
            self.headImage = [[UIImageView alloc]initWithFrame:CGRectMake(20, 15, 60, 60)];
            [self.contentView addSubview:_headImage];
            
            self.nameButton = [UIButton buttonWithType:UIButtonTypeSystem];
            [self.nameButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            self.nameButton.frame = CGRectMake(20 + 60 + 10, 15, 100, 30);
            self.nameButton.titleLabel.textAlignment = NSTextAlignmentLeft;
            [self.contentView addSubview:_nameButton];
            
            self.timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(20 + 60 + 10, 15 + 30 + 5, 100, 20)];
            self.timeLabel.textColor = [UIColor lightGrayColor];
            self.timeLabel.font = [UIFont systemFontOfSize:12 * Fit];
            [self.contentView addSubview:_timeLabel];
            
            self.goodLabel = [[UILabel alloc]initWithFrame:CGRectMake(KScreenWidth - 20 - 50, 20, 50, 20)];
            self.goodLabel.textColor = [UIColor grayColor];
            self.goodLabel.font = [UIFont systemFontOfSize:12 * Fit];
            [self.contentView addSubview:_goodLabel];
            
            self.detailLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 15 + 60 + 20, KScreenWidth - 40, 20)];
            self.detailLabel.font = [UIFont systemFontOfSize:14 * Fit];
            self.detailLabel.textColor = [UIColor grayColor];
            self.detailLabel.numberOfLines = 0;
            [self.contentView addSubview:_detailLabel];
        
            self.line2 = [[UIView alloc]initWithFrame:CGRectMake(0, 15 + 60 + 20 + 20 + 14, KScreenWidth, 1)];
            self.line2.backgroundColor = [UIColor blackColor];
            [self.contentView addSubview:_line2];
        }
        
    return self;
}

//titleLabel; lz_Image; lz_nameButton; lz_idenLabel; lz_timeLabel; lz_web; functionView; onlyLzButton; sortButton; hotButton; headImage; nameButton; timeLabel; detailLabel;

- (void)cellConfigureModel:(CommunityDetailModel *)model
{
    
        [self.headImage sd_setImageWithURL:[NSURL URLWithString:model.icon]];
        [self.nameButton setTitle:model.uname forState:UIControlStateNormal];
        self.timeLabel.text = model.addtime_f;
        self.goodLabel.text = [NSString stringWithFormat:@"👍 %ld", model.likenum];
        CGRect bounds = [model.content boundingRectWithSize:CGSizeMake(KScreenWidth - 40, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:14 * Fit] forKey:NSFontAttributeName] context:nil];
        self.detailLabel.frame = CGRectMake(20, 15 + 60 + 20, KScreenWidth - 40, bounds.size.height);
        self.detailLabel.text = model.content;
        if (_images) {
            for (int i = 0; i < self.images.count; i ++) {
                UIImageView *aImage = self.images[i];
                [aImage removeFromSuperview];
            }
            for (NSInteger i = _images.count - 1; i >= 0; i --) {
                [self.images removeObject:_images[i]];
            }
        }
        else {
            self.images = [NSMutableArray array];
        }
        for (int i = 0; i < model.imglist.count; i ++) {
            UIImageView *aImage = [[UIImageView alloc]initWithFrame:CGRectMake(20, 15 + 60 + 20 + bounds.size.height + 20 + i * (20 + KScreenWidth - 40), KScreenWidth - 40, KScreenWidth - 40)];
            [aImage sd_setImageWithURL:[NSURL URLWithString:model.imglist[i][@"imgurl"]]];
            [self.contentView addSubview:aImage];
            [self.images addObject:aImage];
        }
        
        self.line2.frame = CGRectMake(0, 15 + 60 + 20 + bounds.size.height + model.imglist.count * (20 + KScreenWidth - 40) + 14, KScreenWidth, 1);
}

+ (CGFloat)heightForRow:(CommunityDetailModel *)model
{
    
        CGRect bounds = [model.content boundingRectWithSize:CGSizeMake(KScreenWidth - 40, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:14 * Fit] forKey:NSFontAttributeName] context:nil];
        return 15 + 60 + 20 + bounds.size.height + model.imglist.count * (20 + KScreenWidth - 40) + 14 + 1;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
