//
//  SVProgressHUDExtension.h
//  UnitaSinceMedia
//
//  Created by LongXi-Hua on 16/6/27.
//  Copyright © 2016年 UnitaCreate. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SVProgressHUD.h"

@interface SVProgressHUDExtension : NSObject

+ (void)showWithStatus:(NSString*)status dimBackground:(BOOL)dimBackground;
+ (void)showProgress:(float)progress dimBackground:(BOOL)dimBackground;
+ (void)showImage:(UIImage*)image status:(NSString*)status dimBackground:(BOOL)dimBackground;

+ (void)showSuccessWithStatus:(NSString*)status dimBackground:(BOOL)dimBackground;
+ (void)showErrorWithStatus:(NSString*)status dimBackground:(BOOL)dimBackground;

+ (void)dismiss;
+ (void)dismissWithDelay:(NSTimeInterval)delay;


@end
