//
//  RegisterViewController.m
//  EstateClient
//
//  Created by WebUser on 2017/11/9.
//  Copyright © 2017年 tigo. All rights reserved.
//

#import "RegisterViewController.h"

#import "RegisterLayoutCell.h"

@interface RegisterViewController ()

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"注册";
    [self.collectionView registerNib:[UINib nibWithNibName:@"RegisterLayoutCell" bundle:nil] forCellWithReuseIdentifier:@"RegisterLayoutCell"];
    if (kIphone45) {
        self.itemSize = CGSizeMake(kScreenWidth, 603);
    }else{
        self.itemSize = CGSizeMake(kScreenWidth, kNoneNSBarHeight);
    }
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    RegisterLayoutCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"RegisterLayoutCell" forIndexPath:indexPath];
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
    // 注册成功信息
    [cell.viewModel.registerCommand.executionSignals.switchToLatest
     subscribeNext:^(id x) {
         //         @strongify(self);
         
     }];
    
    // 注册错误信息
    [cell.viewModel.registerCommand.errors subscribeNext:^(NSError *error) {
        @strongify(self);
        // 处理验证错误的error
        if ([error.domain isEqualToString:@"ErrorCode"]) {
            [self showHint:error.userInfo[@"ErrorCode"]];
            return;
        }
    }];
    // 返回登录
    [cell.viewModel.backLoginCommand.executionSignals.switchToLatest
     subscribeNext:^(id x) {
         @strongify(self);
         [self.navigationController popAnimated:UINavigationControllerAnimatedPush];
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
