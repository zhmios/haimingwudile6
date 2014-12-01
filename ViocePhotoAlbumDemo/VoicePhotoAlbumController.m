//
//  VoicePhotoAlbumController.m
//  ViocePhotoAlbumDemo
//
//  Created by zhm on 14/11/25.
//  Copyright (c) 2014年 zhm. All rights reserved.
//

#import "VoicePhotoAlbumController.h"
#import "UIImageView+UIActivityIndicatorForSDWebImage.h"
#import "UIImageView+ProgressView.h"
#import "SoundRecorder.h"
#import <AVOSCloud/AVOSCloud.h>
@interface VoicePhotoAlbumController ()<SoundRecorderDelegate>
@property (nonatomic, strong) SoundRecorder *recorder;
@end

@implementation VoicePhotoAlbumController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   [self.largeImageView setImageWithURL:[NSURL URLWithString:@"http://img0.bdstatic.com/img/image/shouye/mxym-9447375568.jpg"] usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [self createSoundRecorder];
 
}
- (void)createSoundRecorder{
    self.recorder = [[SoundRecorder alloc]init];
    self.recorder.delegate = self;

}

- (IBAction)recordBtnPress:(id)sender {
    
    [self.recorder beginRecord];
    [self.recordingBtn setTitle:@"正在录音" forState:UIControlStateNormal];
    self.recordingBtn.enabled = NO;
    
}

- (IBAction)localPlayBtnPress:(id)sender {
    [self.recorder stopRecord];
    [self.recordingBtn setTitle:@"录音" forState:UIControlStateNormal];
    self.recordingBtn.enabled = YES;
    [self.recorder localPlay];
    [self.playingBtn setTitle:@"正在播放" forState:UIControlStateNormal];
   
    
}
- (IBAction)stopRecordBtnPress:(id)sender {
    self.recordingBtn.enabled = YES;
    [self.recorder stopRecord];
    [self.recordingBtn setTitle:@"录音" forState:UIControlStateNormal];
}
- (void)changStatus{
    
    [self.playingBtn setTitle:@"播放" forState:UIControlStateNormal];


}

- (IBAction)uploadBtnPress:(id)sender {
    
    [self uploadData];
    
}
- (void)uploadData{

    AVFile *soundFile = [AVFile fileWithName:[NSString stringWithFormat:@"%@.aac",self.recorder.fileName] contentsAtPath:self.recorder.filePath];
    if (soundFile) {
        

    [soundFile saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
       
        if (succeeded) {
            
            NSLog(@"文件上传成功");
        }else{
        
            NSLog(@"文件上传失败");
        }
        
    }];
    }
    
    NSData *largeImageData = UIImageJPEGRepresentation(self.largeImageView.image, 1);
    NSData *headImageData = UIImageJPEGRepresentation([UIImage imageNamed:@"2.png"], 1);
    AVFile *largeimageFile = [self uploadFile:@"largeImage.png" with:largeImageData];
    AVFile *headImageFile = [self uploadFile:@"headImage.png" with:headImageData];
    AVUser *user = [AVUser user];
    user.username = @"明哥";
    user.password = @"1";
    [user setObject:soundFile forKey:@"soundFile"];
    [user setObject:largeimageFile forKey:@"largeImage"];
    [user setObject:headImageFile forKey:@"headImage"];
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
       
        if (succeeded) {
            
            NSLog(@"创建用户成功");
        }else{
        
            NSLog(@"创建用户失败");
        }
        
    }];


}
- (AVFile *)uploadFile:(NSString *)fileName with:(NSData *)data{
    
    AVFile *file = [AVFile fileWithName:fileName data:data];
    [file saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            
            NSLog(@"文件上传成功");
            
        }else{
        
            NSLog(@"文件上传失败");
        }
        
    }];

    return file;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
