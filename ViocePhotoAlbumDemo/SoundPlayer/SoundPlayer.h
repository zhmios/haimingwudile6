//
//  SoundPlayer.h
//  ViocePhotoAlbumDemo
//
//  Created by zhm on 14/11/25.
//  Copyright (c) 2014年 zhm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DOUAudioStreamer.h"
#import "DOUAudioVisualizer.h"
#import "VoicePhotoAlbumModel.h"
@protocol SoundPlayerDelegate<NSObject>
@optional
- (void)changStatus:(DOUAudioStreamerStatus)status;

@end
@interface SoundPlayer : NSObject

@property (nonatomic, retain) DOUAudioStreamer *streamer;
@property (nonatomic, assign) NSInteger currentTrackIndex;
@property (nonatomic, retain) VoicePhotoAlbumModel *model;
@property (nonatomic, weak) id<SoundPlayerDelegate>delegate;
- (id)initPlayUrl:(NSString *)url;
- (void)makePlayer:(NSString *)url;
- (void)play;
- (void)stop;

@end
