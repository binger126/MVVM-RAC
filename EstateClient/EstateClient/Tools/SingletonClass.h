//
//  SingletonClass.h
//  VictorOC
//
//  Created by WebUser on 17/3/13.
//  Copyright © 2017年 tcbwork. All rights reserved.
//

#ifndef SingletonClass_h
#define SingletonClass_h
//  单例

// .h文件
#define SingletonClassH(name) \
+ (instancetype)shared##name;

// .m文件
#define SingletonClassM(name) \
static id _instance = nil; \
+ (id)allocWithZone:(struct _NSZone *)zone \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [super allocWithZone:zone]; \
}); \
return _instance; \
} \
+ (instancetype)shared##name \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [[self alloc] init]; \
}); \
return _instance; \
} \
- (id)copyWithZone:(NSZone *)zone \
{ \
return _instance; \
}

#endif /* SingletonClass_h */
