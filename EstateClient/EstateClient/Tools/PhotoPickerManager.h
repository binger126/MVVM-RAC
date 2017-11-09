//
//  PhotoPickerManager.h
//  LongXiTechhnology
//
//  Created by admin on 15/7/4.
//  Copyright (c) 2015年 DragonSealTechnology. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ZYQAssetPickerController.h>
#import "SingletonClass.h"

/*!
 * @brief 照片获取或者拍照功能管理器
 */
@interface PhotoPickerManager : NSObject

SingletonClassH(PhotoManager)


/*!
 * @brief 选择多张图片后，会调用此block
 * @param images 选择的图片
 */
typedef void (^PickersCompelitionBlock)(NSMutableArray *images);
/*!
 * @brief 选择图片或者拍照完成选择使用拍照的图片后，会调用此block
 * @param image 选择的图片或者拍照后选择使用的图片
 */
typedef void (^PickerCompelitionBlock)(UIImage *image);
/*!
 * @brief 用户点击取消时的回调block
 */
typedef void (^PickerCancelBlock)(void);

/**是否展示选择图片(默认为不显示)*/
@property(nonatomic, assign,getter=isSelectImage) BOOL showSelectedImage;

/**设置生成图片大小(默认 780 * 950)*/
@property(nonatomic, assign) CGSize resetImageSize;


/**
 选取系统图库多张图
 
 @param fromController fromController description
 @param completions completions description
 @param cancelBlock cancelBlock description
 @param maxNumber maxNumber description
 */
-(void)showActioneWithAlbum:(UIViewController *)fromController completions:(PickersCompelitionBlock)completions cancelBlock:(PickerCancelBlock)cancelBlock maxNumber:(NSInteger)maxNumber;
/**
 选取系统图库

 @param fromController fromController description
 @param completion completion description
 @param cancelBlock cancelBlock description
 */
-(void)showActioneWithAlbum:(UIViewController *)fromController completion:(PickerCompelitionBlock)completion cancelBlock:(PickerCancelBlock)cancelBlock;


/**
 相机拍照

 @param fromController fromController description
 @param completion completion description
 @param cancelBlock cancelBlock description
 */
-(void)showActioneWithCamera:(UIViewController *)fromController completion:(PickerCompelitionBlock)completion cancelBlock:(PickerCancelBlock)cancelBlock;

@end
