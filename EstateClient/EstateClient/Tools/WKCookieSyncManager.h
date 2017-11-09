//
//  WKCookieSyncManager.h
//  FashionClothing
//
//  Created by Amnice on 16/6/28.
//  Copyright © 2016年 Amnice. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>
#import "SingletonClass.h"

/**
 *  Cookie交互工具
 */
@interface WKCookieSyncManager : NSObject

SingletonClassH(CookieSyncManager)

@property(nonatomic, strong) WKProcessPool *processPool;

-(void)setCookie;

@end
