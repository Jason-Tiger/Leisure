//
//  CommunityModel.h
//  Leisure
//
//  Created by 若愚 on 16/2/14.
//  Copyright © 2016年 xinghu_wang. All rights reserved.
//
#import <Foundation/Foundation.h>

@interface CommunityModel : NSObject

@property(nonatomic, strong)NSString *addtime_f;
@property(nonatomic, strong)NSString *title;
@property(nonatomic, strong)NSString *content;
@property(nonatomic, assign)NSInteger commentNum;
@property(nonatomic, strong)NSString *coverimg;
@property(nonatomic, assign)BOOL isrecommend;
@property(nonatomic, strong)NSString *contentid;

+ (NSMutableArray *)modelConfigureData:(NSData *)data;

@end
