//
//  GoodProductCell.h
//  Leisure
//
//  Created by 若愚 on 16/2/10.
//  Copyright © 2016年 xinghu_wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodProductModel.h"

@interface GoodProductCell : UITableViewCell

@property(nonatomic, strong)UIImageView *mainImageView;
@property(nonatomic, strong)UILabel *titleLabel;
@property(nonatomic, strong)UIButton *buyButton;
@property(nonatomic, strong)GoodProductModel *model;
@property(nonatomic, strong)UIView *line;

- (void)cellConfigureModel:(GoodProductModel *)model;

@end
