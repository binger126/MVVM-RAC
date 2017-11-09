//
//  NoneNetworkViewController.m
//  VictorTu
//
//  Created by WebUser on 17/5/19.
//  Copyright © 2017年 tigo. All rights reserved.
//

#import "NoneNetworkViewController.h"

@interface NoneNetworkViewController ()

@end

@implementation NoneNetworkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    UIImageView *networkImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_none_network"]];
    networkImage.frame = CGRectMake(kScreenWidth/3, (kScreenHeight-kScreenWidth/3)/2, kScreenWidth/3, kScreenWidth/3);
    [self.view addSubview:networkImage];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_9_0
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"网络不给力,请检查网络设置!" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [alert dismissViewControllerAnimated:YES completion:nil];
    }]];
    [self presentViewController:alert animated:YES completion:nil];
#else
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"网络不给力,请检查网络设置!" delegate:nil cancelButtonTitle:@"确定"otherButtonTitles:nil, nil];
    [alert show];
#endif
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self dismissViewControllerAnimated:YES completion:nil];
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
