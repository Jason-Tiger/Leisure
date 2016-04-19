//
//  RootListBaseController.h
//  Leisure
//
//  Created by 若愚 on 16/2/10.
//  Copyright © 2016年 xinghu_wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RightController.h"

@interface RootListBaseController : UIViewController

@property(nonatomic, strong)UIView *topView;
@property(nonatomic, strong)UIButton *changeFrameButton;
@property(nonatomic, strong)UILabel *typeLabel;
@property(nonatomic, strong)RightController *rightVc;

@end
