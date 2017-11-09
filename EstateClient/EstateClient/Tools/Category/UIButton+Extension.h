//
//  UIButton+Extension.h
//  DesignClothing
//
//  Created by WebUser on 2017/10/20.
//  Copyright © 2017年 yswl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Extension)


#pragma mark - 上下图文
- (void)verticalImageAndTitle:(CGFloat)spacing fontSize:(CGFloat)fontSize;

//背景色
- (void)setTheCountdownStartWithTime:(NSInteger)timeLine title:(NSString *)title countDownTitle:(NSString *)subTitle mainColor:(UIColor *)mColor countColor:(UIColor *)color;
//背景图片
- (void)setTheCountdownStartWithTime:(NSInteger)timeLine title:(NSString *)title countDownTitle:(NSString *)subTitle mainBackgroundImage:(NSString *)mainImageName countBackgroundImage:(NSString *)countImageName;

@end
