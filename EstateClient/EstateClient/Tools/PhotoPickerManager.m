//
//  PhotoPickerManager.m
//  LongXiTechhnology
//
//  Created by admin on 15/7/4.
//  Copyright (c) 2015年 DragonSealTechnology. All rights reserved.
//

#import "PhotoPickerManager.h"

@interface PhotoPickerManager () <UIImagePickerControllerDelegate,ZYQAssetPickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic, weak) UIViewController  *fromController;
@property (nonatomic, copy) PickersCompelitionBlock completions;
@property (nonatomic, copy) PickerCompelitionBlock completion;
@property (nonatomic, copy) PickerCancelBlock  cancelBlock;

@end

@implementation PhotoPickerManager

SingletonClassM(PhotoManager);


/**
 设置定是否显示已选图片

 @param showSelectedImage showSelectedImage description
 */
-(void)setShowSelectedImage:(BOOL)showSelectedImage
{
    _showSelectedImage = showSelectedImage;
}

/**选择图库*/
-(void)showActioneWithAlbum:(UIViewController *)fromController completion:(PickerCompelitionBlock)completion cancelBlock:(PickerCancelBlock)cancelBlock
{
    self.completion = [completion copy];
    self.cancelBlock = [cancelBlock copy];
    self.fromController = fromController;
    [self openAlbumSelectNumber:1];
}
/**选择图库,自定义选择张数最少1张，最多9张*/
-(void)showActioneWithAlbum:(UIViewController *)fromController completions:(PickersCompelitionBlock)completions cancelBlock:(PickerCancelBlock)cancelBlock maxNumber:(NSInteger)maxNumber
{
    self.completions = [completions copy];
    self.cancelBlock = [cancelBlock copy];
    self.fromController = fromController;
    NSInteger number = maxNumber;
    if (number<=1) {
        number = 1;
    }else if (number>=9) {
        number = 9;
    }
    [self openAlbumSelectNumber:number];
}

/**打开相机*/
-(void)showActioneWithCamera:(UIViewController *)fromController completion:(PickerCompelitionBlock)completion cancelBlock:(PickerCancelBlock)cancelBlock
{
    self.completion = [completion copy];
    self.cancelBlock = [cancelBlock copy];
    self.fromController = fromController;
    [self openCamera];
}



/**
 *  打开系统相册
 */
-(void)openAlbumSelectNumber:(NSInteger)maxNumber
{
    
    ZYQAssetPickerController *picker = [[ZYQAssetPickerController alloc] init];
    picker.maximumNumberOfSelection = maxNumber;
    picker.assetsFilter = ZYQAssetsFilterAllAssets;
    picker.showEmptyGroups=NO;
    picker.delegate=self;
    picker.navigationBar.barTintColor = self.fromController.navigationController.navigationBar.barTintColor;
    // 设置导航默认标题的颜色及字体大小
    picker.navigationBar.titleTextAttributes = self.fromController.navigationController.navigationBar.titleTextAttributes;
    picker.selectionFilter = [NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
        if ([(ZYQAsset*)evaluatedObject mediaType]==ZYQAssetMediaTypeVideo) {
            NSTimeInterval duration = [(ZYQAsset*)evaluatedObject duration];
            return duration >= 5;
        } else {
            return YES;
        }
    }];
    [self.fromController presentViewController:picker animated:YES completion:NULL];
}

/**
 *  打开摄像头拍照
 */
-(void)openCamera
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        if ([UIDevice iOSVersion] >= 8.0) {
            picker.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        }
        picker.delegate = self;
        picker.navigationBar.barTintColor = self.fromController.navigationController.navigationBar.barTintColor;
        // 设置导航默认标题的颜色及字体大小
        picker.navigationBar.titleTextAttributes = self.fromController.navigationController.navigationBar.titleTextAttributes;
        [self.fromController presentViewController:picker animated:YES completion:nil];
    }
}
#pragma mark --ZYQAssetPickerControllerDelegate
-(void)assetPickerController:(ZYQAssetPickerController *)picker didFinishPickingAssets:(NSArray *)assets {
    NSMutableArray *images = [NSMutableArray arrayWithCapacity:assets.count];
    for (id objasset in assets) {
        if ([objasset isKindOfClass:[ZYQAsset class]]) {
            ZYQAsset *asset = (ZYQAsset *)objasset;
            [asset setGetFullScreenImage:^(UIImage *result) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (result) {
                        [images addObject:result];
                        if (images.count==assets.count) {
                            if (self.completion) {
                                self.completion([images firstObject]);
                            }
                            if (self.completions) {
                                self.completions(images);
                            }
                        }
                    }
                });
            } fromNetwokProgressHandler:^(double progress, NSError *error, BOOL *stop, NSDictionary *info) {
                NSLog(@"下载中%f",progress);
            }];
        }
        
    }
    picker.navigationBar.barTintColor = self.fromController.navigationController.navigationBar.barTintColor;
    // 设置导航默认标题的颜色及字体大小
    picker.navigationBar.titleTextAttributes = self.fromController.navigationController.navigationBar.titleTextAttributes;
}

-(void)assetPickerControllerDidMaximum:(ZYQAssetPickerController *)picker {
    
    AlertController(@"温馨提醒",kNSStringFormat(@"最多选择%ld张图片", (long)picker.maximumNumberOfSelection),picker);
}

-(void)assetPickerControllerDidCancel:(ZYQAssetPickerController *)picker {
    picker.navigationBar.barTintColor = self.fromController.navigationController.navigationBar.barTintColor;
    // 设置导航默认标题的颜色及字体大小
    picker.navigationBar.titleTextAttributes = self.fromController.navigationController.navigationBar.titleTextAttributes;
    
}
#pragma mark - UIImagePickerControllerDelegate
// 选择了图片或者拍照了
- (void)imagePickerController:(UIImagePickerController *)aPicker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [aPicker dismissViewControllerAnimated:YES completion:nil];
    __block UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage];
    if (image && self.completion) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                self.completion(image);
            });
        });
    }
    return;
}

// 取消
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)aPicker {
    if (self.cancelBlock) {
        self.cancelBlock();
    }
    [aPicker dismissViewControllerAnimated:YES completion:nil];
    return;
}

@end
