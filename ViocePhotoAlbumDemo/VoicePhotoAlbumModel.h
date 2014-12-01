//
//  VoicePhotoAlbumModel.h
//  MyPlayerDemo
//
//  Created by zhm on 14/11/24.
//  Copyright (c) 2014年 zhm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DOUAudioFile.h"
@interface VoicePhotoAlbumModel : NSObject<DOUAudioFile>


@property (nonatomic, strong) NSString *artist;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSURL *audioFileURL;
@end
