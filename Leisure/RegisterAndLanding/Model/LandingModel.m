//
//  LandingModel.m
//  Leisure
//
//  Created by 若愚 on 16/2/16.
//  Copyright © 2016年 xinghu_wang. All rights reserved.
//

#import "LandingModel.h"

@implementation LandingModel

+ (LandingModel *)modelConfigureData:(NSData *)data
{
    NSDictionary *bigDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    LandingModel *model = [[LandingModel alloc]init];
    NSNumber *num1 = [bigDic valueForKey:@"result"];
    NSInteger isOk = [num1 integerValue];
    if (isOk == 1) {
        model.isOk = YES;
    }
    else {
        model.isOk = NO;
    }
    [model setValuesForKeysWithDictionary:bigDic];
    NSDictionary *dataDic = bigDic[@"data"];
    [model setValuesForKeysWithDictionary:dataDic];
    NSNumber *num = [dataDic valueForKey:@"uid"];
    model.myID = [num integerValue];
    return model;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"isOK:%d, auth:%@, coverimg:%@, icon:%@, myID:%ld, uname:%@", _isOk, _auth, _coverimg, _icon, _myID, _uname];
}

@end
