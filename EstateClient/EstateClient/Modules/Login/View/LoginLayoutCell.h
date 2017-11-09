//
//  LoginLayoutCell.h
//  EstateClient
//
//  Created by WebUser on 2017/11/8.
//  Copyright © 2017年 tigo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginViewModel.h"

/**
 * 登录cell视图
 *
 */
@interface LoginLayoutCell : UICollectionViewCell

//对外提供只读权限，保证属性值不会随意更改
@property(nonatomic, readonly, strong) LoginViewModel *viewModel;

@end
