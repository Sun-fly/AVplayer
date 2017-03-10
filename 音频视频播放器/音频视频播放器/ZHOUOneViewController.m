//
//  ZHOUOneViewController.m
//  音频视频播放器
//
//  Created by 周亚-Sun on 2017/3/9.
//  Copyright © 2017年 zhouya. All rights reserved.
//

#import "ZHOUOneViewController.h"
#import <Masonry.h>
@interface ZHOUOneViewController ()
/** 播放音乐 */
@property(strong,nonatomic)UIButton *playMusicButton;
/** 停止音乐 */
@property(strong,nonatomic)UIButton *stopMusicButton;

/** 播放系统声音 */
@property(strong,nonatomic)UIButton *playsystemButton;
@end

@implementation ZHOUOneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor lightGrayColor];
    
     [self addUI];
    
}
- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    [self customUI];
}


///添加UI控件
-(void)addUI{
    
    UIButton *playMusicButton=[[UIButton alloc]init];
    [playMusicButton setTitle:@"播放音乐" forState:UIControlStateNormal];
    [playMusicButton setBackgroundColor:[UIColor whiteColor]];
    playMusicButton.layer.cornerRadius=20;
    [playMusicButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [playMusicButton addTarget:self action:@selector(playMsusic:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:playMusicButton];
    
    UIButton *stopMusicButton=[[UIButton alloc]init];
    [stopMusicButton setTitle:@"停止音乐" forState:UIControlStateNormal];
    [stopMusicButton setBackgroundColor:[UIColor whiteColor]];
    stopMusicButton.layer.cornerRadius=20;
    [stopMusicButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [stopMusicButton addTarget:self action:@selector(stopMusic:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:stopMusicButton];
    
    UIButton *playsystemButton=[[UIButton alloc]init];
    [playsystemButton setTitle:@"播系统声音" forState:UIControlStateNormal];
    [playsystemButton setBackgroundColor:[UIColor whiteColor]];
    playsystemButton.layer.cornerRadius=20;
    [playsystemButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [playsystemButton addTarget:self action:@selector(playsystem:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:playsystemButton];
    
    self.playMusicButton=playMusicButton;
    self.playsystemButton=playsystemButton;
    self.stopMusicButton=stopMusicButton;
}
    
///设置子控件的frame
-(void)customUI{
    
    [self.stopMusicButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.offset(100);
        make.height.offset(40);
         make.centerY.equalTo(self.view.mas_centerY).offset(-200);
        make.centerX.equalTo(self.view.mas_centerX);
    }];
    
    [self.playMusicButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.offset(100);
        make.height.offset(40);
        make.right.equalTo(self.stopMusicButton.mas_left).offset(-20);
        make.centerY.equalTo(self.stopMusicButton.mas_centerY);
    }];
    
    [self.playsystemButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.offset(100);
        make.height.offset(40);
        make.left.equalTo(self.stopMusicButton.mas_right).offset(20);
        make.centerY.equalTo(self.stopMusicButton.mas_centerY);
    }];
    
    
    
}
-(AVAudioPlayer *)audioPlayer{
    NSError *error;
    //大管家
    AVAudioSession *session=[AVAudioSession sharedInstance];
    [session setCategory:AVAudioSessionCategoryPlayback withOptions:AVAudioSessionCategoryOptionDefaultToSpeaker error:&error];
    if (error) {
        NSLog(@"fault--%@",error);
    }
    [session setActive:YES error:&error];
    
    //创建一个本地文件
    NSString *path=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
    NSString *filePath=[NSString stringWithFormat:@"%@/186947.mp3",path];
    //获取原文件，并生成audioData
    NSString * path1=[[NSBundle mainBundle]pathForResource:@"186947" ofType:@"mp3"];
    NSURL *dataPath=[NSURL fileURLWithPath:path1];
    NSData *audioData=[NSData dataWithContentsOfURL:dataPath];
    //将原文件写入本地文件
    [audioData writeToFile:filePath atomically:YES];
    
    //播放器从本地文件中获取原文件，进行播放
    NSURL *url=[NSURL fileURLWithPath:filePath];
    audioPlayer=[[AVAudioPlayer alloc]initWithContentsOfURL:url error:&error];
    self.audioPlayer=audioPlayer;
    return _audioPlayer;
}
#pragma mark -
#pragma mark--按钮事件
///播放音乐事件
-(void)playMsusic:(UIButton *)sender{
    NSLog(@"播放音乐");
    [self.audioPlayer prepareToPlay];
    [self.audioPlayer play];
    
}
///停止播放音乐事件
-(void)stopMusic:(UIButton *)sender{
    [audioPlayer stop];
}


///播系统声音事件
-(void)playsystem:(UIButton *)sender{
    NSLog(@"播放系统声音");
    //声音文件类型要求：不超过30秒，格式为三种：caf aif wav;需导入框架 AudioToolbox.framework
    
    NSString *path=[[NSBundle mainBundle]pathForResource:@"tap" ofType:@"aif"];
    NSURL *url=[NSURL fileURLWithPath:path];
    //注册这个声音文件为系统声音文件
    OSStatus err=AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(url), &systemSound);
    if (err) {
        NSLog(@"注册系统声音文件失败！");
    }
    AudioServicesPlaySystemSound(systemSound);//播放这个系统声音文件
  
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
