//
//  CommunityDetailModel.h
//  Leisure
//
//  Created by 若愚 on 16/2/19.
//  Copyright © 2016年 xinghu_wang. All rights reserved.
//
#import <Foundation/Foundation.h>

@interface CommunityDetailModel : NSObject

@property(nonatomic, strong)NSString *addtime_f;
@property(nonatomic, assign)NSInteger cmtnum;
@property(nonatomic, strong)NSString *content;
@property(nonatomic, strong)NSArray *imglist;
@property(nonatomic, assign)NSInteger likenum;
@property(nonatomic, strong)NSString *icon;
@property(nonatomic, assign)NSInteger uid;
@property(nonatomic, strong)NSString *uname;
@property(nonatomic, strong)NSString *title;
@property(nonatomic, strong)NSString *lz_addtime_f;
@property(nonatomic, assign)NSInteger comment;
@property(nonatomic, assign)NSInteger like;
@property(nonatomic, strong)NSString *lz_uname;
@property(nonatomic, strong)NSString *lz_icon;
@property(nonatomic, strong)NSString *html;
@property(nonatomic, assign)BOOL isFirst;

+ (NSMutableArray *)modelConfigureData:(NSData *)data;

+ (NSMutableArray *)modelConfigureListData:(NSData *)data;

@end
