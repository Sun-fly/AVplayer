//
//  ZHOUTitleButton.m
//  音频视频播放器
//
//  Created by 周亚-Sun on 2017/3/9.
//  Copyright © 2017年 zhouya. All rights reserved.
//

#import "ZHOUTitleButton.h"

@implementation ZHOUTitleButton

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.titleLabel.font = [UIFont systemFontOfSize:18];
        [self setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    }
    return self;
}


@end
