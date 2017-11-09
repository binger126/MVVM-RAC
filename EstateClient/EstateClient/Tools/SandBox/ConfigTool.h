//
//  ConfigTool.h
//  VictorOC
//
//  Created by WebUser on 17/3/13.
//  Copyright © 2017年 tcbwork. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SingletonClass.h"

@interface ConfigTool : NSObject

SingletonClassH(Tool)


#pragma mark --- NSUserDefaults
/**轻存储 存储数据*/
-(void)saveUserConfigMsg:(NSString *)key value:(id)value;
/**轻存储 读取数据*/
-(id)readUserConfigMsg:(NSString *)key;
/**轻存储 根据key删除某项*/
-(void)deleteUserConfigMsg:(NSString *)forKey;



#pragma mark --- writeToFile Documents
/**存储数据Documents*/
-(void)saveUserMsgDocuments:(NSString *)key value:(id)value;
/**读取数据Documents*/
-(id)readUserMsgDocuments:(NSString *)key;
/**根据key删除Documents某项*/
-(void)deleteUserMsgDocuments:(NSString *)forKey;



#pragma mark --- writeToFile 保存对象 Documents
/**储存对象数据Documents*/
-(void)saveUserObjectToDocuments:(NSString *)key value:(id)value;
/**读取对象数据Document*/
-(id)readUserObjectToDocuments:(NSString *)key;
/**根据key删除Document某项*/
-(void)deleteUserObjectToDocuments:(NSString *)forKey;

@end
