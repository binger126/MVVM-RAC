//
//  CommonAlertController.h
//  DesignClothing
//
//  Created by WebUser on 2017/10/30.
//  Copyright © 2017年 yswl. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SureClick)(void);

@interface CommonAlertController : UIViewController

@property(nonatomic) NSTextAlignment textAlignment;

+ (CommonAlertController *)showAlertWithSuperController:(UIViewController *)superController title:(NSString *)title message:(NSString *)message click:(SureClick)click;

@end
