//
//  MD5_Base64.h
//  EstateClient
//
//  Created by WebUser on 2017/11/3.
//  Copyright © 2017年 tigo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MD5_Base64 : NSObject

+ (NSString *) md5ToHex:(NSString *) input;
+ (NSMutableArray *)md5:(NSString *) input;
//md5方法加密字符串并转化为base64
+ (NSString *)base64_Md5String:(NSString *)string;

@end


