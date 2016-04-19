//
//  RadioPlayOneController.h
//  Leisure
//
//  Created by 若愚 on 16/2/22.
//  Copyright © 2016年 xinghu_wang. All rights reserved.
//

#import "RootListBaseController.h"
#import "RadioListModel.h"

@protocol RadioPlayOneControllerDelegate <NSObject>

- (void)changeSelf:(NSInteger)index;

@end

@interface RadioPlayOneController : UIViewController

@property(nonatomic, strong)NSString *radioid;
@property(nonatomic, strong)NSString *myTitle;
@property(nonatomic, strong)NSString *icon;
@property(nonatomic, strong)NSString *uname;
@property(nonatomic, strong)NSString *coverimg;
@property(nonatomic, strong)NSString *desc;
@property(nonatomic, strong)NSString *count;
@property(nonatomic, assign)id<RadioPlayOneControllerDelegate>delegate;

@property(nonatomic, strong)NSMutableArray *modelArray;
@property(nonatomic, strong)UITableView *tableView;

//@property(nonatomic, strong)RadioListModel *model;

@property(nonatomic, assign)NSInteger index;

- (instancetype)initWithRadioid:(NSString *)radioid title:(NSString *)title icon:(NSString *)icon uname:(NSString *)uname coverimg:(NSString *)coverimg desc:(NSString *)desc count:(NSInteger)count modelArray:(NSMutableArray *)modelArray index:(NSInteger)index;

@end
