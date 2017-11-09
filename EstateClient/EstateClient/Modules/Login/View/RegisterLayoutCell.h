//
//  RegisterLayoutCell.h
//  EstateClient
//
//  Created by WebUser on 2017/11/9.
//  Copyright © 2017年 tigo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RegisterViewModel.h"

/**
 * 注册cell视图
 *
 */
@interface RegisterLayoutCell : UICollectionViewCell

//对外提供只读权限，保证属性值不会随意更改
@property(nonatomic, readonly, strong) RegisterViewModel *viewModel;

@end
