//
//  ReadModel.h
//  Leisure
//
//  Created by 若愚 on 16/2/12.
//  Copyright © 2016年 xinghu_wang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ReadModel : NSObject

@property(nonatomic, strong)NSString *coverimg;
@property(nonatomic, strong)NSString *name;
@property(nonatomic, assign)NSInteger type;
@property(nonatomic, strong)NSString *enname;

+ (NSMutableArray *)modelConfigureData:(NSData *)data;

+ (NSMutableArray *)getImageArray:(NSData *)data;

@end
