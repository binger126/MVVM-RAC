//
//  NSString+MMExtension.m
//  UnitaSinceMedia
//
//  Created by LongXi-Hua on 16/7/8.
//  Copyright © 2016年 UnitaCreate. All rights reserved.
//

#import "NSString+MMExtension.h"
#import <CommonCrypto/CommonCrypto.h>

@implementation NSString (MMExtension)

+(BOOL)isNull:(NSString *)string
{
    if (string==nil||[string isEqualToString:@""]) {
        return YES;
    }
    return NO;
}

+(NSString *)md5String:(NSString *)sourceString
{
    if (!sourceString) {
        return nil;
    }
    //MD5加密都是通过C级别的函数来计算，所以需要将加密的字符串转换为C语言的字符串
    const char *cString = sourceString.UTF8String;
    //创建一个C语言的字符数组，用来接收加密结束之后的字符
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    //MD5计算（也就是加密）
    //第一个参数：需要加密的字符串
    //第二个参数：需要加密的字符串的长度
    //第三个参数：加密完成之后的字符串存储的地方
    CC_MD5(cString,(CC_LONG)strlen(cString), result);
    //将加密完成的字符拼接起来使用（16进制的）。
    //声明一个可变字符串类型，用来拼接转换好的字符
    NSMutableString *resultString = [[NSMutableString alloc]init];
    //遍历所有的result数组，取出所有的字符来拼接
    for (int i = 0;i < CC_MD5_DIGEST_LENGTH; i++) {
        [resultString  appendFormat:@"%02x",result[i]];
        //%02x：x 表示以十六进制形式输出，02 表示不足两位，前面补0输出；超出两位，不影响。当x小写的时候，返回的密文中的字母就是小写的，当X大写的时候返回的密文中的字母是大写的。
    }
    return resultString;
}
//MD5数字加盐校验NSString对象
+ (NSString *)md5EncodeFromStr:(NSString *)str
                      withSalt:(NSString *)saltStr {
    if (str.length == 0) {
        return nil;
    }
    NSString *newStr = [str stringByAppendingString:saltStr];
    // 初始化C字符数组
    const char* original_str = (const char *)[[newStr dataUsingEncoding:NSUTF8StringEncoding] bytes];
    // 盛放数字校验的字符数组（长度为16bytes）
    unsigned char digist[CC_MD5_DIGEST_LENGTH]; //CC_MD5_DIGEST_LENGTH = 16
    CC_MD5(original_str, (uint)strlen(original_str), digist);
    //        NSMutableString* outPutStr = [NSMutableString stringWithCapacity:10];
    NSMutableString* outPutStr = [NSMutableString new];
    for(int  i =0; i<CC_MD5_DIGEST_LENGTH;i++){
        [outPutStr appendFormat:@"%02X",digist[i]];//小写x表示输出的是小写MD5，大写X表示输出的是大写MD5
    }
    return outPutStr;
}
//MD5数字校验NSData对象
+ (NSString *)md5EncodeFromData:(NSData *)data {
    if (!data) {
        return nil;
    }
    //需要MD5变量并且初始化
    CC_MD5_CTX  md5;
    CC_MD5_Init(&md5);
    //开始加密(第一个参数：对md5变量去地址，要为该变量指向的内存空间计算好数据，第二个参数：需要计算的源数据，第三个参数：源数据的长度)
    CC_MD5_Update(&md5, data.bytes, (CC_LONG)data.length);
    //声明一个无符号的字符数组，用来盛放转换好的数据
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    //将数据放入result数组
    CC_MD5_Final(result, &md5);
    //将result中的字符拼接为OC语言中的字符串，以便我们使用。
    NSMutableString *resultString = [NSMutableString string];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [resultString appendFormat:@"%02X",result[i]];
    }
    NSLog(@"resultString=========%@",resultString);
    return resultString;
}



