//
//  GoodProductModel.h
//  Leisure
//
//  Created by 若愚 on 16/2/11.
//  Copyright © 2016年 xinghu_wang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GoodProductModel : NSObject

@property(nonatomic, strong)NSString *buyurl;
@property(nonatomic, strong)NSString *contentid;
@property(nonatomic, strong)NSString *coverimg;
@property(nonatomic, strong)NSString *title;

+ (NSMutableArray *)modelConfigureData:(NSData *)data;

@end
