//
//  RegisterModel.h
//  Leisure
//
//  Created by 若愚 on 16/2/16.
//  Copyright © 2016年 xinghu_wang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RegisterModel : NSObject

@property(nonatomic, strong)NSString *msg;
@property(nonatomic, assign)BOOL isOk;

+ (RegisterModel *)modelConfigureData:(NSData *)data;

@end
