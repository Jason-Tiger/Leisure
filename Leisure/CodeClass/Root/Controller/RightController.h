//
//  RightController.h
//  Leisure
//
//  Created by 若愚 on 16/2/10.
//  Copyright © 2016年 xinghu_wang. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface RightController : UIViewController

- (void)changeViewWithIndex:(NSInteger)index; // 跳转界面
@property(nonatomic, strong)UITapGestureRecognizer *tap;

- (void)changeFrame:(UIButton *)button;

@end
