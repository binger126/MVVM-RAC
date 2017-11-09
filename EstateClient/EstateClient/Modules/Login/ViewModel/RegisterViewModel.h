//
//  RegisterViewModel.h
//  EstateClient
//
//  Created by WebUser on 2017/11/9.
//  Copyright © 2017年 tigo. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *注册页面的逻辑处理,基本和登录一致，为防止信号错乱，故而和登录分开（若有信心处理好，也可写在一起）
 */
@interface RegisterViewModel : NSObject

// 手机号
@property(nonatomic, readwrite, copy) NSString *mobilePhone;
// 验证码
@property(nonatomic, readwrite, copy) NSString *verifyCode;
// 验证码按钮能否点击
@property(nonatomic, readonly, strong) RACSignal *validCodeSignal;
// 验证码按钮点击执行的命令
@property(nonatomic, readonly, strong) RACCommand *codeCommand;
// 注册按钮能否点击
@property(nonatomic, readonly, strong) RACSignal *validRegisterSignal;
// 注册按钮点击执行的命令
@property(nonatomic, readonly, strong) RACCommand *registerCommand;
// 返回登录执行的命令
@property(nonatomic, readonly, strong) RACCommand *backLoginCommand;

//完成初始化方法，可根据需求修改这个方法的传参
- (instancetype)initWithModel:(RegisterViewModel *)model;

@end
