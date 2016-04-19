//
//  PlayerManager.h
//  AVPlayer
//
//  Created by 若愚 on 16/2/23.
//  Copyright © 2016年 xinghu_wang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

typedef NS_ENUM(NSInteger, PlayType) {
    PlayTypeList,
    PlayTypeRandom,
    PlayTypeSingle       
};

@interface PlayerManager : NSObject

@property(nonatomic, strong)NSMutableArray *musicArray;
@property(nonatomic, assign)PlayType playType;
@property(nonatomic, assign)BOOL isPlaying;

- (NSInteger)preMusic;
- (NSInteger)nextMusic;
- (void)play;
- (void)continueMusic;
- (void)playWithIndex:(NSInteger)index;
- (void)pause;
- (void)seekToTime:(NSInteger)newTime;
- (NSInteger)currentTime;
- (NSInteger)finishTime;
- (NSInteger)musicDidFinish;

// 界面销毁时能继续播放
+ (instancetype)shardManager;

@end
