//
//  AppDelegate+Method.m
//  EstateClient
//
//  Created by WebUser on 2017/11/3.
//  Copyright © 2017年 tigo. All rights reserved.
//

#import "AppDelegate+Method.h"
#import "CommonNavigationController.h"
#import "RootTabBarController.h"
#import "LoginViewController.h"

@implementation AppDelegate (Method)

- (void)setBaseUrl {
    //设置baseUrl
    [PGNetAPIClient baseUrl:@"http://clothing.tigonetwork.com/clo_api/index.php?s="];
    //设置SSL
    [PGNetAPIClient policyWithPinningMode:AFSSLPinningModeNone];
    //设置缓存路径
    //多用户一般用userId来保存每个用户的缓存数据
    [PGNetworkCache pathName:@"user_ids"];
}

- (void)setupRootController {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
//    RootTabBarController *root = [[RootTabBarController alloc] init];
    CommonNavigationController *root = [[CommonNavigationController alloc] initWithRootViewController:[[LoginViewController alloc] init]];
    self.window.rootViewController = root;
    [self.window makeKeyAndVisible];
}

@end
