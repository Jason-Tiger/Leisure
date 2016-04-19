//
//  PlayerManager.m
//  AVPlayer
//
//  Created by 若愚 on 16/2/23.
//  Copyright © 2016年 xinghu_wang. All rights reserved.
//

#import "PlayerManager.h"

@interface PlayerManager ()

@property(nonatomic, strong)AVPlayer *player;
@property(nonatomic, assign)NSInteger index;

@end

@implementation PlayerManager

// 界面销毁时能继续播放
+ (instancetype)shardManager
{
    static PlayerManager *player = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        player = [[PlayerManager alloc]init];
    });
    return player;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.player = [[AVPlayer alloc]init];
        self.index = 0;
        self.playType = PlayTypeList;
    }
    return self;
}

- (void)setMusicArray:(NSMutableArray *)musicArray
{
    _musicArray  = musicArray;
    _index = 0;
    [self play];
}

- (NSInteger)preMusic
{
    if (_playType == PlayTypeList || _playType == PlayTypeSingle) {
        if (_index) {
            _index --;
        }
        else {
            _index = _musicArray.count - 1;
        }
    }
    else if (_playType == PlayTypeRandom) {
        _index = arc4random() % _musicArray.count;
    }
    [self play];
    return _index;
}

- (NSInteger)nextMusic
{
    if (_playType == PlayTypeList  || _playType == PlayTypeSingle) {
    if (_index == _musicArray.count - 1) {
        _index = 0;
      }
    else {
        _index ++;
      }
    }
    else if (_playType == PlayTypeRandom) {
        _index = arc4random() % _musicArray.count;
    }
    [self play];
    return _index;
}

- (void)play
{
    NSURL *url = [NSURL URLWithString:_musicArray[_index]];
    AVPlayerItem *item = [[AVPlayerItem alloc]initWithURL:url]; // 可以获取到歌曲的更多信息
    [_player replaceCurrentItemWithPlayerItem:item];
    [_player play];
}

- (void)playWithIndex:(NSInteger)index
{
    _index = index;
    NSURL *url = [NSURL URLWithString:_musicArray[index]];
    AVPlayerItem *item = [[AVPlayerItem alloc]initWithURL:url]; // 可以获取到歌曲的更多信息
    [_player replaceCurrentItemWithPlayerItem:item];
    [_player play];
}

- (void)continueMusic
{
    [_player play];
}

- (void)pause
{
    [_player pause];
}

- (void)seekToTime:(NSInteger)newTime
{
    [_player seekToTime:CMTimeMake(newTime * _player.currentTime.timescale, _player.currentTime.timescale)];
}

- (NSInteger)currentTime
{
    if (_player.currentTime.timescale) {
        return _player.currentTime.value / _player.currentTime.timescale;
    }
    return 0;
}

- (NSInteger)finishTime
{
    CMTime time = _player.currentItem.duration;
    if (time.timescale) {
//        CMTimeGetSeconds(time) // CMTime转化成秒的其他方法
        return time.value / time.timescale;
    }
    return 0;
}

- (NSInteger)musicDidFinish
{
    if (_playType == PlayTypeSingle) {
        [self seekToTime:0];
        [self continueMusic];
    }
    else {
        [self nextMusic];
    }
    return _index;
}

- (BOOL)isPlaying
{
    if (_player.rate == 0.0) { // 自带是否播放的一个float属性
        return NO;
    }
    else {
        return YES;
    }
}



@end
