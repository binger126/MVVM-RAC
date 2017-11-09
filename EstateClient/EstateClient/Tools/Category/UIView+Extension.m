//
//  UIView+Extension.m
//  VictorOC
//
//  Created by WebUser on 17/3/1.
//  Copyright © 2017年 tcbwork. All rights reserved.
//

#import "UIView+Extension.h"

@implementation UIView (Extension)



- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

- (void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerX
{
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)centerY
{
    return self.center.y;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (void)setSize:(CGSize)size
{
    //    self.width = size.width;
    //    self.height = size.height;
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size
{
    return self.frame.size;
}


- (void)roundSide:(SMBSide)side cornerRadii:(CGSize)size
{
    UIBezierPath *maskPath;
    
    if (side == kSMBSideLeft) {
        maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                         byRoundingCorners:(UIRectCornerTopLeft|UIRectCornerBottomLeft)
                                               cornerRadii:size];
    } else if (side == kSMBSideRight) {
        maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                         byRoundingCorners:(UIRectCornerTopRight|UIRectCornerBottomRight)
                                               cornerRadii:size];
    } else if (side == kSMBSideUp) {
        maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                         byRoundingCorners:(UIRectCornerTopLeft|UIRectCornerTopRight)
                                               cornerRadii:size];
    } else {
        maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                         byRoundingCorners:(UIRectCornerBottomLeft|UIRectCornerBottomRight)
                                               cornerRadii:size];
    }
    // Create the shape layer and set its path
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    
    // Set the newly created shape layer as the mask for the image view's layer
    self.layer.mask = maskLayer;
    
    [self.layer setMasksToBounds:YES];
}


- (void)addLayerDottedLineWithView:(UIView *)view withColor:(UIColor *)color withWidth:(CGFloat)width withLineCap:(LineCapType)lineCap;
{
    /* 初始化一个layer */
    CAShapeLayer *border = [CAShapeLayer layer];
    /* 虚线的颜色 */
    border.strokeColor = color.CGColor;
    /* 填充虚线内的颜色 */
    border.fillColor = nil;
    /* 贝塞尔曲线路径 */
    border.path = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, view.frame.size.width, view.frame.size.height)].CGPath;
    /* 虚线宽度 */
    border.lineWidth = width;
    //border.frame = view.bounds; /* 这个因为给了路径, 而且用的约束给的控件尺寸, 所以没什么效果 */
    /* 官方API注释:The cap style used when stroking the path. Options are 'butt', 'round' and 'square'. Defaults to 'butt'. */
    /* 意思是沿路径画帽时的样式 有三种 butt ; round; square ,我没感觉有啥区别 可以自己试一下*/
    switch (lineCap) {
        case LineCapSquare:
            border.lineCap = @"square";
            break;
        case LineCapRound:
            border.lineCap = @"round";
            break;
        case LineCapButt:
            border.lineCap = @"butt";
            break;
        default:
            border.lineCap = @"butt";
            break;
    }
    /* 虚线的每个点长  和 两个点之间的空隙 */
    border.lineDashPattern = @[@3, @2];
    /* 添加到你的控件上 */
    [view.layer addSublayer:border];
}

//获得屏幕图像
+ (UIImage *)imageFromView:(UIView *)theView {
    CGSize size = theView.bounds.size;
//    下面方法，第一个参数表示区域大小。第二个参数表示是否是非透明的。
//    如果需要显示半透明效果，需要传NO，否则传YES。第三个参数就是屏幕密度了
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    [theView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
+ (UIImage *)imageFromView:(UIView *)theView size:(CGSize)size {
    CGSize theViewSize = theView.bounds.size;
    UIGraphicsBeginImageContextWithOptions(theViewSize, NO, [UIScreen mainScreen].scale);
    [theView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    return scaledImage;
}

//将UIView指定区域转换成图片
+(UIImage *)imageFromView:(UIView *)v rect:(CGRect)rect{
    UIGraphicsBeginImageContextWithOptions(v.frame.size, NO, 1.0);  //NO，YES 控制是否透明
    [v.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    CGRect myImageRect = rect;
    CGImageRef imageRef = image.CGImage;
    CGImageRef subImageRef = CGImageCreateWithImageInRect(imageRef,myImageRect);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawImage(context, myImageRect, subImageRef);
    UIImage* smallImage = [UIImage imageWithCGImage:subImageRef];
    CGImageRelease(subImageRef);
    UIGraphicsEndImageContext();
    return smallImage;
}
@end
