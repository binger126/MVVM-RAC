//
//  CommonRequest.m
//  EstateClient
//
//  Created by WebUser on 2017/11/3.
//  Copyright © 2017年 tigo. All rights reserved.
//

#import "CommonRequest.h"


@implementation CommonRequest

SingletonClassM(Api)

-(void)requestHomeApi:(NSDictionary *)param
                cache:(CacheData_Block)cache
              success:(Success_Block)success
              failure:(Failure_Block)failure {
//    [AFHttpTool getWithCachesURLString:@"" parameters:param resultClass:nil cache:^(id result) {
//        if (cache) {
//            cache(result);
//        }
//    } success:^(id result) {
//        if (success) {
//            success(result);
//        }
//    } failure:^(NSError *error) {
//        if (failure) {
//            failure(error);
//        }
//    }];
}

@end
