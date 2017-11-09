//
//  TCBPinyinGroup.h
//  EstateBrokerage
//
//  Created by Victor on 17/1/6.
//  Copyright © 2017年 Tigo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
/**
 *  获取model数组
 */
UIKIT_EXTERN NSString *const LEOPinyinGroupResultKey;

/**
 *  获取所包函字母的数组
 */
UIKIT_EXTERN NSString *const LEOPinyinGroupCharKey;

/**
 *  返回多音字对应的A－Z区间值
 */
typedef NS_ENUM(NSInteger, AZSectionContent) {
    /**
     *  长
     */
    Chang,
    /**
     *  沈
     */
    Shen,
    /**
     *  厦
     */
    Xia,
    /**
     *  地
     */
    Di,
    /**
     *  重
     */
    Chong,
    /**
     *  all
     */
    All
};

@interface TCBPinyinGroup : NSObject

/*
 参数group:未排训分组的model数组
 参数key:根据model中的那个属性排训
 */
+(NSDictionary *)group:(NSArray *)datas key:(NSString *)key;

@end
