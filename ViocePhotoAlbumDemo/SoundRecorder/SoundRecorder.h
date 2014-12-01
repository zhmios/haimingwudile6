//
//  SoundRecorder.h
//  ViocePhotoAlbumDemo
//
//  Created by zhm on 14/11/25.
//  Copyright (c) 2014年 zhm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <UIKit/UIKit.h>
@protocol SoundRecorderDelegate<NSObject>
@optional
- (void)changStatus;

@end
@interface SoundRecorder : NSObject<AVAudioPlayerDelegate>

@property (nonatomic,strong) AVAudioRecorder *recorder;
@property (nonatomic, copy) NSString *filePath;
@property (nonatomic, copy) NSString *fileName;
@property (nonatomic, retain) NSDictionary *configurationDic;
@property (nonatomic, retain) NSTimer *timer;
@property (nonatomic, strong) AVAudioPlayer *localPlayer;
@property (nonatomic, weak) id<SoundRecorderDelegate>delegate;

- (void)beginRecord;
- (void)stopRecord;
- (void)localPlay;

@end
