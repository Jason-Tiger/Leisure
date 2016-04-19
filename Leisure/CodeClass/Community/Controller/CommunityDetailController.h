//
//  CommunityDetailController.h
//  Leisure
//
//  Created by 若愚 on 16/2/19.
//  Copyright © 2016年 xinghu_wang. All rights reserved.
//

#import "RootListBaseController.h"

@interface CommunityDetailController : RootListBaseController

@property(nonatomic, strong)NSString *contentid;
@property(nonatomic, strong)NSString *type;

- (instancetype)initWithContentid:(NSString *)contentid type:(NSString *)type;

@end
