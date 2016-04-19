//
//  RegisterModel.m
//  Leisure
//
//  Created by 若愚 on 16/2/16.
//  Copyright © 2016年 xinghu_wang. All rights reserved.
//

#import "RegisterModel.h"

@implementation RegisterModel

+ (RegisterModel *)modelConfigureData:(NSData *)data
{
    NSDictionary *bigDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    RegisterModel *model = [[RegisterModel alloc]init];
    NSNumber *num1 = [bigDic valueForKey:@"result"];
    NSInteger isOk = [num1 integerValue];
    if (isOk == 1) {
        model.isOk = YES;
    }
    else {
        model.isOk = NO;
    }
    NSDictionary *dataDic = bigDic[@"data"];
    [model setValuesForKeysWithDictionary:dataDic];
    return model;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"msg:%@, isOk:%d", _msg, _isOk];
}

@end
