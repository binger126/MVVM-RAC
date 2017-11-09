//
//  CommonRequest.h
//  EstateClient
//
//  Created by WebUser on 2017/11/3.
//  Copyright © 2017年 tigo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SingletonClass.h"

typedef void(^CacheData_Block)(id result);
typedef void(^Success_Block)(id result);
typedef void(^Failure_Block)(NSError *error);

@interface CommonRequest : NSObject

SingletonClassH(Api)

-(void)requestHomeApi:(NSDictionary *)param
                cache:(CacheData_Block)cache
              success:(Success_Block)success
              failure:(Failure_Block)failure;

@end
