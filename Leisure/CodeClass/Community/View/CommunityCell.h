//
//  CommunityCell.h
//  Leisure
//
//  Created by 若愚 on 16/2/14.
//  Copyright © 2016年 xinghu_wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommunityModel.h"

@interface CommunityCell : UITableViewCell

@property(nonatomic, strong)UILabel *titleLabel;
@property(nonatomic, strong)UIImageView *mainImage;
@property(nonatomic, strong)UILabel *detailLabel;
@property(nonatomic, strong)UILabel *timeLabel;
@property(nonatomic, strong)UIButton *commentButton;
@property(nonatomic, strong)UILabel *commentNumLabel;
@property(nonatomic, strong)UIView *line;

- (void)cellConfigureModel:(CommunityModel *)model;
+ (CGFloat)heightOfRowWithModel:(CommunityModel *)model;

@end
