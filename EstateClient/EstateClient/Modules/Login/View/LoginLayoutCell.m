//
//  LoginLayoutCell.m
//  EstateClient
//
//  Created by WebUser on 2017/11/8.
//  Copyright © 2017年 tigo. All rights reserved.
//

#import "LoginLayoutCell.h"


@interface LoginLayoutCell ()

@property (strong, nonatomic) IBOutlet UITextField *loginPhone;
@property (strong, nonatomic) IBOutlet UITextField *loginCode;
@property (strong, nonatomic) IBOutlet UIButton *getCodeBtn;
@property (strong, nonatomic) IBOutlet UIButton *loginBtn;
@property (strong, nonatomic) IBOutlet UIButton *intoRegisterBtn;

@property(nonatomic,readwrite, strong) LoginViewModel *viewModel;

@end

@implementation LoginLayoutCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    kViewRadius(self.getCodeBtn, 5.0);
    kViewRadius(self.loginBtn, 5.0);
    [self bindViewModel];
}

- (void)bindViewModel {
    //初始化ViewModel 若不初始化ViewModel对象，执行RAC直接引发对象未实例化而程序崩溃
    LoginViewModel *viewModel = [[LoginViewModel alloc] initWithModel:nil];
    //对外ViewModel进行赋值，保证View和Controller共用一个ViewModel
    self.viewModel = viewModel;
    //添加观察者，监听输入文本框的变化，实现和ViewModel属性数据实时绑定
    RAC(viewModel , mobilePhone) = [RACSignal merge:@[RACObserve(self.loginPhone, text),self.loginPhone.rac_textSignal]];
    /** ps:rac_textSignal信号只有用户输入才有效，如果直接对field.text赋值，rac_textSignal信号就不会触发，导致无法验证赋值数据的有效性
     *  所以这里使用数组，数组中包含RACObserve和rac_textSignal，利用 RACObserve 来观察field.text的赋值办法即可
     *  1、用户非输入而是直接赋值的情况 触发RACObserve
     *  2、用户输入的情况 触发rac_textSignal
     */
    RAC(viewModel , verifyCode) = [RACSignal merge:@[RACObserve(self.loginCode, text),self.loginCode.rac_textSignal]];
    //按钮是否可点击的信号量
    RAC(self.getCodeBtn , enabled) = viewModel.validCodeSignal;
    RAC(self.loginBtn , enabled) = viewModel.validLoginSignal;
    @weakify(self);
#pragma mark -- code --
    [[[self.getCodeBtn rac_signalForControlEvents:UIControlEventTouchUpInside]
      doNext:^(id x) {
          @strongify(self);
          // 键盘掉下
          [self.contentView endEditing:YES];
      }] subscribeNext:^(UIButton *sender) {
          [viewModel.codeCommand execute:nil];
      }];
    // 获取验证码成功
    [viewModel.codeCommand.executionSignals.switchToLatest
     subscribeNext:^(id x) {
         @strongify(self);
         [self.getCodeBtn setTheCountdownStartWithTime:59 title:@"验证码" countDownTitle:@"s" mainColor:self.getCodeBtn.backgroundColor countColor:self.getCodeBtn.backgroundColor];
     }];
    
#pragma mark -- login --
    [[[self.loginBtn rac_signalForControlEvents:UIControlEventTouchUpInside]
      doNext:^(id x) {
          @strongify(self);
          // 键盘掉下
          [self.contentView endEditing:YES];
      }] subscribeNext:^(UIButton *sender) {
          [viewModel.loginCommand execute:nil];
      }];
#pragma mark -- intoRegister --
    [[[self.intoRegisterBtn rac_signalForControlEvents:UIControlEventTouchUpInside]
      doNext:^(id x) {
          @strongify(self);
          // 键盘掉下
          [self.contentView endEditing:YES];
      }] subscribeNext:^(UIButton *sender) {
          [viewModel.intoRegisterCommand execute:nil];
      }];
}


#pragma mark - Override
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    // 键盘掉下
    [self.contentView endEditing:YES];
}

@end
