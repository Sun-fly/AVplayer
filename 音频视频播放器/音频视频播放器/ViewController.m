//
//  ViewController.m
//  音频视频播放器
//
//  Created by 周亚-Sun on 2017/3/9.
//  Copyright © 2017年 zhouya. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end
#define UIScreenW self.view.frame.size.width
#define UIScreenH self.view.frame.size.height

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    
    [self setupScrollView];
    
    [self setupTitlesView];
    
    [self setupChildVcs];
    
    
}
///创建滑动视图
-(void)setupScrollView{
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = self.view.bounds;
    scrollView.pagingEnabled = YES;
    scrollView.delegate = self;
    scrollView.bounces=NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.backgroundColor = [UIColor colorWithRed:(arc4random_uniform(256)) / 255.0 green:(arc4random_uniform(256)) / 255.0 blue:(arc4random_uniform(256)) / 255.0 alpha:1];
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
}
/// 标题栏
-(void)setupTitlesView{
    UIView *titlesView = [[UIView alloc] init];
    titlesView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
    titlesView.frame = CGRectMake(0, 64, UIScreenW, 50);
    [self.view addSubview:titlesView];
    self.titlesView = titlesView;
    
    // 标题按钮
    [self setupTitleButtons];
    
    // 下划线
    [self setupUnderline];
}
///标题的按钮
-(void)setupTitleButtons{
    // 文字
    NSArray *titles = @[@"音频", @"视频", @"录音"];
    NSUInteger count = titles.count;
    
    // 标题的宽高
    CGFloat titleW = self.titlesView.width / count;
    CGFloat titleH = self.titlesView.height;
    
    for (NSUInteger i = 0; i < count; i++) {
        // 创建添加
        ZHOUTitleButton *titleButton = [ZHOUTitleButton buttonWithType:UIButtonTypeCustom];
        titleButton.tag = i;
        [titleButton addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.titlesView addSubview:titleButton];
        
        // frame
        CGFloat titleX = titleW * i;
        titleButton.frame = CGRectMake(titleX, 0, titleW, titleH);
        
        // 数据
        [titleButton setTitle:titles[i] forState:UIControlStateNormal];
        
    }
}
 /// 初始化子控制器
-(void)setupChildVcs{
    ZHOUOneViewController *one=[[ZHOUOneViewController alloc]init];
    
    ZHOUTwoViewController *two=[[ZHOUTwoViewController alloc]init];
    
    ZHOUThreeViewController *three=[[ZHOUThreeViewController alloc]init];
    
    [self addChildViewController:one];
    [self addChildViewController:two];
    [self addChildViewController:three];
    
    // 内容大小
    self.scrollView.contentSize = CGSizeMake(self.childViewControllers.count * self.scrollView.width, 0);
    // 不要自动调整scrollView的内边距
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    // 默认添加第0个子控制器view到scrollView
    [self addChildVcViewIntoScrollView:0];
    
    
}



///下划线
-(void)setupUnderline{
    // 第一个按钮
    ZHOUTitleButton *firstTitleButton = self.titlesView.subviews.firstObject;
    
    // 下划线
    UIView *underline = [[UIView alloc] init];
    underline.backgroundColor = [firstTitleButton titleColorForState:UIControlStateSelected];
    underline.height = 2;
    underline.y = self.titlesView.height - underline.height;
    [self.titlesView addSubview:underline];
    self.underline = underline;
    
    // 默认选中第一个按钮
    // 改变按钮状态
    firstTitleButton.selected = YES; // UIControlStateSelected
    self.clickedTitleButton = firstTitleButton;
    
    [firstTitleButton.titleLabel sizeToFit]; // 主动根据文字内容计算按钮内部label的大小
    // 下划线宽度 == 按钮内部文字的宽度
    underline.width = firstTitleButton.titleLabel.width + 50;
    // 下划线中心点x
    underline.centerX = firstTitleButton.centerX;
}
//按钮点击事件
-(void)titleClick:(ZHOUTitleButton *)titleButton{
    // 改变按钮状态
    self.clickedTitleButton.selected = NO; // UIControlStateNormal
    titleButton.selected = YES; // UIControlStateSelected
    self.clickedTitleButton = titleButton;
    
    // 按钮的索引
    NSInteger index = titleButton.tag;
    
    // 移动下划线
    [UIView animateWithDuration:0.25 animations:^{
        // 宽度 == 按钮内部文字的宽度
        self.underline.width = titleButton.titleLabel.width + 50;
        
        // 中心点x
        self.underline.centerX = titleButton.centerX;
        
        // 滚动scrollView到最新的子控制器界面(这里只需要水平滚动, 只改contentOffset.x)
        CGPoint offset = self.scrollView.contentOffset;
        offset.x = index * self.scrollView.width;
        self.scrollView.contentOffset = offset;
    } completion:^(BOOL finished) { // 滚动动画完毕
        // 添加对应的子控制器view到scrollView上面
        [self addChildVcViewIntoScrollView:index];
    }];
    
}
#pragma mark - <UIScrollViewDelegate>
/**
 * scrollView停止滚动的时候调用(结束减速,速度减为0)
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSUInteger index = scrollView.contentOffset.x / scrollView.width;
    // 点击对应的按钮
    ZHOUTitleButton *titleButton = self.titlesView.subviews[index];
    [self titleClick:titleButton];
}

#pragma mark - 其他
/**
 *  添加第index个子控制器view到scrollView中
 */
- (void)addChildVcViewIntoScrollView:(NSInteger)index {
    // 添加对应的子控制器view到scrollView上面
    UIViewController *childVc = self.childViewControllers[index];
    
    // 如果这个子控制器view已经显示在上面, 就直接返回
    if (childVc.view.superview) return;
    
    [self.scrollView addSubview:childVc.view];
    
    // 子控制器view的frame
    childVc.view.x = index * self.scrollView.width;
    childVc.view.y = 0;
    childVc.view.width = self.scrollView.width;
    childVc.view.height = self.scrollView.height;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
