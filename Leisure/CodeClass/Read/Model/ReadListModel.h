//
//  ReadListModel.h
//  Leisure
//
//  Created by 若愚 on 16/2/12.
//  Copyright © 2016年 xinghu_wang. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface ReadListModel : NSObject

@property(nonatomic, strong)NSString *content;
@property(nonatomic, strong)NSString *coverimg;
@property(nonatomic, strong)NSString *title;
@property(nonatomic, strong)NSString *myID;

//deviceid=63A94D37-33F9-40FF-9EBB-481182338873&typeid=12&client=1&sort=addtime&limit=10&version=3.0.2&auth=Wc06FCrkoq1DCMVzGMTikDJxQ8bm3Mrm2NpT9qWjwzcWP23tBKQ x1c4P0&start=1

+ (NSMutableArray *)modelConfigureData:(NSData *)data;

@end
