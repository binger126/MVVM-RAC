//
//  LoginViewModel.h
//  EstateClient
//
//  Created by WebUser on 2017/11/8.
//  Copyright © 2017年 tigo. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *登录页面的逻辑处理,这里不做页面跳转逻辑
 */
@interface LoginViewModel : NSObject

// 手机号
@property(nonatomic, readwrite, copy) NSString *mobilePhone;
// 验证码
@property(nonatomic, readwrite, copy) NSString *verifyCode;
// 验证码按钮能否点击
@property(nonatomic, readonly, strong) RACSignal *validCodeSignal;
// 验证码按钮点击执行的命令
@property(nonatomic, readonly, strong) RACCommand *codeCommand;
// 登录按钮能否点击
@property(nonatomic, readonly, strong) RACSignal *validLoginSignal;
// 登录按钮点击执行的命令
@property(nonatomic, readonly, strong) RACCommand *loginCommand;
// 前往注册执行的命令
@property(nonatomic, readonly, strong) RACCommand *intoRegisterCommand;

//完成初始化方法，可根据需求修改这个方法的传参
- (instancetype)initWithModel:(LoginViewModel *)model;

@end
