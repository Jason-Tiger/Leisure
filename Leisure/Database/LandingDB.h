//
//  LandingDB.h
//  Leisure
//
//  Created by 若愚 on 16/2/16.
//  Copyright © 2016年 xinghu_wang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "LandingModel.h"

//@property(nonatomic, assign)BOOL isOk;
//@property(nonatomic, strong)NSString *auth;
//@property(nonatomic, strong)NSString *coverimg;
//@property(nonatomic, strong)NSString *icon;
//@property(nonatomic, assign)NSInteger myID;
//@property(nonatomic, strong)NSString *uname;

@interface LandingDB : NSObject

+ (void)addUserInfoWithModel:(LandingModel *)model;

+ (LandingModel *)findUserInfoWithName:(NSString *)name;

+ (void)deleteUserInfoWithName:(NSString *)name;

+ (NSMutableArray *)selectAllData;

@end
