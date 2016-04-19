//
//  LandingView.h
//  Leisure
//
//  Created by 若愚 on 16/2/16.
//  Copyright © 2016年 xinghu_wang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LandingController;
@interface LandingView : UIView 

@property(nonatomic, strong)UIImageView *headImage;
@property(nonatomic, strong)UITextField *mailField;
@property(nonatomic, strong)UITextField *passwordField;
@property(nonatomic, strong)UIButton *landingButton;
@property(nonatomic, strong)UIButton *weiXinButton;
@property(nonatomic, strong)UIButton *renRenButton;
@property(nonatomic, strong)UIButton *sinaButton;
@property(nonatomic, strong)UIButton *qqButton;
@property(nonatomic, strong)NSDictionary *userdic;

@property(nonatomic, strong)LandingModel *model;
@end
