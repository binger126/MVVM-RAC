//
//  CommonViewController.h
//  EstateClient
//
//  Created by WebUser on 2017/11/3.
//  Copyright © 2017年 tigo. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 * 公共控制器
 * 这里考虑到项目中很多页面在可见视图中不能完全显示，故而在这里默认添加collectionView作为控制器的跟视图
 * 未能显示完整的视图，可以根据collectionView不同的区间或cell显示
 */
@interface CommonViewController : UIViewController<UICollectionViewDelegate,UICollectionViewDataSource>

//提供继承共用属性，根据需求可新增或修改
//区的数量
@property(nonatomic, assign, readwrite) NSInteger sections;
//每个区cell的数量
@property(nonatomic, assign, readwrite) NSInteger items;
//每个cell视图的大小
@property(nonatomic, assign, readwrite) CGSize itemSize;
//每个区头视图的大小
@property(nonatomic, assign, readwrite) CGSize headerSize;
//每个区尾视图的大小
@property(nonatomic, assign, readwrite) CGSize footerSize;
//跟视图
@property(nonatomic, strong, nullable) UICollectionView *collectionView;

@end
