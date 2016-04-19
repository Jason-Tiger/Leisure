//
//  ReadDetailController.h
//  Leisure
//
//  Created by 若愚 on 16/2/14.
//  Copyright © 2016年 xinghu_wang. All rights reserved.
//

#import "RootListBaseController.h"

@interface ReadDetailController : RootListBaseController

@property(nonatomic, strong)NSString *contentid;
@property(nonatomic, strong)NSString *type;
@property(nonatomic, strong)NSString *url;

- (instancetype)initWithContentid:(NSString *)contentid type:(NSString *)type;

@end
