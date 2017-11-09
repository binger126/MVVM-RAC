//
//  AFHttpTool.m
//  VictorOC
//
//  Created by WebUser on 17/2/28.
//  Copyright © 2017年 tcbwork. All rights reserved.
//

//日志输出宏定义
#ifdef DEBUG
//调试状态
#define MyStringRow [NSString stringWithFormat:@"%s", __FILE__].lastPathComponent
#define kNSLog(...) printf("\n%s 第%d行: %s\n",[MyStringRow UTF8String] ,__LINE__, [[NSString stringWithFormat:__VA_ARGS__] UTF8String]);
#else
//发布状态
#define kNSLog(...)
#endif

#import "AFHttpTool.h"

@implementation AFHttpTool

+ (void)getWithCachesURLString:(NSString *)spliceUrl
                    parameters:(id)parameters
                   resultClass:(Class)resultClass
                         cache:(CacheData_Block)cache
                       success:(Success_Block)success
                       failure:(Failure_Block)failure {
    NSString *url = [NSString stringWithFormat:@"%@%@",BaseURL,spliceUrl];
    id _parameters = [self getObjectData:parameters];
    //GET请求 只需要将cache设置为true就可以自动缓存
    [PGNetworkHelper GET:spliceUrl parameters:_parameters cache:true responseCache:^(id responseCache) {
        kNSLog(@"responseCache = %@", responseCache);
        if (resultClass!=nil) {
            id resultObject = [resultClass mj_objectWithKeyValues:responseCache];
            if (cache) {
                cache(resultObject);
            }
        }else{
            if (cache) {
                cache(responseCache);
            }
        }
    } success:^(id responseObject) {
        kNSLog(@"\n 请求url %@\n 请求参数 %@\n 结果 %@\n",url,_parameters,responseObject);
        if (resultClass!=nil) {
            id resultObject = [resultClass mj_objectWithKeyValues:responseObject];
            if (success) {
                success(resultObject);
            }
        }else{
            if (success) {
                success(responseObject);
            }
        }
    } failure:^(NSError *error) {
        kNSLog(@"\n 请求url %@\n 请求参数 %@\n failure %@\n",url,parameters,error);
        if (failure) {
            failure(error);
        }
    }];    
}

// GET请求
+ (void)getWithURLString:(NSString *)spliceUrl
              parameters:(id)parameters
             resultClass:(Class)resultClass
                 success:(Success_Block)success
                 failure:(Failure_Block)failure {
    NSString *url = [NSString stringWithFormat:@"%@%@",BaseURL,spliceUrl];
    id _parameters = [self getObjectData:parameters];
    [PGNetworkHelper GET:spliceUrl parameters:_parameters cache:false responseCache:nil success:^(id responseObject) {
        kNSLog(@"\n 请求url %@\n 请求参数 %@\n 结果 %@\n",url,_parameters,responseObject);
        if (resultClass!=nil) {
            id resultObject = [resultClass mj_objectWithKeyValues:responseObject];
            if (success) {
                success(resultObject);
            }
        }else{
            if (success) {
                success(responseObject);
            }
        }
    } failure:^(NSError *error) {
        kNSLog(@"\n 请求url %@\n 请求参数 %@\n failure %@\n",url,parameters,error);
        if (failure) {
            failure(error);
        }
    }];
}


// POST请求
+ (void)postWithURLString:(NSString *)spliceUrl
               parameters:(id)parameters
              resultClass:(Class)resultClass
                  success:(Success_Block)success
                  failure:(Failure_Block)failure {
    NSString *url = [NSString stringWithFormat:@"%@%@",BaseURL,spliceUrl];
    id _parameters = [self getObjectData:parameters];
    [PGNetworkHelper POST:spliceUrl parameters:_parameters cache:false responseCache:nil success:^(id responseObject) {
        kNSLog(@"\n 请求url %@\n 请求参数 %@\n 结果 %@\n",url,_parameters,responseObject);
        if (resultClass!=nil) {
            id resultObject = [resultClass mj_objectWithKeyValues:responseObject];
            if (success) {
                success(resultObject);
            }
        }else{
            if (success) {
                success(responseObject);
            }
        }
    } failure:^(NSError *error) {
        kNSLog(@"\n 请求url %@\n 请求参数 %@\n failure %@\n",url,parameters,error);
        if (failure) {
            failure(error);
        }
    }];
}
//get合并网络请求
+ (void)loadWithURLArray:(NSArray *)urlArray
          parameterArray:(NSArray *)parameterArray
        resultClassArray:(NSArray *)resultClassArray
                 success:(Successs_Block)success
                 failure:(Failures_Block)failure {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = 10;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html", nil];
    //串行队列
    dispatch_queue_t queue = dispatch_queue_create("TCB", DISPATCH_QUEUE_SERIAL);
    dispatch_set_target_queue(queue, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH,0));
    NSMutableArray *successArray = [NSMutableArray array];
    NSMutableArray *errorArray = [NSMutableArray array];
    for (int i=0;i<urlArray.count;i++) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
            NSString *url = [NSString stringWithFormat:@"%@%@",BaseURL,urlArray[i]];
            id _parameters = [self getObjectData:parameterArray[i]];
            [manager GET:url parameters:[self getObjectData:parameterArray[i]] progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                NSLog(@"\n 处理第%d个 请求url %@\n 请求参数 %@\n 结果 %@\n",i+1,url,_parameters,responseObject);
//                id keyValues = [responseObject mj_JSONObject];
                if (resultClassArray[i]!=nil) {
                    id resultObject = [resultClassArray[i] mj_objectWithKeyValues:responseObject];
                    [successArray addObject:resultObject];
                }else{
                    [successArray addObject:responseObject];
                }
                if (i==urlArray.count-1&&success) {
                    success(successArray);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                NSLog(@"\n 处理第%d个 请求url %@\n 请求参数 %@\n failure %@\n",i+1,url,parameterArray[i],error);
                [errorArray addObject:error];
                if (i==urlArray.count-1&&failure) {
                    failure(errorArray);
                }
            }];
        });
    }
}

