//
//  SoundPlayer.m
//  ViocePhotoAlbumDemo
//
//  Created by zhm on 14/11/25.
//  Copyright (c) 2014年 zhm. All rights reserved.
//

#import "SoundPlayer.h"


static void *kStatusKVOKey = &kStatusKVOKey;
static void *kDurationKVOKey = &kDurationKVOKey;
static void *kBufferingRatioKVOKey = &kBufferingRatioKVOKey;

@implementation SoundPlayer
- (id)initPlayUrl:(NSString *)url{

    if (self = [super init]) {
    
        self.model = [[VoicePhotoAlbumModel alloc]init];
        [self resetStreamerPlayUrl:url];
        NSLog(@"sound player 被执行");
    }
    
    return self;
}
- (void)makePlayer:(NSString *)url{

    self.model = [[VoicePhotoAlbumModel alloc]init];
    [self resetStreamerPlayUrl:url];


}
- (void)cancelStreamer{

    if (_streamer != nil) {
      [_streamer pause];
//        [_streamer stop];
        [_streamer removeObserver:self forKeyPath:@"status"];
        [_streamer removeObserver:self forKeyPath:@"duration"];
        [_streamer removeObserver:self forKeyPath:@"bufferingRatio"];
        _streamer = nil;
    }


}
- (void)resetStreamerPlayUrl:(NSString *)url{

    [self cancelStreamer];
    [self.model setAudioFileURL:[NSURL URLWithString:url]];
    
    _streamer = [DOUAudioStreamer streamerWithAudioFile:self.model];
    
    [_streamer addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:kStatusKVOKey];
    [_streamer addObserver:self forKeyPath:@"duration" options:NSKeyValueObservingOptionNew context:kDurationKVOKey];
    [_streamer addObserver:self forKeyPath:@"bufferingRatio" options:NSKeyValueObservingOptionNew context:kBufferingRatioKVOKey];

}
- (void)updateStatus
{
    [self.delegate changStatus:[_streamer status]];
    
    /*
    switch ([_streamer status]) {
        case DOUAudioStreamerPlaying:
            
            [_buttonPlayPause setTitle:@"暂停" forState:UIControlStateNormal];
            break;
            
        case DOUAudioStreamerPaused:
            
            [_buttonPlayPause setTitle:@"播放" forState:UIControlStateNormal];
            break;
            
        case DOUAudioStreamerIdle:
            
            [_buttonPlayPause setTitle:@"播放" forState:UIControlStateNormal];
            break;
            
        case DOUAudioStreamerFinished:
            [self _resetStreamer];
            NSLog(@"播放完成");
            break;
            
        case DOUAudioStreamerBuffering:
            [_buttonPlayPause setTitle:@"缓冲" forState:UIControlStateNormal];
            NSLog(@"正在缓冲");
            break;
            
        case DOUAudioStreamerError:
            NSLog(@"播放出错");
            break;
    }
     */
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (context == kStatusKVOKey) {
        [self performSelector:@selector(updateStatus)
                     onThread:[NSThread mainThread]
                   withObject:nil
                waitUntilDone:NO];
    }
    else if (context == kDurationKVOKey) {
        
        NSLog(@"播放中");
    }
    else if (context == kBufferingRatioKVOKey) {
        
        NSLog(@"正在缓冲哦");
        
    }
    else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void)play{
    
    if ([_streamer status] == DOUAudioStreamerPaused ||
        [_streamer status] == DOUAudioStreamerIdle) {
        [_streamer play];
    }
    else {
        [_streamer pause];
    }
    
    
    
}

- (void)stop{
    
    [_streamer stop];
    
}

- (void)dealloc{

    [_streamer stop];
    [self cancelStreamer];
    self.model = nil;


}
@end
