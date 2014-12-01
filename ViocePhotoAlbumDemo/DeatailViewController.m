//
//  DeatailViewController.m
//  ViocePhotoAlbumDemo
//
//  Created by zhm on 14/11/25.
//  Copyright (c) 2014年 zhm. All rights reserved.
//

#import "DeatailViewController.h"
#import "UIImageView+UIActivityIndicatorForSDWebImage.h"
#import <AVOSCloud/AVOSCloud.h>
@interface DeatailViewController ()
@property (nonatomic, retain)AVFile *largeImageFile;
@property (nonatomic, retain)AVFile *headImageFile;
@property (nonatomic, retain)AVFile *soundFile;
@property (nonatomic, retain)SoundPlayer *player;

@end

@implementation DeatailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self fillData];
    [self createPlayer];
    // Do any additional setup after loading the view.
}
- (void)fillData{

    AVUser *user = [AVUser currentUser];
    self.largeImageFile = [user objectForKey:@"largeImage"];
    self.headImageFile = [user objectForKey:@"headImage"];
    self.soundFile = [user objectForKey:@"soundFile"];
    
    [self.largeImageView setImageWithURL:[NSURL URLWithString:self.largeImageFile.url] usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [self.userimageView setImageWithURL:[NSURL URLWithString:self.headImageFile.url] usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.userNameLabel.text = user.username;

}
- (void)createPlayer{
//    self.player = [[SoundPlayer alloc]initPlayUrl:@"http://mr4.douban.com/201411241435/2e63df8351f0c387475d2420ea6a12d8/view/song/small/p988953.mp4"];
    self.player = [[SoundPlayer alloc]init];
    [self.player makePlayer:@"http://mr4.douban.com/201411241435/2e63df8351f0c387475d2420ea6a12d8/view/song/small/p988953.mp4"];
    self.player.delegate = self;


}
- (void)changStatus:(DOUAudioStreamerStatus)status{




}
- (IBAction)playBtnPress:(id)sender {
    
    [self.player play];
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
