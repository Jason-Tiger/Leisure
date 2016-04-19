//
//  ReadCommentCell.m
//  Leisure
//
//  Created by 若愚 on 16/2/15.
//  Copyright © 2016年 xinghu_wang. All rights reserved.
//

#import "ReadCommentCell.h"

@implementation ReadCommentCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.headImage = [[UIImageView alloc]initWithFrame:CGRectMake(20, 15, 60, 60)];
        self.headImage.image = [UIImage imageNamed:@"icon"];
        [self.contentView addSubview:_headImage];
        
        self.nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(20 + 60 + 10, 15 + 5, 250 * Fit, 20)];
        self.nameLabel.text = @"摄心";
        [self.contentView addSubview:_nameLabel];
        
        self.timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(20 + 60 + 10, 15 + 5 + 20 + 10, 200 * Fit, 20)];
        self.timeLabel.font = [UIFont systemFontOfSize:14 * Fit];
        self.timeLabel.textColor = [UIColor lightGrayColor];
        self.timeLabel.text = @"15:15";
        [self.contentView addSubview:_timeLabel];
        
        self.detailLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 15 + 60 + 15, KScreenWidth - 40, 40)];
        self.detailLabel.font = [UIFont systemFontOfSize:15 * Fit];
        self.detailLabel.textColor = [UIColor grayColor];
        self.detailLabel.text = @"fahkfhalkhfklwhlfhsdjkfhklahlkshfl";
        self.detailLabel.numberOfLines = 0;
        [self.contentView addSubview:_detailLabel];
        
        self.line = [[UIView alloc]initWithFrame:CGRectMake(0, 15 + 60 + 15 + 40 + 22, KScreenWidth, 1)];
        self.line.backgroundColor = [UIColor grayColor];
        [self.contentView addSubview:_line];
        
        self.deleteButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [self.deleteButton setTitle:@"删除" forState:UIControlStateNormal];
        self.deleteButton.frame = CGRectMake(20 + 60 + 10 + 10 + 200 * Fit, 15 + 5 + 20 + 10, 40 * Fit, 20);
        self.deleteButton.hidden = YES;
        [self.contentView addSubview:_deleteButton];
    }
    return self;
}

- (void)cellConfigureModel:(ReadCommentModel *)model
{
    [self.headImage sd_setImageWithURL:[NSURL URLWithString:model.icon]];
    self.nameLabel.text = model.uname;
    self.timeLabel.text = model.addtime_f;
    CGRect bounds = [model.content boundingRectWithSize:CGSizeMake(KScreenWidth - 40, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:15 * Fit] forKey:NSFontAttributeName] context:nil];
    self.detailLabel.frame = CGRectMake(20, 15 + 60 + 15, KScreenWidth - 40, bounds.size.height);
    self.detailLabel.text = model.content;
    self.line.frame = CGRectMake(0, 15 + 60 + 15 + bounds.size.height + 22, KScreenWidth, 1);
    NSString *name = [[NSUserDefaults standardUserDefaults] stringForKey:@"user"];
    LandingModel *model1 = [LandingDB findUserInfoWithName:name];
    if ([model1.uname isEqualToString:model.uname]) {
        self.deleteButton.hidden = NO;
    }
    else {
        self.deleteButton.hidden = YES;
    }
}

+ (CGFloat)heightOfRowWithModel:(ReadCommentModel *)model
{
    CGRect bounds = [model.content boundingRectWithSize:CGSizeMake(KScreenWidth - 40, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:15 * Fit] forKey:NSFontAttributeName] context:nil];
    return 15 + 60 + 15 + bounds.size.height + 22 + 1;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
