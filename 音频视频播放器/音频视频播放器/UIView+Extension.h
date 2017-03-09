//
//  UIView+Extension.h
//  scrollView
//
//  Created by 周亚-Sun on 2016/12/13.
//  Copyright © 2016年 zhouya. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Extension)

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
