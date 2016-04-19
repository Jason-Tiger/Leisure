//
//  RequestManager.m
//  Leisure
//
//  Created by 若愚 on 16/2/11.
//  Copyright © 2016年 xinghu_wang. All rights reserved.
//


#import "RequestManager.h"

@implementation RequestManager

+ (void)requestWithUrl:(NSString *)urlString requestType:(RequestType)requestType parDic:(NSDictionary *)parDic finish:(Finish)finish failure:(Error)failure
{
//    self.finish = finish;
//    self.error = error;
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    if (requestType == requestTypePost) {
        [request setHTTPMethod:@"POST"];
        if (parDic.count != 0) {
            [request setHTTPBody:[RequestManager dicToDataWithDic:parDic]];
        }
    }
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            failure(error);
        }
        else {
            finish(data);
        }
    }] resume];
    
//    [[[NSURLSession sharedSession] dataTaskWithURL:[NSURL URLWithString:urlString] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//        if (error) {
//            failure(error);
//        }
//        else {
//            finish(data);
//        }
//    }] resume];
}

#pragma mark -- 将字典键值对转化成post的加密部分 --
+ (NSData *)dicToDataWithDic:(NSDictionary *)dic
{
    NSMutableArray *array = [NSMutableArray array];
    for (NSString *key in dic) {
        NSString *string = [NSString stringWithFormat:@"%@=%@", key, dic[key]];
        [array addObject:string];
    }
    NSString *dataString = [array componentsJoinedByString:@"&"];
    return [dataString dataUsingEncoding:NSUTF8StringEncoding];
}

@end
