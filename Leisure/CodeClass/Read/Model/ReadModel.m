//
//  ReadModel.m
//  Leisure
//
//  Created by 若愚 on 16/2/12.
//  Copyright © 2016年 xinghu_wang. All rights reserved.
//


#import "ReadModel.h"

@implementation ReadModel

+ (NSMutableArray *)modelConfigureData:(NSData *)data
{
    NSMutableArray *array = [NSMutableArray array];
    NSDictionary *bigDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    NSDictionary *dataDic = bigDic[@"data"];
    NSArray *listArray = dataDic[@"list"];
    for (NSDictionary *dic in listArray) {
        ReadModel *model = [[ReadModel alloc]init];
        [model setValuesForKeysWithDictionary:dic];
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
