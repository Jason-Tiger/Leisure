//
//  ReadCommentModel.m
//  Leisure
//
//  Created by 若愚 on 16/2/15.
//  Copyright © 2016年 xinghu_wang. All rights reserved.
//

#import "ReadCommentModel.h"

@implementation ReadCommentModel

+ (NSMutableArray *)modelConfigureData:(NSData *)data
{
    NSMutableArray *array = [NSMutableArray array];
    NSDictionary *bigDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    NSDictionary *dataDic = bigDic[@"data"];
    NSArray *listArray = dataDic[@"list"];
    for (NSDictionary *dic in listArray) {
        ReadCommentModel *model = [[ReadCommentModel alloc]init];
        [model setValuesForKeysWithDictionary:dic];
        NSDictionary *userinfoDic = dic[@"userinfo"];
        model.icon = userinfoDic[@"icon"];
        model.uname = userinfoDic[@"uname"];
        [array addObject:model];
    }
    return array;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

@end
