//
//  UIViewController+Toast.h
//  EstateBrokerage
//
//  Created by Victor on 17/1/4.
//  Copyright © 2017年 Tigo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TCBProgressHUD.h"

@interface UIViewController (Toast)

- (void)showHudInView:(UIView *)view hint:(NSString *)hint;

- (void)hideHud;

- (void)showHint:(NSString *)hint;

- (void)showHint:(NSString *)hint yOffset:(float)yOffset;

@end
