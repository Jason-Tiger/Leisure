//
//  LandingModel.h
//  Leisure
//
//  Created by 若愚 on 16/2/16.
//  Copyright © 2016年 xinghu_wang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LandingModel : NSObject

@property(nonatomic, assign)BOOL isOk;
@property(nonatomic, strong)NSString *auth;
@property(nonatomic, strong)NSString *coverimg;
@property(nonatomic, strong)NSString *icon;
@property(nonatomic, assign)NSInteger myID;
@property(nonatomic, strong)NSString *uname;
@property(nonatomic, strong)NSString *msg;

+ (LandingModel *)modelConfigureData:(NSData *)data;

@end
