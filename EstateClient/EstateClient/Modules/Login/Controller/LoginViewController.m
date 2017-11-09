//
//  LoginViewController.m
//  EstateClient
//
//  Created by WebUser on 2017/11/6.
//  Copyright © 2017年 tigo. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "LoginLayoutCell.h"
#import "LoginViewModel.h"

@interface LoginViewController ()


@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"登录";
    [self.collectionView registerNib:[UINib nibWithNibName:@"LoginLayoutCell" bundle:nil] forCellWithReuseIdentifier:@"LoginLayoutCell"];
    if (kIphone45) {
        self.itemSize = CGSizeMake(kScreenWidth, 603);
    }else{
        self.itemSize = CGSizeMake(kScreenWidth, kNoneNSBarHeight);
    }
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LoginLayoutCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LoginLayoutCell" forIndexPath:indexPath];
    @weakify(self);
    // 获取验证码错误信息
    [cell.viewModel.codeCommand.errors subscribeNext:^(NSError *error) {
        @strongify(self);
        // 处理验证错误的error
        if ([error.domain isEqualToString:@"ErrorCode"]) {
            [self showHint:error.userInfo[@"ErrorCode"]];
            return;
        }
    }];
    // 登录成功信息
    [cell.viewModel.loginCommand.executionSignals.switchToLatest
     subscribeNext:^(id x) {
         //         @strongify(self);
         
     }];
    
    // 登录错误信息
    [cell.viewModel.loginCommand.errors subscribeNext:^(NSError *error) {
        @strongify(self);
        // 处理验证错误的error
        if ([error.domain isEqualToString:@"ErrorCode"]) {
            [self showHint:error.userInfo[@"ErrorCode"]];
            return;
        }
    }];
    // 前往注册
    [cell.viewModel.intoRegisterCommand.executionSignals.switchToLatest
     subscribeNext:^(id x) {
         @strongify(self);
         RegisterViewController *registerVC = [[RegisterViewController alloc] init];
         [self.navigationController push:registerVC animated:UINavigationControllerAnimatedPush];
     }];
    
    return cell;
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
