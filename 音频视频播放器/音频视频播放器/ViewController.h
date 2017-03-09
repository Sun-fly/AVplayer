//
//  ViewController.h
//  音频视频播放器
//
//  Created by 周亚-Sun on 2017/3/9.
//  Copyright © 2017年 zhouya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZHOUTitleButton.h"
#import "UIView+Extension.h"

#import "ZHOUOneViewController.h"
#import "ZHOUTwoViewController.h"
#import "ZHOUThreeViewController.h"
@interface ViewController : UIViewController<UIScrollViewDelegate>

/** 标题栏 */
@property (nonatomic, weak) UIView *titlesView;
/** 用来存放所有子控制器view的scrollView */
@property (nonatomic, weak) UIScrollView *scrollView;
/** 下划线 */
@property (nonatomic, weak) UIView *underline;
/** 被点击的按钮 */
@property (nonatomic, weak)ZHOUTitleButton *clickedTitleButton;
@end

