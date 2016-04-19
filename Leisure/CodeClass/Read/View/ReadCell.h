//
//  ReadCell.h
//  Leisure
//
//  Created by 若愚 on 16/2/12.
//  Copyright © 2016年 xinghu_wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReadModel.h"

@interface ReadCell : UICollectionViewCell

@property(nonatomic, strong)UIImageView *mainImage;
@property(nonatomic, strong)UILabel *titleLabel;

- (void)cellConfigureModel:(ReadModel *)model;

@end
