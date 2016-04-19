//
//  RadioListModel.m
//  Leisure
//
//  Created by 若愚 on 16/2/21.
//  Copyright © 2016年 xinghu_wang. All rights reserved.
//

#import "RadioListModel.h"

@implementation RadioListModel

+ (NSMutableArray *)modelConfigureData:(NSData *)data
{
    NSMutableArray *array = [NSMutableArray array];
    NSDictionary *bigDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    NSDictionary *dataDic = bigDic[@"data"];
    NSArray *listArray = dataDic[@"list"];
    for (NSDictionary *dic in listArray) {
        RadioListModel *model = [[RadioListModel alloc]init];
        [model setValuesForKeysWithDictionary:dic];
        NSDictionary *playInfoDic = dic[@"playInfo"];
        [model setValuesForKeysWithDictionary:playInfoDic];
        [array addObject:model];
    }
    return array;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

@end
