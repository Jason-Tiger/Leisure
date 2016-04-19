//
//  RadioModel.m
//  Leisure
//
//  Created by 若愚 on 16/2/14.
//  Copyright © 2016年 xinghu_wang. All rights reserved.
//

#import "RadioModel.h"

@implementation RadioModel

+ (NSMutableArray *)modelConfigureData:(NSData *)data
{
    NSMutableArray *array = [NSMutableArray array];
    NSDictionary *bigDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    NSDictionary *dataDic = bigDic[@"data"];
    NSArray *alllist = dataDic[@"alllist"];
    if (dataDic[@"list"]) {
        alllist = dataDic[@"list"];
    }
    for (NSDictionary *dic in alllist) {
        RadioModel *model = [[RadioModel alloc]init];
        [model setValuesForKeysWithDictionary:dic];
        NSDictionary *userinfo = dic[@"userinfo"];
        [model setValuesForKeysWithDictionary:userinfo];
        [array addObject:model];
    }
    return array;
}

+ (NSMutableArray *)getImageArray:(NSData *)data
{
    NSMutableArray *array = [NSMutableArray array];
    NSDictionary *bigDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    NSDictionary *dataDic = bigDic[@"data"];
    NSArray *carouselArr = dataDic[@"carousel"];
    for (NSDictionary *dic in carouselArr) {
        [array addObject:[dic objectForKey:@"img"]];
    }
    return array;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

@end
