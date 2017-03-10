//
//  ZHOUThreeViewController.h
//  音频视频播放器
//
//  Created by 周亚-Sun on 2017/3/9.
//  Copyright © 2017年 zhouya. All rights reserved.
//录音

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
@interface ZHOUThreeViewController : UIViewController
{
    AVAudioPlayer *player;//播放器
    AVAudioRecorder *recoder;//录音器
}
@end
