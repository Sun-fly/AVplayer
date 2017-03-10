//
//  ZHOUOneViewController.h
//  音频视频播放器
//
//  Created by 周亚-Sun on 2017/3/9.
//  Copyright © 2017年 zhouya. All rights reserved.
//音频

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>//播放系统声音需导入
#import <AVFoundation/AVFoundation.h>
@interface ZHOUOneViewController : UIViewController
{
    SystemSoundID systemSound;
    AVAudioPlayer *audioPlayer;
}
/** 音乐播放器*/
@property(strong,nonatomic)AVAudioPlayer *audioPlayer;
@end
