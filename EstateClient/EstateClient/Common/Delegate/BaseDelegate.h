//
//  BaseDelegate.h
//  EstateClient
//
//  Created by WebUser on 2017/11/8.
//  Copyright © 2017年 tigo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseDelegate : NSObject<UICollectionViewDelegate,UICollectionViewDataSource>

+(instancetype)delegate;

//属性
@property(nonatomic, assign, readwrite) NSInteger sections;
@property(nonatomic, assign, readwrite) NSInteger items;
@property(nonatomic, assign, readwrite) CGSize itemSize;
@property(nonatomic, assign, readwrite) CGSize headerSize;
@property(nonatomic, assign, readwrite) CGSize footerSize;

@end
