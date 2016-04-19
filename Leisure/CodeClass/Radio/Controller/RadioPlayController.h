//
//  RadioPlayController.h
//  Leisure
//
//  Created by 若愚 on 16/2/23.
//  Copyright © 2016年 xinghu_wang. All rights reserved.
//

#import "RootListBaseController.h"
#import "RadioListModel.h"
#import "RadioPlayOneController.h"
#import "RadioPlayTwoController.h"

@protocol RadioPlayControllerDelegate <NSObject>

- (void)changeViewWithImageUrl:(NSString *)imageUrl title:(NSString *)title name:(NSString *)name;

@end

@interface RadioPlayController : RootListBaseController

@property(nonatomic, strong)NSString *radioid;
@property(nonatomic, strong)NSString *myTitle;
@property(nonatomic, strong)NSString *icon;
@property(nonatomic, strong)NSString *uname;
@property(nonatomic, strong)NSString *coverimg;
@property(nonatomic, strong)NSString *desc;
@property(nonatomic, strong)NSString *count;
@property(nonatomic, strong)NSMutableArray *modelArray;
@property(nonatomic, assign)NSInteger index;

@property(nonatomic, strong)RadioPlayOneController *firstView;
@property(nonatomic, strong)RadioPlayTwoController *secondView;
@property(nonatomic, strong)UIWebView *thirdView;
@property(nonatomic, strong)UIView *forthView;

@property(nonatomic, assign)id<RadioPlayControllerDelegate>delegate;

+ (instancetype)shardRadioPlayController;

//- (instancetype)initWithRadioid:(NSString *)radioid title:(NSString *)title icon:(NSString *)icon uname:(NSString *)uname coverimg:(NSString *)coverimg desc:(NSString *)desc count:(NSInteger)count  modelArray:(NSMutableArray *)modelArray index:(NSInteger)index;

- (void)setRadioid:(NSString *)radioid title:(NSString *)title icon:(NSString *)icon uname:(NSString *)uname coverimg:(NSString *)coverimg desc:(NSString *)desc count:(NSInteger)count  modelArray:(NSMutableArray *)modelArray index:(NSInteger)index;

- (void)openUser;

@end
