//
//  CommunityDetailCell.h
//  Leisure
//
//  Created by 若愚 on 16/2/19.
//  Copyright © 2016年 xinghu_wang. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "CommunityDetailModel.h"

@interface CommunityDetailCell : UITableViewCell <UIWebViewDelegate>


@property(nonatomic, strong)UIImageView *headImage;
@property(nonatomic, strong)UIButton *nameButton;
@property(nonatomic, strong)UILabel *timeLabel;
@property(nonatomic, strong)UILabel *goodLabel;
@property(nonatomic, strong)UILabel *detailLabel;
@property(nonatomic, strong)NSMutableArray *images;
//@property(nonatomic, assign)BOOL isFirst;
//@property(nonatomic, strong)UIView *line1;
@property(nonatomic, strong)UIView *line2;

- (void)cellConfigureModel:(CommunityDetailModel *)model;

+ (CGFloat)heightForRow:(CommunityDetailModel *)model;


@end
