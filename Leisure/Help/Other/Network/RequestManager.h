//
//  RequestManager.h
//  Leisure
//
//  Created by 若愚 on 16/2/11.
//  Copyright © 2016年 xinghu_wang. All rights reserved.
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
