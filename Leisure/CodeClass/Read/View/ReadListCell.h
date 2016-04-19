//
//  ReadListCell.h
//  Leisure
//
//  Created by 若愚 on 16/2/12.
//  Copyright © 2016年 xinghu_wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReadListModel.h"

@interface ReadListCell : UITableViewCell

@property(nonatomic, strong)UILabel *titleLabel;
@property(nonatomic, strong)UIImageView *mainImage;
@property(nonatomic, strong)UILabel *detailLabel;

- (void)cellConfigureModel:(ReadListModel *)model;

@end
