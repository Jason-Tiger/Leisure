//
//  ReadCommentCell.h
//  Leisure
//
//  Created by 若愚 on 16/2/15.
//  Copyright © 2016年 xinghu_wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReadCommentModel.h"

@interface ReadCommentCell : UITableViewCell

@property(nonatomic, strong)UIImageView *headImage;
@property(nonatomic, strong)UILabel *nameLabel;
@property(nonatomic, strong)UILabel *timeLabel;
@property(nonatomic, strong)UILabel *detailLabel;
@property(nonatomic, strong)UIView *line;
@property(nonatomic, strong)UIButton *deleteButton;

- (void)cellConfigureModel:(ReadCommentModel *)model;
+ (CGFloat)heightOfRowWithModel:(ReadCommentModel *)model;

@end
