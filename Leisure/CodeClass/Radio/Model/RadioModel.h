//
//  RadioModel.h
//  Leisure
//
//  Created by 若愚 on 16/2/14.
//  Copyright © 2016年 xinghu_wang. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface RadioModel : NSObject

@property(nonatomic, assign)NSInteger count;
@property(nonatomic, strong)NSString *coverimg;
@property(nonatomic, strong)NSString *desc;
@property(nonatomic, assign)BOOL isnew;
@property(nonatomic, strong)NSString *title;
@property(nonatomic, strong)NSString *uname;
@property(nonatomic, strong)NSString *radioid;
@property(nonatomic, strong)NSString *icon;

+ (NSMutableArray *)modelConfigureData:(NSData *)data;
+ (NSMutableArray *)getImageArray:(NSData *)data;

@end
