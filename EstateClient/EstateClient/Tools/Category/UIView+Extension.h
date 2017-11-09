//
//  UIView+Extension.h
//  VictorOC
//
//  Created by WebUser on 17/3/1.
//  Copyright © 2017年 tcbwork. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *  弹框布局
 */
typedef NS_ENUM(NSInteger, AlertStyle) {
    /**
     *  性别
     */
    kSexStyle,
    /**
     *  相片
     */
    kPhotoStyle
};
/**
 *  View的角
 */
typedef NS_ENUM(NSInteger, SMBSide) {
    /**
     *  左边的角
     */
    kSMBSideLeft,
    /**
     *  右边的角
     */
    kSMBSideRight,
    /**
     *  上边的角
     */
    kSMBSideUp,
    /**
     *  下边的角
     */
    kSMBSideDown
};
/**
 *  线的类型
 */
typedef NS_ENUM(NSInteger, LineCapType) {
    /**
     *  对接
     */
    LineCapButt,
    /**
     *  圆形
     */
    LineCapRound,
    /**
     *  广场
     */
    LineCapSquare
};
@interface UIView (Extension)

@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize size;

/**
 * 自定义 切视图圆角 kSMBSideLeft，kSMBSideRight，kSMBSideUp，kSMBSideDown
 */
- (void)roundSide:(SMBSide)side cornerRadii:(CGSize)size;
/**
 * 自定义 延视图边缘添加虚线
 */
- (void)addLayerDottedLineWithView:(UIView *)view withColor:(UIColor *)color withWidth:(CGFloat)width withLineCap:(LineCapType)lineCap;
//获得屏幕图像,原图尺寸
+ (UIImage *)imageFromView:(UIView *)theView;
//获得屏幕图像,自定义尺寸
+ (UIImage *)imageFromView:(UIView *)theView size:(CGSize)size;
//将UIView指定区域转换成图片
+(UIImage *)imageFromView:(UIView *)v rect:(CGRect)rect;

@end