-(NSString *)md5String
{
    if (!self) {
        return nil;
    }
    //MD5加密都是通过C级别的函数来计算，所以需要将加密的字符串转换为C语言的字符串
    const char *cString = self.UTF8String;
    //创建一个C语言的字符数组，用来接收加密结束之后的字符
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    //MD5计算（也就是加密）
    //第一个参数：需要加密的字符串
    //第二个参数：需要加密的字符串的长度
    //第三个参数：加密完成之后的字符串存储的地方
    CC_MD5(cString,(CC_LONG)strlen(cString), result);
    //将加密完成的字符拼接起来使用（16进制的）。
    //声明一个可变字符串类型，用来拼接转换好的字符
    NSMutableString *resultString = [[NSMutableString alloc]init];
    //遍历所有的result数组，取出所有的字符来拼接
    for (int i = 0;i < CC_MD5_DIGEST_LENGTH; i++) {
        [resultString  appendFormat:@"%02x",result[i]];
        //%02x：x 表示以十六进制形式输出，02 表示不足两位，前面补0输出；超出两位，不影响。当x小写的时候，返回的密文中的字母就是小写的，当X大写的时候返回的密文中的字母是大写的。
    }
    return resultString;
}

-(NSInteger)byteLength
{
    //拿到所有的str的length长度 （包括中文英文， 都算为1个字符）
    NSUInteger len = self.length;
    //汉子字符集
    NSString *pattern = @"[\u4e00-\u9fa5]";
    //正则表达式 筛选条件
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:nil];
    //计算中文字符的个数
    NSInteger numMatch = [regex numberOfMatchesInString:self options:NSMatchingReportProgress range:NSMakeRange(0, len)];
    return len + numMatch;
}

+(int)getCharacterFormStr:(NSString *)tempStr
{
    int strLength = 0;
    char *p = (char *)[tempStr cStringUsingEncoding:NSUnicodeStringEncoding];
    for (int i = 0; i < [tempStr lengthOfBytesUsingEncoding:NSUnicodeStringEncoding]; i++) {
        if (*p) {
            p++;
            strLength++;
        } else {
            p++;
        }
        
    }
    return strLength;
}
/**
 *  手机号码验证
 *
 *  @param mobileNumbel 传入的手机号码
 *
 *  @return 格式正确返回true  错误 返回fals
 */
+ (BOOL) isMobile:(NSString *)mobileNumbel{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,147,148,150,151,152,157,158,159,172,182,183,184,187,188,198
     * 联通：130,131,132,145,155,156,166,175,176,185,186      * 小米移动 170、171
     * 电信：133,149,153,173,174,177,180,181,189,199
     */
    NSString * MOBIL = @"^1(3[0-9]|4[5-7-9]|5[0-35-9]|7[0-7]|8[0-9]|9[89])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|4[78]|5[0-27-9]|72|8[2-478])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,145,155,156,166,175,176,185,186      * 小米移动 170、171
     17         */
    NSString * CU = @"^1(3[0-2]|45|5[56]|66|7[0156]|8[56])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,149,153,173,174,177,180,181,189,199
     22         */
    NSString * CT = @"^1((33|49|53|7[347]|8[019]|99)[0-9])\\d{7}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBIL];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:mobileNumbel]
         || [regextestcm evaluateWithObject:mobileNumbel]
         || [regextestct evaluateWithObject:mobileNumbel]
         || [regextestcu evaluateWithObject:mobileNumbel])) {
        return YES;
    }
    
    return NO;
}

+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString
{
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err)
    {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}
+ (NSString*)convertToJSONData:(id)infoDict
{
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:infoDict
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    
    NSString *jsonString = @"";
    
    if (! jsonData)
    {
        NSLog(@"Got an error: %@", error);
    }else
    {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    
    jsonString = [jsonString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];  //去除掉首尾的空白字符和换行字符
    
    [jsonString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    
    return jsonString;
}

+ (CGSize)getAttributeSizeWithText:(NSString *)text fontSize:(CGFloat)fontSize
{
    //    CGSize size=[text sizeWithAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:fontSize]}];
    //    if (!IOS8) {
    //        size=[text sizeWithAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:fontSize]}];
    //    }else{
    //        NSAttributedString *attributeSting = [[NSAttributedString alloc] initWithString:text attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:fontSize]}];
    //        size = [attributeSting size];
    //    }
    NSAttributedString *attributeSting = [[NSAttributedString alloc] initWithString:text attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:fontSize]}];
    //    size = [attributeSting size];
    return [attributeSting size];
}
+ (NSMutableAttributedString *)getAttributeSizeWithAllText:(NSString *)allText changeText:(NSString *)changeText changeTextColor:(UIColor *)changeTextColor changeTextCGFloat:(CGFloat)changeTextCGFloat
{
    NSMutableAttributedString *attributeSting = [[NSMutableAttributedString alloc] initWithString:allText];
    NSRange changeRange = NSMakeRange([[attributeSting string] rangeOfString:changeText].location, [[attributeSting string] rangeOfString:changeText].length);
    //需要设置的位置
    [attributeSting addAttribute:NSForegroundColorAttributeName value:changeTextColor range:changeRange];
    [attributeSting addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:changeTextCGFloat] range:changeRange];
    return attributeSting;
}


