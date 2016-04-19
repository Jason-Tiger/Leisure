//
//  RadioPlayTwoController.h
//  Leisure
//
//  Created by 若愚 on 16/2/22.
//  Copyright © 2016年 xinghu_wang. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface RadioPlayTwoController : UIViewController

@property(nonatomic, strong)NSString *coverimg;
@property(nonatomic, strong)NSString *myTitle;

@property(nonatomic, strong)UIImageView *mainImage;
@property(nonatomic, strong)UILabel *titleLabel;
@property(nonatomic, strong)UIButton *loveButton;
@property(nonatomic, strong)UIButton *commentButton;
@property(nonatomic, strong)UILabel *loveNumLabel;
@property(nonatomic, strong)UILabel *commentNumLabel;
@property(nonatomic, strong)UILabel *timeLabel;
@property(nonatomic, strong)UISlider *planSlider;
@property(nonatomic, strong)UILabel *maxTimeLabel;
@property(nonatomic, strong)PlayerManager *player;

- (instancetype)initWithCoverimg:(NSString *)coverimg myTitle:(NSString *)myTitle;

- (void)setCoverimg:(NSString *)coverimg myTitle:(NSString *)myTitle;

@end
