//
//  RadioListController.h
//  Leisure
//
//  Created by 若愚 on 16/2/21.
//  Copyright © 2016年 xinghu_wang. All rights reserved.
//

#import "RootListBaseController.h"

@interface RadioListController : RootListBaseController

@property(nonatomic, strong)NSString *radioid;
@property(nonatomic, strong)NSString *myTitle;
@property(nonatomic, strong)NSString *icon;
@property(nonatomic, strong)NSString *uname;
@property(nonatomic, strong)NSString *coverimg;
@property(nonatomic, strong)NSString *desc;
@property(nonatomic, strong)NSString *count;

- (instancetype)initWithRadioid:(NSString *)radioid title:(NSString *)title icon:(NSString *)icon uname:(NSString *)uname coverimg:(NSString *)coverimg desc:(NSString *)desc count:(NSInteger)count;

@end
