//
//  GoodProductModel.m
//  Leisure
//
//  Created by 若愚 on 16/2/11.
//  Copyright © 2016年 xinghu_wang. All rights reserved.
//

#import "GoodProductModel.h"

@implementation GoodProductModel

+ (NSMutableArray *)modelConfigureData:(NSData *)data
{
    NSMutableArray *array = [NSMutableArray array];
    NSDictionary *bigDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    NSDictionary *mediumDic = bigDic[@"data"];
    NSArray *listArray = mediumDic[@"list"];
    for (NSDictionary *dic in listArray) {
        GoodProductModel *model = [[GoodProductModel alloc]init];
        [model setValuesForKeysWithDictionary:dic];
        [array addObject:model];
    }
    return array;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

@end
