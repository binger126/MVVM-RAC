//
//  LoginViewModel.m
//  EstateClient
//
//  Created by WebUser on 2017/11/8.
//  Copyright © 2017年 tigo. All rights reserved.
//

#import "LoginViewModel.h"

@interface LoginViewModel ()

// 验证码按钮能否点击
@property(nonatomic, readwrite, strong) RACSignal *validCodeSignal;
// 登录按钮能否点击
@property(nonatomic, readwrite, strong) RACSignal *validLoginSignal;
// 验证码按钮点击执行的命令
@property(nonatomic, readwrite, strong) RACCommand *codeCommand;
// 登录按钮点击执行的命令
@property(nonatomic, readwrite, strong) RACCommand *loginCommand;
// 前往注册执行的命令
@property(nonatomic, readwrite, strong) RACCommand *intoRegisterCommand;

@end

@implementation LoginViewModel

//完成初始化，对这个对象分配空间，保证执行initialize方法的有效性
+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    LoginViewModel *viewModel = [super allocWithZone:zone];
    @weakify(viewModel)
    [[viewModel
      rac_signalForSelector:@selector(initWithModel:)]
     subscribeNext:^(id x) {
         @strongify(viewModel)
         [viewModel initialize];
     }];
    return viewModel;
}

- (instancetype)initWithModel:(LoginViewModel *)model {
    self = [super init];
    if (self) {
    }
    return self;
}
//登录页面的逻辑处理
- (void)initialize {
    // 验证码按钮有效性
    self.validCodeSignal = [[RACSignal combineLatest:@[RACObserve(self,mobilePhone)]
                                              reduce:^(NSString *mobilePhone) {
                                                  return @(mobilePhone.length > 0);
                                              }] distinctUntilChanged];
    // 登录按钮有效性
    self.validLoginSignal = [[RACSignal combineLatest:@[RACObserve(self,mobilePhone),RACObserve(self,verifyCode)]
                                               reduce:^(NSString *mobilePhone, NSString *verifyCode) {
                                                   return @(mobilePhone.length > 0&&verifyCode.length > 0);
                                               }] distinctUntilChanged];
    @weakify(self);
    // 验证码命令
    self.codeCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self);
        // 这里手机号以及验证码在控制器那里也可以在视图控制器筛选，但同时也可以在viewModel中处理
        // 最好的写法:button.rac_command = viewmodel.loginCommand...把位数判断移到这里
        if (![self.mobilePhone isEqualToString:@"17180101707"]) {
            return [RACSignal error:[NSError errorWithDomain:@"ErrorCode" code:7438 userInfo:@{@"ErrorCode":@"请输入正确的手机号码"}]];
        }
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            // 发起请求 模拟网络请求
            [AFHttpTool postWithURLString:@"" parameters:nil resultClass:nil success:^(id result) {
                [subscriber sendNext:nil];
                // 必须sendCompleted，表示发送信号完成 否则command.executing一直为1 导致HUD 一直 loading
                [subscriber sendCompleted];
            } failure:^(NSError *error) {
                /// 失败的回调，内部已经做了sendCompleted的操作，这里不必再做此操作
                [subscriber sendError:[NSError errorWithDomain:@"ErrorCode" code:7438 userInfo:@{@"ErrorCode":@"呜呜，服务器不给力呀..."}]];
            }];
            return nil;
        }];
    }];
    // 登录命令
    self.loginCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self);
        if (![self.mobilePhone isEqualToString:@"17180101707"]) {
            return [RACSignal error:[NSError errorWithDomain:@"ErrorCode" code:7438 userInfo:@{@"ErrorCode":@"请输入正确的手机号码"}]];
        }
        if (![self.verifyCode isEqualToString:@"123456"]) {
            return [RACSignal error:[NSError errorWithDomain:@"ErrorCode" code:7438 userInfo:@{@"ErrorCode":@"请输入正确的验证码"}]];
        }
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            // 发起请求 模拟网络请求
            [AFHttpTool postWithURLString:@"" parameters:nil resultClass:nil success:^(id result) {
                [subscriber sendNext:nil];
                // 必须sendCompleted 否则command.executing一直为1 导致HUD 一直 loading
                [subscriber sendCompleted];
            } failure:^(NSError *error) {
                /// 失败的回调
                [subscriber sendError:[NSError errorWithDomain:@"ErrorCode" code:7438 userInfo:@{@"ErrorCode":@"呜呜，服务器不给力呀..."}]];
            }];
            return nil;
        }];
    }];
    
    self.intoRegisterCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            [subscriber sendNext:nil];
            // 必须sendCompleted 否则command.executing一直为1 导致HUD 一直 loading
            [subscriber sendCompleted];
            return nil;
        }];
    }];
}

@end
