//
//  RequestManager.h
//  Leisure
//
//  Created by lanou on 16/3/11.
//  Copyright © 2016年 yollet. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^Finish)(NSData *data);
typedef void(^Error)(NSError *error);
typedef NS_ENUM(NSInteger, RequestType) {
    requestTypeGet,
    requestTypePost
};

@interface RequestManager : NSObject

@property(nonatomic, copy)Finish finish;
@property(nonatomic, copy)Error failure;



+ (void)requestWithUrl:(NSString *)urlString requestType:(RequestType)requestType parDic:(NSDictionary *)parDic finish:(Finish)finish failure:(Error)failure;

@end
