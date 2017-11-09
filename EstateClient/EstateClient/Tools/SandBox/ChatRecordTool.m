//
//  ChatRecordTool.m
//  VictorOC
//
//  Created by WebUser on 17/4/5.
//  Copyright © 2017年 tcbwork. All rights reserved.
//
#define kProductName @"VictorOC"

#import "ChatRecordTool.h"

@implementation ChatRecordTool

SingletonClassM(Tool)

- (BOOL)writeToArrayFile:(NSArray *)arrayObject folder:(NSString *)folder fileName:(NSString *)fileName {
    //文件夹统一账号信息，不同账号登录对应生成不同的文件夹
    NSString *fileFolder = [NSFileManager CreateList:[NSFileManager GetDocumentPath] ListName:kNSStringFormat(@"%@/%@",kProductName,folder)];
    //同一个文件夹下存放不同的会话对象的聊天记录
    NSString *filePaths = kNSStringFormat(@"%@/%@", fileFolder,fileName);
    if ([NSFileManager IsFileExists:filePaths]) {
        [NSFileManager DeleteFile:filePaths];
    }
    return [NSFileManager WriteFileArray:arrayObject SpecifiedFile:filePaths];
}
- (NSArray *)readArrayFile:(NSString *)folder fileName:(NSString *)fileName {
    NSString *fileFolder = [NSFileManager CreateList:[NSFileManager GetDocumentPath] ListName:kNSStringFormat(@"%@/%@",kProductName,folder)];
    return [NSArray arrayWithContentsOfFile:kNSStringFormat(@"%@/%@", fileFolder,fileName)];
}


- (BOOL)writeToDictionaryFile:(NSMutableDictionary *)dictionaryObject fileName:(NSString *)fileName {
    //一个字典统一账号信息，不同账号登录对应生成不同的字典
    //同一个字典下以key value形式存放不同的会话对象的聊天记录
    NSString *filePaths = kNSStringFormat(@"%@/%@Chat/%@",[NSFileManager GetDocumentPath], kProductName,fileName);
    if ([NSFileManager IsFileExists:filePaths]) {
        [NSFileManager DeleteFile:filePaths];
    }
    return [NSFileManager WriteFileDictionary:dictionaryObject SpecifiedFile:filePaths];
}
- (NSMutableDictionary *)readDictionaryFile:(NSString *)fileName {
    NSString *filePaths = kNSStringFormat(@"%@/%@Chat/%@",[NSFileManager GetDocumentPath], kProductName,fileName);
    return [NSMutableDictionary dictionaryWithContentsOfFile:filePaths];
}


@end
