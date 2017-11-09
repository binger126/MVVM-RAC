//
//  UILabel+Extension.h
//  ezd
//
//  Created by WebUser on 17/5/22.
//  Copyright © 2017年 tigo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Extension)

//如果两个方法同时使用需要保证可变字符串的统一性
/**
 *  改变字体大小颜色
 */
- (NSMutableAttributedString *)getAttributeSizeWithAllText:(NSString *)allText changeText:(NSString *)changeText changeTextColor:(UIColor *)changeTextColor changeTextCGFloat:(CGFloat)changeTextCGFloat;
//设置缩进、行距
- (NSMutableAttributedString *)setTextAttributedString:(NSString *)string textInsets:(CGFloat)textInsets isAllIndented:(BOOL)isIndented;

@end
