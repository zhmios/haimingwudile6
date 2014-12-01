//
//  DeatailViewController.h
//  ViocePhotoAlbumDemo
//
//  Created by zhm on 14/11/25.
//  Copyright (c) 2014年 zhm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SoundPlayer.h"
@interface DeatailViewController : UIViewController<SoundPlayerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *largeImageView;

@property (weak, nonatomic) IBOutlet UIImageView *userimageView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;

@property (weak, nonatomic) IBOutlet UIButton *playBtn;

@end
