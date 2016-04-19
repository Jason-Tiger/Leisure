//
//  ReadDetailModel.m
//  Leisure
//
//  Created by 若愚 on 16/2/14.
//  Copyright © 2016年 xinghu_wang. All rights reserved.
//

#import "ReadDetailModel.h"

@implementation ReadDetailModel

+ (ReadDetailModel *)modelConfigureData:(NSData *)data
{
    NSDictionary *bigDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    NSDictionary *dataDic = bigDic[@"data"];
    NSDictionary *counterList = dataDic[@"counterList"];
    ReadDetailModel *model = [[ReadDetailModel alloc]init];
    [model setValuesForKeysWithDictionary:counterList];
    model.htmlStr = dataDic[@"html"];
    return model;
}

@end