/**获取时间：今天昨天*/
+(NSString *)getYMD:(NSString *)dateString
{
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    NSArray *timeArray = [dateString componentsSeparatedByString:@":"];
    if (timeArray.count>2) {
        [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    }else{
        [format setDateFormat:@"yyyy-MM-dd HH:mm"];
    }
    //时间字符串转换成NSDate
    NSDate *date = [format dateFromString:dateString];
    
//    double timeBefore = [date timeIntervalSinceDate:date];
//    double timeNow = date.timeIntervalSince1970;
//    double distanceTime = timeNow - timeBefore;
//    if (distanceTime<60) {//刚刚
//        return [NSString stringWithFormat:@"%@",@"刚刚"];
//    }else if (distanceTime<60*60) {//几分钟前
//        return [NSString stringWithFormat:@"%ld分钟前",(long)distanceTime/60];
//    }else{
        //年月日 时间 格式
        NSDateFormatter *ymrformat = [[NSDateFormatter alloc] init];
        [ymrformat setDateFormat:@"yyyy-MM-dd"];
        //获取传过来的时间的 时分格式
        NSDateFormatter *hsformat = [[NSDateFormatter alloc] init];
        if (timeArray.count>2) {
            [hsformat setDateFormat:@"HH:mm:ss"];
        }else{
            [hsformat setDateFormat:@"HH:mm"];
        }
        
        //获取传过来的时间的date
        NSString *ymd = [ymrformat stringFromDate:date];
        NSString *hs = [hsformat stringFromDate:date];
        //获取今天
        NSDate *nowDate = [NSDate date];
        NSString *today = [ymrformat stringFromDate:nowDate];
        //获取昨天
        NSDate *yesterdayDate = [NSDate dateWithTimeIntervalSinceNow:-(24*60*60)];
        NSString *yesterday = [ymrformat stringFromDate:yesterdayDate];
        
        if ([ymd isEqualToString:today]) {
            return [NSString stringWithFormat:@"今天 %@",hs];
        }else if ([ymd isEqualToString:yesterday]) {
            return [NSString stringWithFormat:@"昨天 %@",hs];
        }
        return [NSString stringWithFormat:@"%@ %@",ymd,hs];
//    }
}

+(NSString *)customerPhone:(NSString *)phone {
    if ([NSString isMobile:phone]) {
        NSString *newPhone = [phone stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
        return newPhone;
    }
    return nil;
}
///**获取时间：今天昨天*/
//+(NSString *)getYMD:(NSString *)dateString
//{
//    //年月日时间格式
//    NSDateFormatter *format = [[NSDateFormatter alloc] init];
//    [format setDateFormat:@"yyyy-MM-dd"];
//    //时间字符串转换成NSDate
//    NSDate *date = [format dateFromString:dateString];
//    //获取传过来的时间的 时分秒格式
//    NSDateFormatter *fo = [[NSDateFormatter alloc] init];
//    [fo setDateFormat:@"HH:mm:ss"];
//    NSString *hsm = [fo stringFromDate:date];
//    //获取传过来的时间的date
//    NSString *ymd = [format stringFromDate:date];
//    //获取今天
//    NSDate *nowDate = [NSDate date];
//    NSString *today = [format stringFromDate:nowDate];
//    //获取昨天
//    NSDate *yesterdayDate = [NSDate dateWithTimeIntervalSinceNow:-(24*60*60)];
//    NSString *yesterday = [format stringFromDate:yesterdayDate];
//    
//    if ([ymd isEqualToString:today]) {
//        return [NSString stringWithFormat:@"今天 %@",hsm];
//    }else if ([ymd isEqualToString:yesterday]) {
//        return [NSString stringWithFormat:@"昨天 %@",hsm];
//    }
//    return [NSString stringWithFormat:@"%@ %@",ymd,hsm];
//}

@end
