//
//  ConfigTool.m
//  VictorOC
//
//  Created by WebUser on 17/3/13.
//  Copyright © 2017年 tcbwork. All rights reserved.
//

#import "ConfigTool.h"

@implementation ConfigTool

SingletonClassM(Tool)

/**
 *  将数据存储到轻存储
 */
-(void)saveUserConfigMsg:(NSString *)key value:(id)value
{
    //注意：对相同的Key赋值约等于一次覆盖，要保证每一个Key的唯一性
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:value forKey:key];
    [defaults synchronize];
}

/**
 *  读取轻存储数据
 */
-(id)readUserConfigMsg:(NSString *)key
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    id result = [defaults objectForKey:key];
    if (result!=nil) {
        return result;
    }
    return nil;
}

/**
 *  根据key删除轻存储数据
 */
-(void)deleteUserConfigMsg:(NSString *)forKey
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:forKey];
    [defaults synchronize];
}


/**
 *  将数据存储到Documents
 */
-(void)saveUserMsgDocuments:(NSString *)key value:(id)value
{
    //注意：对相同的Key赋值约等于一次覆盖，要保证每一个Key的唯一性
    NSArray *array=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path=[array objectAtIndex:0];
    NSString *filepath=[path stringByAppendingString:[NSString stringWithFormat:@"app_msg/%@.plist",key]];
    NSData *userData = (NSData *)value;
    [userData writeToFile:filepath atomically:YES];
}

/**
 *  读取Documents存储数据
 */
-(id)readUserMsgDocuments:(NSString *)key
{
    NSArray *array=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path=[array objectAtIndex:0];
    NSString *filepath=[path stringByAppendingString:[NSString stringWithFormat:@"app_msg/%@.plist",key]];
    id result = [NSData dataWithContentsOfFile:filepath];
    if (result!=nil) {
        return result;
    }
    return nil;
}

/**
 *  根据key删除Documents存储数据
 */
-(void)deleteUserMsgDocuments:(NSString *)forKey
{
    NSArray *array=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path=[array objectAtIndex:0];
    NSString *filepath=[path stringByAppendingString:[NSString stringWithFormat:@"app_msg/%@.plist",forKey]];
    BOOL success=[[NSFileManager defaultManager] removeItemAtPath:filepath error:nil];
    if (success) {
        NSLog(@"%@.plist删除成功！",forKey);
    }
}

/**
 *  将对象存储到Documents
 */
-(void)saveUserObjectToDocuments:(NSString *)key value:(id)value
{
    //注意：对相同的Key赋值约等于一次覆盖，要保证每一个Key的唯一性
    NSArray *array=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path=[array objectAtIndex:0];
    NSString *filepath=[path stringByAppendingString:[NSString stringWithFormat:@"app_msg/%@.plist",key]];
    BOOL success=[NSKeyedArchiver archiveRootObject:value toFile:filepath];
    if (success) {
        NSLog(@"%@.plist保存成功！",key);
    }
}

/**
 *  读取Documents存储对象
 */
-(id)readUserObjectToDocuments:(NSString *)key
{
    NSArray *array=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path=[array objectAtIndex:0];
    NSString *filepath=[path stringByAppendingString:[NSString stringWithFormat:@"app_msg/%@.plist",key]];
    id result = [NSKeyedUnarchiver unarchiveObjectWithFile:filepath];
    if (result!=nil) {
        return result;
    }
    return nil;
}

/**
 *  根据key删除Documents存储对象
 */
-(void)deleteUserObjectToDocuments:(NSString *)forKey
{
    NSArray *array=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path=[array objectAtIndex:0];
    NSString *filepath=[path stringByAppendingString:[NSString stringWithFormat:@"app_msg/%@.plist",forKey]];
    BOOL success=[[NSFileManager defaultManager] removeItemAtPath:filepath error:nil];
    if (success) {
        NSLog(@"%@.plist删除成功！",forKey);
    }
}

@end
