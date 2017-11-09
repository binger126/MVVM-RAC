//
//  SVProgressHUDExtension.m
//  UnitaSinceMedia
//
//  Created by LongXi-Hua on 16/6/27.
//  Copyright © 2016年 UnitaCreate. All rights reserved.
//

#import "SVProgressHUDExtension.h"


@implementation SVProgressHUDExtension

+ (void)showWithStatus:(NSString*)status dimBackground:(BOOL)dimBackground
{
    if (dimBackground) {
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    }
    [self setupCustomSetting];
    [SVProgressHUD showWithStatus:status];
}

+ (void)showProgress:(float)progress dimBackground:(BOOL)dimBackground
{
    if (dimBackground) {
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    }
    [self setupCustomSetting];
    [SVProgressHUD showProgress:progress];
}

+ (void)showImage:(UIImage*)image status:(NSString*)status dimBackground:(BOOL)dimBackground
{
    if (dimBackground) {
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    }
    [self setupCustomSetting];
    [SVProgressHUD showImage:image status:status];
}

+ (void)showSuccessWithStatus:(NSString*)status dimBackground:(BOOL)dimBackground
{
    if (dimBackground) {
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    }
    [self setupCustomSetting];
    [SVProgressHUD setSuccessImage:[UIImage imageNamed:@"icon_success"]];
    [SVProgressHUD showSuccessWithStatus:status];
}

+ (void)showErrorWithStatus:(NSString*)status dimBackground:(BOOL)dimBackground
{
    if (dimBackground) {
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    }
    [self setupCustomSetting];
    [SVProgressHUD setErrorImage:[UIImage imageNamed:@"icon_error"]];
    [SVProgressHUD showErrorWithStatus:status];
}

+ (void)dismiss
{
    [SVProgressHUD dismiss];
}

+ (void)dismissWithDelay:(NSTimeInterval)delay
{
    [SVProgressHUD dismissWithDelay:delay];
}

+(void)setupCustomSetting
{
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
    [SVProgressHUD setBackgroundLayerColor:[[UIColor lightGrayColor] colorWithAlphaComponent:0.3]];
    [SVProgressHUD setForegroundColor:RGB(113, 222, 187)];
    [SVProgressHUD setBackgroundColor:[UIColor whiteColor]];
    [SVProgressHUD setFadeInAnimationDuration:0.5];
    [SVProgressHUD setRingThickness:1.0f];
    [SVProgressHUD setMinimumDismissTimeInterval:3];
}

@end
