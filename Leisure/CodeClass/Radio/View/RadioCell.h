//
//  RadioCell.h
//  Leisure
//
//  Created by 若愚 on 16/2/14.
//  Copyright © 2016年 xinghu_wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RadioModel.h"

@interface RadioCell : UITableViewCell

@property(nonatomic, strong)UIImageView *mainImage;
@property(nonatomic, strong)UILabel *typeLabel;
@property(nonatomic, strong)UILabel *authorLabel;
@property(nonatomic, strong)UILabel *sourceLabel;
@property(nonatomic, strong)UIImageView *listenerImage;
@property(nonatomic, strong)UILabel *listenerLabel;

- (void)cellConfigureModel:(RadioModel *)model;

@end
