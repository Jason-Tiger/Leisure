//
//  ReadCommentModel.h
//  Leisure
//
//  Created by 若愚 on 16/2/15.
//  Copyright © 2016年 xinghu_wang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ReadCommentModel : NSObject

@property(nonatomic, strong)NSString *addtime_f;
@property(nonatomic, strong)NSString *content;
@property(nonatomic, assign)BOOL isdel;
@property(nonatomic, strong)NSString *icon;
@property(nonatomic, strong)NSString *uname;
@property(nonatomic, strong)NSString *contentid;

+ (NSMutableArray *)modelConfigureData:(NSData *)data;

@end
