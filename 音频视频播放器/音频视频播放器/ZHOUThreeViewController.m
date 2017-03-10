//
//  ZHOUThreeViewController.m
//  音频视频播放器
//
//  Created by 周亚-Sun on 2017/3/9.
//  Copyright © 2017年 zhouya. All rights reserved.
//

#import "ZHOUThreeViewController.h"
#import <Masonry.h>




@interface ZHOUThreeViewController ()

/** 开始录音按钮 */
@property(strong,nonatomic)UIButton *startButton;
/** 停止录音按钮 */
@property(strong,nonatomic)UIButton *stopButton;
/** 播放录音按钮 */
@property(strong,nonatomic)UIButton *playButton;
/** 状态显示标签 */
@property(strong,nonatomic)UILabel *showLabel;
/** 录音机的配置  */
@property(strong,nonatomic)NSMutableDictionary *setting;

@end

@implementation ZHOUThreeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor grayColor];
    
    self.setting=[[NSMutableDictionary alloc]init];
   NSError *error;
    /*
    //大管家
    AVAudioSession *session=[AVAudioSession sharedInstance];
    
    //设置为播放和录音状态
    [session setCategory:AVAudioSessionCategoryRecord withOptions:AVAudioSessionCategoryOptionDefaultToSpeaker error:&error];
    [session setActive:YES error:&error];
    //设置扬声器模式
    [session overrideOutputAudioPort:AVAudioSessionPortOverrideSpeaker error:&error];
    if (error) {
        NSLog(@"扬声器模式出错--%@",error);
    }
    */
    
    
    //构建录音机
    
    recoder=[[AVAudioRecorder alloc]initWithURL:[self Path] settings:self.setting error:&error];
    if (error) {
        NSLog(@"录音%@",error);
    }
    
    //构建播放器
    player=[[AVAudioPlayer alloc]initWithContentsOfURL:[self Path] error:&error];
    if (error) {
        NSLog(@"播放%@",error);
    }
    
    [self addUI];
    
}
-(NSMutableDictionary *)setting{
    [_setting setObject:[NSNumber numberWithFloat:44100.0] forKey:AVSampleRateKey];//采样的频率
    [_setting setObject:[NSNumber numberWithInt:2] forKey:AVNumberOfChannelsKey];//声道数
    [_setting setObject:[NSNumber numberWithInt:16] forKey:AVLinearPCMBitDepthKey];//采样位数
    [_setting setObject:[NSNumber numberWithInt:AVAudioQualityHigh] forKey:AVEncoderAudioQualityKey];//录音质量
    return _setting;
}
///获取录音机的URL
-(NSURL *)Path{
    NSString *path=NSHomeDirectory();
    path=[path stringByAppendingPathComponent:@"rec.caf"];
    return [NSURL URLWithString:path];
}
- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    [self customUI];
}

///添加UI控件
-(void)addUI{
    
    UIButton *stopButton=[[UIButton alloc]init];
    [stopButton setTitle:@"停止录音" forState:UIControlStateNormal];
    [stopButton setBackgroundColor:[UIColor whiteColor]];
    stopButton.layer.cornerRadius=20;
    [stopButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [stopButton addTarget:self action:@selector(stop:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:stopButton];
    
    UIButton *startButton=[[UIButton alloc]init];
    [startButton setTitle:@"开始录音" forState:UIControlStateNormal];
    [startButton setBackgroundColor:[UIColor whiteColor]];
    startButton.layer.cornerRadius=20;
    [startButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [startButton addTarget:self action:@selector(start:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:startButton];
    
    UIButton *playButton=[[UIButton alloc]init];
    [playButton setTitle:@"播放录音" forState:UIControlStateNormal];
    [playButton setBackgroundColor:[UIColor whiteColor]];
    playButton.layer.cornerRadius=20;
    [playButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [playButton addTarget:self action:@selector(playTap:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:playButton];
    
    UILabel *showLabel=[[UILabel alloc]init];
    showLabel.textColor=[UIColor redColor];
    showLabel.textAlignment=NSTextAlignmentCenter;
    showLabel.backgroundColor=[UIColor yellowColor];
    [self.view addSubview:showLabel];
    
    self.stopButton=stopButton;
    self.startButton=startButton;
    self.playButton=playButton;
    self.showLabel=showLabel;

}

///设置子控件的frame
-(void)customUI{
    
    [self.stopButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.offset(100);
        make.height.offset(40);
        make.centerY.equalTo(self.view.mas_centerY).offset(-200);
        make.centerX.equalTo(self.view.mas_centerX);
    }];
    
    [self.startButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.offset(100);
        make.height.offset(40);
        make.right.equalTo(self.stopButton.mas_left).offset(-20);
        make.centerY.equalTo(self.stopButton.mas_centerY);
    }];

    [self.playButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.offset(100);
        make.height.offset(40);
        make.left.equalTo(self.stopButton.mas_right).offset(20);
        make.centerY.equalTo(self.stopButton.mas_centerY);
    }];
    
    [self.showLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.offset(80);
        make.left.equalTo(self.startButton.mas_left);
        make.right.equalTo(self.playButton.mas_right);
        make.top.equalTo(self.stopButton.mas_bottom).offset(30);
    }];
    
}
#pragma mark -
#pragma mark--按钮事件
///停止录音事件
-(void)stop:(UIButton *)sender{
    
    [recoder stop];
    self.showLabel.text=@"停止录音";
}

///开始录音事件
-(void)start:(UIButton *)sender{
    
    [recoder record];
    self.showLabel.text=@"开始录音";
}

///播放录音事件
-(void)playTap:(UIButton *)sender{
    
    [player play];
    self.showLabel.text=@"播放录音";
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
