//
//  RadioListModel.h
//  Leisure
//
//  Created by 若愚 on 16/2/21.
//  Copyright © 2016年 xinghu_wang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RadioListModel : NSObject

@property(nonatomic, strong)NSString *coverimg;
@property(nonatomic, assign)BOOL isnew;
@property(nonatomic, strong)NSString *musicUrl;
@property(nonatomic, strong)NSString *ting_contentid;
@property(nonatomic, strong)NSString *tingid;
@property(nonatomic, strong)NSString *title;
@property(nonatomic, strong)NSString *musicVisit;
@property(nonatomic, strong)NSString *webview_url;

@property(nonatomic, assign)BOOL isSelect;

+ (NSMutableArray *)modelConfigureData:(NSData *)data;

@end
