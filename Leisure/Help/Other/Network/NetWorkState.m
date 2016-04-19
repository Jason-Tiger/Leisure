//
//  NetWorkState.m
//  Leisure
//
//  Created by 若愚 on 16/2/22.
//  Copyright © 2016年 xinghu_wang. All rights reserved.
//

#import "NetWorkState.h"

@implementation NetWorkState

+ (BOOL)reachability
{
    Reachability *r = [Reachability reachabilityWithHostName:@"www.bilibili.com"];
    switch ([r currentReachabilityStatus]) {
        case NotReachable:
            return NO;
            break;
        case ReachableViaWWAN:
            return  YES;
            break;
        case ReachableViaWiFi:
            return YES;
            break;
            
        default:
            break;
    }
}

@end
