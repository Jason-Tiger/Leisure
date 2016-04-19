//
//  CommunityDetailModel.m
//  Leisure
//
//  Created by 若愚 on 16/2/19.
//  Copyright © 2016年 xinghu_wang. All rights reserved.
//

#import "CommunityDetailModel.h"

@implementation CommunityDetailModel

//*addtime_f; cmtnum; *content; *imglist; likenum; *icon; uid; *uname; *title; *lz_addtime_f; comment; like; *lz_uname; *lz_icon; *html;
+ (NSMutableArray *)modelConfigureData:(NSData *)data
{
    NSMutableArray *array = [NSMutableArray array];
    NSDictionary *bigDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    NSDictionary *dataDic = bigDic[@"data"];
    CommunityDetailModel *model = [[CommunityDetailModel alloc]init];
    [model setValuesForKeysWithDictionary:dataDic];
    NSDictionary *postsinfoDic = dataDic[@"postsinfo"];
    [model setValuesForKeysWithDictionary:postsinfoDic];
    model.lz_addtime_f = [postsinfoDic objectForKey:@"addtime_f"];
    NSDictionary *counterListDic = postsinfoDic[@"counterList"];
    [model setValuesForKeysWithDictionary:counterListDic];
    NSDictionary *lz_userinfoDic = postsinfoDic[@"userinfo"];
    model.lz_icon = lz_userinfoDic[@"icon"];
    model.lz_uname = lz_userinfoDic[@"uname"];
    model.isFirst = YES;
    [array addObject:model];
    NSArray *commentlistArr = dataDic[@"commentlist"];
    for (NSDictionary *dic in commentlistArr) {
        CommunityDetailModel *aModel = [[CommunityDetailModel alloc]init];
        [aModel setValuesForKeysWithDictionary:dic];
        NSDictionary *userinfoDic = dic[@"userinfo"];
        [aModel setValuesForKeysWithDictionary:userinfoDic];
        [array addObject:aModel];
    }
    
    return array;
}

//*addtime_f; cmtnum; *content; *imglist; likenum; *icon; uid; *uname; *title; *lz_addtime_f; comment; like; *lz_uname; *lz_icon; *html;

+ (NSMutableArray *)modelConfigureListData:(NSData *)data
{
    NSMutableArray *array = [NSMutableArray array];
    return array;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

@end
