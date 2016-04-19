//
//  ReadDetailModel.h
//  Leisure
//
//  Created by 若愚 on 16/2/14.
//  Copyright © 2016年 xinghu_wang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ReadDetailModel : NSObject

@property(nonatomic, assign)NSInteger comment;
@property(nonatomic, assign)NSInteger like;
@property(nonatomic, strong)NSString *htmlStr;

+ (ReadDetailModel *)modelConfigureData:(NSData *)data;

@end
