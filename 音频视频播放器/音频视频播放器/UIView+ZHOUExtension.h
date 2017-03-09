//
//  UIView+ZHOUExtension.h
//  音频视频播放器
//
//  Created by 周亚-Sun on 2017/3/9.
//  Copyright © 2017年 zhouya. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (ZHOUExtension)

@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGPoint origin;

-(NSString *)getNametag;

-(void)setNametag:(NSString *)theNametag;

-(UIView *)viewNamed:(NSString *)aName;

@end
