//
//  NSString+MMExtension.h
//  UnitaSinceMedia
//
//  Created by LongXi-Hua on 16/7/8.
//  Copyright © 2016年 UnitaCreate. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (MMExtension)


/**
 判断字符串是否为空

 @param string 字符串
 @return 返回 YES 不为空 NO 为空
 */
+(BOOL)isNull:(NSString *)string;

/**
 *  md5字符串加密
 *
 *  param sourceString
 *
 *  return
 */
+(NSString *)md5String:(NSString *)sourceString;

/**
 *  md5字符串加密
 *
 *  return
 */
-(NSString *)md5String;
/**
 *  字符计算 emoji按2个字符算
 *
 *  return
 */
- (NSInteger)byteLength;
/**
 *  计算字符 Unicode编码后按 4个 字符算
 *
 *  param tempStr
 *
 *  return
 */
+ (int)getCharacterFormStr:(NSString *)tempStr;
/**
 *  手机号码验证
 */
+ (BOOL) isMobile:(NSString *)mobileNumbel;
/**
 *  Json字符串转换为字典
 */
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;
/**
 *  字典转换为Json字符串
 */
+ (NSString*)convertToJSONData:(id)infoDict;
/**
 *  计算字符串的大小
 */
+ (CGSize)getAttributeSizeWithText:(NSString *)text fontSize:(CGFloat)fontSize;
/**
 *  改变字体大小颜色
 */
+ (NSMutableAttributedString *)getAttributeSizeWithAllText:(NSString *)allText changeText:(NSString *)changeText changeTextColor:(UIColor *)changeTextColor changeTextCGFloat:(CGFloat)changeTextCGFloat;
/**获取时间：今天昨天*/
+(NSString *)getYMD:(NSString *)dateString;
/**手机号加米*/
+(NSString *)customerPhone:(NSString *)phone;

@end
