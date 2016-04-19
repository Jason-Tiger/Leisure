//
//  ReadListController.h
//  Leisure
//
//  Created by 若愚 on 16/2/12.
//  Copyright © 2016年 xinghu_wang. All rights reserved.
//

#import "RootListBaseController.h"

@interface ReadListController : RootListBaseController

@property(nonatomic, strong)NSString *typeID;
@property(nonatomic, strong)NSString *typeName;

- (instancetype)initWithTypeID:(NSString *)typeID typeName:(NSString *)typeName;

@end
