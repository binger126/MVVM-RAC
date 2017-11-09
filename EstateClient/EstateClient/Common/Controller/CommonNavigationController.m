//
//  CommonNavigationController.m
//  EstateClient
//
//  Created by WebUser on 2017/11/3.
//  Copyright © 2017年 tigo. All rights reserved.
//

#import "CommonNavigationController.h"

@interface CommonNavigationController ()

@end

@implementation CommonNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //设置导航栏图标颜色
    [[UINavigationBar appearance] setTintColor:[UIColor blackColor]];
    //隐藏返回按钮文字
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(-kScreenWidth, 0) forBarMetrics:UIBarMetricsDefault];
    //设置标题颜色
    [[UINavigationBar appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys: [UIColor blackColor], NSForegroundColorAttributeName, nav_text_font, NSFontAttributeName, nil]];
    //设置导航栏背景颜色
    [[UINavigationBar appearance] setBarTintColor:navBGColor];
    [self.navigationBar setShadowImage:[[UIImage alloc] init]];
}
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count > 0) {
        [viewController setHidesBottomBarWhenPushed:YES];
    }
    [super pushViewController:viewController animated:animated];
}

-(void)push:(UIViewController *)viewController animated:(UINavigationControllerAnimated)animated {
    if (self.viewControllers.count > 0) {
        [viewController setHidesBottomBarWhenPushed:YES];
    }
    [super push:viewController animated:animated];
}
-(void)popAnimated:(UINavigationControllerAnimated)animated {
    for (UIViewController *vc in self.viewControllers) {
        [vc setHidesBottomBarWhenPushed:YES];
    }
    [[self.viewControllers firstObject] setHidesBottomBarWhenPushed:NO];
    [super popAnimated:animated];
}
-(void)popTo:(UIViewController *)viewController {
    for (UIViewController *vc in self.viewControllers) {
        [vc setHidesBottomBarWhenPushed:YES];
    }
    [[self.viewControllers firstObject] setHidesBottomBarWhenPushed:NO];
    [super popTo:viewController];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
