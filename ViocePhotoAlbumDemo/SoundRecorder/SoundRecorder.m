//
//  SoundRecorder.m
//  ViocePhotoAlbumDemo
//
//  Created by zhm on 14/11/25.
//  Copyright (c) 2014年 zhm. All rights reserved.
//

#import "SoundRecorder.h"

@implementation SoundRecorder
- (id)init{
    if (self = [super init]) {
      
        [self initializeRecorder];
    }

    return self;

}
- (void)initializeRecorder{

    self.fileName = @"soundfile";
    if ([[[UIDevice currentDevice] systemVersion] compare:@"7.0"] != NSOrderedAscending)
    {
        //7.0第一次运行会提示，是否允许使用麦克风
        AVAudioSession *session = [AVAudioSession sharedInstance];
        NSError *sessionError;
        //AVAudioSessionCategoryPlayAndRecord用于录音和播放
        [session setCategory:AVAudioSessionCategoryPlayAndRecord error:&sessionError];
        if(session == nil)
            NSLog(@"Error creating session: %@", [sessionError description]);
        else
            [session setActive:YES error:nil];
    }
    
    //录音设置
    _configurationDic =[[NSDictionary alloc] initWithObjectsAndKeys:
                           [NSNumber numberWithInt:kAudioFormatMPEG4AAC],AVFormatIDKey,
                           [NSNumber numberWithInt:1000.0],AVSampleRateKey,
                           [NSNumber numberWithInt:2],AVNumberOfChannelsKey,
                           [NSNumber numberWithInt:8],AVLinearPCMBitDepthKey,
                           [NSNumber numberWithBool:NO],AVLinearPCMIsBigEndianKey,
                           [NSNumber numberWithBool:NO],AVLinearPCMIsFloatKey,
                           nil];
   

}
//开始录音
- (void)beginRecord{
    
    if (self.filePath == nil) {
        NSString *documentDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        self.filePath = [NSString stringWithFormat:@"%@/%@.aac",documentDir,self.fileName];
        
    }
    if ([self canRecord]) {
        NSError *error = nil;
     
        if (_recorder == nil) {
    
        _recorder = [[AVAudioRecorder alloc]initWithURL:[NSURL URLWithString:self.filePath] settings:self.configurationDic error:&error];
        }
        if (_recorder) {
            _recorder.meteringEnabled = YES;
            [_recorder prepareToRecord];
            [_recorder record];
             _timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(levelTimer:) userInfo:nil repeats:YES];
        }
    
    
        
    }else{
    
        NSLog(@"不允许使用麦克风");
    
    }

}
- (void)levelTimer:(NSTimer *)timer{
    [_recorder updateMeters];
    

}
//判断是否允许使用麦克风7.0新增的方法requestRecordPermission
-(BOOL)canRecord
{
    __block BOOL bCanRecord = YES;
    if ([[[UIDevice currentDevice] systemVersion] compare:@"7.0"] != NSOrderedAscending)
    {
        AVAudioSession *audioSession = [AVAudioSession sharedInstance];
        if ([audioSession respondsToSelector:@selector(requestRecordPermission:)]) {
            [audioSession performSelector:@selector(requestRecordPermission:) withObject:^(BOOL granted) {
                if (granted) {
                    bCanRecord = YES;
                }
                else {
                    bCanRecord = NO;
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [[[UIAlertView alloc] initWithTitle:nil
                                                    message:@"app需要访问您的麦克风。\n请启用麦克风-设置/隐私/麦克风"
                                                   delegate:nil
                                          cancelButtonTitle:@"关闭"
                                          otherButtonTitles:nil] show];
                    });
                }
            }];
        }
    }
    
    return bCanRecord;
}
//停止录音
- (void)stopRecord{
    
    [_recorder stop];
    _recorder = nil;
    [self.timer invalidate];
    self.timer = nil;
    
}
//播放
- (void)localPlay{

    NSError *playerError;
    if (self.localPlayer == nil) {
        
        self.localPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL URLWithString:self.filePath] error:&playerError];
        self.localPlayer.delegate = self;
        
    }
  
    if (self.localPlayer == nil) {
        NSLog(@"播放器不存在");
        
    }else{
        
        [self.localPlayer prepareToPlay];
        [self.localPlayer play];
    
    }

}
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag{

    [self.delegate changStatus];


}
@end
