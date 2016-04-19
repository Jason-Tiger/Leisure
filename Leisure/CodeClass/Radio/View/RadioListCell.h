//
//  RadioListCell.h
//  Leisure
//
//  Created by 若愚 on 16/2/21.
//  Copyright © 2016年 xinghu_wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RadioListModel.h"

@interface RadioListCell : UITableViewCell

@property(nonatomic, strong)UIImageView *mainImage;
@property(nonatomic, strong)UILabel *titleLabel;
@property(nonatomic, strong)UIImageView *listenerImage;
@property(nonatomic, strong)UILabel *listenerNum;
@property(nonatomic, strong)UIButton *playButton;
@property(nonatomic, assign)BOOL isDown;
@property(nonatomic, strong)UIView *selectView;

- (void)cellConfigureModel:(RadioListModel *)model;
+ (CGFloat)heightForCellWithModel:(RadioListModel *)model;

@end