#pragma mark -- 上传单张图片 --
+ (void)uploadImageWithURLString:(NSString *)spliceUrl
                      parameters:(id)parameters
                      uploadData:(NSData *)uploadData
                      uploadName:(NSString *)uploadName
                     resultClass:(Class)resultClass
                        progress:(Progress_Block)progress
                         success:(Success_Block)success
                         failure:(Failure_Block)failure {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html", nil];
    NSString *url = [NSString stringWithFormat:@"%@%@",BaseURL,spliceUrl];
    id _parameters = [self getObjectData:parameters];
    [manager POST:url parameters:_parameters constructingBodyWithBlock:^(id< AFMultipartFormData >  _Nonnull formData) {
        [formData appendPartWithFileData:uploadData name:uploadName fileName:[NSString stringWithFormat:@"%@.png",uploadName] mimeType:@"image/png"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progress) {
            progress(uploadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"\n 请求url %@\n 请求参数 %@\n 结果 %@\n",url,_parameters,responseObject);
//        id keyValues = [responseObject mj_JSONObject];
        if (resultClass!=nil) {
            id resultObject = [resultClass mj_objectWithKeyValues:responseObject];
            if (success) {
                success(resultObject);
            }
        }else{
            if (success) {
                success(responseObject);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"\n 请求url %@\n 请求参数 %@\n failure %@\n",url,parameters,error);
        if (failure) {
            failure(error);
        }
    }];
}

#pragma mark -- 上传多张图片 --
+ (void)uploadImagesWithURLString:(NSString *)spliceUrl
                       parameters:(id)parameters
                      uploadDatas:(NSMutableArray *)uploadDatas
                       uploadName:(NSString *)uploadName
                      resultClass:(Class)resultClass
                         progress:(Progress_Block)progress
                          success:(Success_Block)success
                          failure:(Failure_Block)failure {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html", nil];
    NSString *url = [NSString stringWithFormat:@"%@%@",BaseURL,spliceUrl];
    id _parameters = [self getObjectData:parameters];
    [manager POST:url parameters:_parameters constructingBodyWithBlock:^(id< AFMultipartFormData >  _Nonnull formData) {
        for (int i=0; i<uploadDatas.count; i++) {
            NSString *imageName = [NSString stringWithFormat:@"%@[%d]", uploadName, i];
            [formData appendPartWithFileData:uploadDatas[i] name:imageName fileName:[NSString stringWithFormat:@"%@%d.JPEG",uploadName,i] mimeType:@"image/JPEG"];
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progress) {
            progress(uploadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"\n 请求url %@\n 请求参数 %@\n 结果 %@\n",url,_parameters,responseObject);
//        id keyValues = [responseObject mj_JSONObject];
        if (resultClass!=nil) {
            id resultObject = [resultClass mj_objectWithKeyValues:responseObject];
            if (success) {
                success(resultObject);
            }
        }else{
            if (success) {
                success(responseObject);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"\n 请求url %@\n 请求参数 %@\n failure %@\n",url,parameters,error);
        if (failure) {
            failure(error);
        }
    }];
}

/**
 *  对象转换为字典
 *
 *  @param obj 需要转化的对象
 *
 *  @return 转换后的字典
 */
+ (NSDictionary*)getObjectData:(id)obj {
    if (obj==nil||[obj isKindOfClass:[NSDictionary class]]) {
        return obj;
    }
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    unsigned int propsCount;
    objc_property_t *props = class_copyPropertyList([obj class], &propsCount);
    for(int i = 0;i < propsCount; i++) {
        objc_property_t prop = props[i];
        NSString *propName = [NSString stringWithUTF8String:property_getName(prop)];
        id value = [obj valueForKey:propName];
        if(value == nil) {
            value = [NSNull null];
        } else {
            value = [self getObjectInternal:value];
        }
        [dic setObject:value forKey:propName];
    }
    return dic;
}
+ (id)getObjectInternal:(id)obj {
    if([obj isKindOfClass:[NSString class]]
       ||
       [obj isKindOfClass:[NSNumber class]]
       ||
       [obj isKindOfClass:[NSNull class]]) {
        return obj;
    }
    if([obj isKindOfClass:[NSArray class]]) {
        NSArray *objarr = obj;
        NSMutableArray *arr = [NSMutableArray arrayWithCapacity:objarr.count];
        for(int i = 0; i < objarr.count; i++) {
            [arr setObject:[self getObjectInternal:[objarr objectAtIndex:i]] atIndexedSubscript:i];
        }
        return arr;
    }
    if([obj isKindOfClass:[NSDictionary class]]) {
        NSDictionary *objdic = obj;
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:[objdic count]];
        for(NSString *key in objdic.allKeys) {
            [dic setObject:[self getObjectInternal:[objdic objectForKey:key]] forKey:key];
        }
        return dic;
    }
    return [self getObjectData:obj];
}

@end
