//
//  ReadCommentController.h
//  Leisure
//
//  Created by 若愚 on 16/2/15.
//  Copyright © 2016年 xinghu_wang. All rights reserved.
//
#import "RootListBaseController.h"

@interface ReadCommentController : RootListBaseController

@property(nonatomic, strong)NSString *contentid;

- (instancetype)initWithContentid:(NSString *)contentid;

@end
