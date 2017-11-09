//
//  UILabel+Extension.m
//  ezd
//
//  Created by WebUser on 17/5/22.
//  Copyright © 2017年 tigo. All rights reserved.
//

#import "UILabel+Extension.h"

@implementation UILabel (Extension)

- (NSMutableAttributedString *)getAttributeSizeWithAllText:(NSString *)allText changeText:(NSString *)changeText changeTextColor:(UIColor *)changeTextColor changeTextCGFloat:(CGFloat)changeTextCGFloat
{
    NSMutableAttributedString *attributeSting = [[NSMutableAttributedString alloc] initWithString:allText];
    NSRange changeRange = NSMakeRange([[attributeSting string] rangeOfString:changeText].location, [[attributeSting string] rangeOfString:changeText].length);
    //需要设置的位置
    [attributeSting addAttribute:NSForegroundColorAttributeName value:changeTextColor range:changeRange];
    [attributeSting addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:changeTextCGFloat] range:changeRange];
    return attributeSting;
}

- (NSMutableAttributedString *)setTextAttributedString:(NSString *)string textInsets:(CGFloat)textInsets isAllIndented:(BOOL)isIndented {
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:string];
    //设置缩进、行距
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    if (isIndented) {//多行缩进
        style.headIndent = textInsets;//缩进
    }else{//首行缩进
        style.headIndent = 0;//缩进
    }
    style.firstLineHeadIndent = textInsets;
    [text addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, text.length)];
    return text;
}



@end
