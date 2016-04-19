//
//  CommunityDetailHeader.h
//  Leisure
//
//  Created by 若愚 on 16/2/19.
//  Copyright © 2016年 xinghu_wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommunityDetailModel.h"

@interface CommunityDetailHeader : UITableViewHeaderFooterView <UIWebViewDelegate>

@property(nonatomic, strong)UILabel *titleLabel;
@property(nonatomic, strong)UIImageView *lz_Image;
@property(nonatomic, strong)UIButton *lz_nameButton;
@property(nonatomic, strong)UILabel *lz_idenLabel;
@property(nonatomic, strong)UILabel *lz_timeLabel;
@property(nonatomic, strong)UIWebView *lz_web;
@property(nonatomic, strong)UIView *functionView;
@property(nonatomic, strong)UIButton *onlyLzButton;
@property(nonatomic, strong)UIButton *sortButton;
@property(nonatomic, strong)UIButton *hotButton;
@property(nonatomic, strong)UIView *line1;
@property(nonatomic, strong)UIView *line2;

- (void)headerConfigureModel:(CommunityDetailModel *)model;
+ (CGFloat)heightForHeader:(CommunityDetailModel *)model;

@end
