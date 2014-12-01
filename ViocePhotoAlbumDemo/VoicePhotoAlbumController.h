//
//  VoicePhotoAlbumController.h
//  ViocePhotoAlbumDemo
//
//  Created by zhm on 14/11/25.
//  Copyright (c) 2014年 zhm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VoicePhotoAlbumController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *largeImageView;
@property (weak, nonatomic) IBOutlet UIButton *recordingBtn;
@property (weak, nonatomic) IBOutlet UIButton *playingBtn;

@property (weak, nonatomic) IBOutlet UIButton *uploadBtn;
@end
