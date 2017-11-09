//
//  ChatRecordTool.h
//  VictorOC
//
//  Created by WebUser on 17/4/5.
//  Copyright © 2017年 tcbwork. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SingletonClass.h"

@interface ChatRecordTool : NSObject

SingletonClassH(Tool)

//以文件夹形式存放聊天记录
/**
 * @parameter arrayObject 存放的数据源（聊天记录）
 * @parameter folder      对应不同的登录账号创建不同的文件夹（同一个账号）
 * @parameter fileName    对应同一文件夹下创建不同的文件（聊天对象）
 */
- (BOOL)writeToArrayFile:(NSArray *)arrayObject folder:(NSString *)folder fileName:(NSString *)fileName;
/**
 * @return    NSArray     单个聊天记录
 * @parameter folder      对应不同的登录账号创建的不同文件夹（同一个账号）
 * @parameter fileName    对应同一文件夹下创建的不同文件（聊天对象）
 */
- (NSArray *)readArrayFile:(NSString *)folder fileName:(NSString *)fileName;

//以字典形式存放聊天记录
/**
 * @parameter dictionaryObject （key聊天对象 value聊天记录）
 * @parameter fileName         对应不同的登录账号创建不同的字典（同一个账号）
 */
- (BOOL)writeToDictionaryFile:(NSMutableDictionary *)dictionaryObject fileName:(NSString *)fileName;
/**
 * @return    NSMutableDictionary 整个账号的聊天记录（包括多个聊天对象）
 * @parameter fileName            对应不同的登录账号创建的不同字典（同一个账号）
 */
- (NSMutableDictionary *)readDictionaryFile:(NSString *)fileName;



@end
