//
//  CommunityModel.m
//  Leisure
//
//  Created by 若愚 on 16/2/14.
//  Copyright © 2016年 xinghu_wang. All rights reserved.
//

#import "CommunityModel.h"

@implementation CommunityModel

+ (NSMutableArray *)modelConfigureData:(NSData *)data
{
    NSMutableArray *array = [NSMutableArray array];
    NSDictionary *bigDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    NSDictionary *dataDic = bigDic[@"data"];
    NSArray *listArray = dataDic[@"list"];
    for (NSDictionary *dic in listArray) {
        CommunityModel *model = [[CommunityModel alloc]init];
        [model setValuesForKeysWithDictionary:dic];
        NSDictionary *counterListDic = dic[@"counterList"];
        model.commentNum = [(NSNumber *)counterListDic[@"comment"] integerValue];
        NSLog(@"%@", model);
        [array addObject:model];
    }
    return array;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"addtime_f:%@, title:%@, content:%@, commentNum:%ld, coverimg:%@, contentid:%@", _addtime_f, _title, _content, _commentNum, _coverimg, _contentid];
}

@end
