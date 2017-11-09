//
//  StorageKeyMacro.h
//  VictorOC
//
//  Created by WebUser on 17/3/13.
//  Copyright © 2017年 tcbwork. All rights reserved.
//

#ifndef StorageKeyMacro_h
#define StorageKeyMacro_h

#pragma mark -- 三方平台申请的key

#define kGtAppId @"0mJdRyBCt47neJDkdCuFC7"
#define kGtAppKey @"DVzscMheKA8PK950lK7Un1"
#define kGtAppSecret @"1IpvDArHL39BeRz91S0i28"

//#define hxAppKey @"tianwang#houseapp"
//#define hxApnsCertName @"EstateClient"

//#define ShareSDKAPPKey @"1c2cc9626bff8"
//#define WXAppID @"wxe4d535875c799224"
//#define WXAppSecret @"bcb8be87145b9f29072995450f2860a9"
//#define BDAPPKey @"N0NQunr7o9ozhlVI5zqOkm347uQ6Zoyi"

/** 快速存储使用工具 */
#define kDocumentsPath            [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES) objectAtIndex:0]

#define kSaveUserConfig(key,data) [[ConfigTool sharedTool] saveUserConfigMsg:key value:[NSKeyedArchiver archivedDataWithRootObject:data]];
#define kReadUserConfig(key)      [NSKeyedUnarchiver unarchiveObjectWithData:[[ConfigTool sharedTool] readUserConfigMsg:key]]

#define kReadAppConfig(key)       [[ConfigTool sharedTool] readUserConfigMsg:key]
#define kDeleteUserConfig(key)    [[ConfigTool sharedTool] deleteUserConfigMsg:key]

#define kReadAppDocuments(key)    [[ConfigTool sharedTool] readUserMsgDocuments:key]
#define kDeleteAppDocuments(key)  [[ConfigTool sharedTool] deleteUserMsgDocuments:key]


/**
 * 用户信息
 *
 * 用来保存用户所有信息，以及用户常用的个别信息
 */
#define kUserId                 @"kUserIdKey"
#define kUserToken              @"kUserTokenKey"
#define kUserModel              @"kUserModelKey"

/**
 * 推送信息
 *
 * 用来保存设备的推送信息（包括本地推送，服务器推送，三方推送）
 */
#define kUserDeviceToken        @"kUserDeviceToken"
#define kUserGeTuiClientId      @"kUserGeTuiClientId"
#define kUserPushModel          @"kUserPushModelKey"
/**
 * 逻辑信息
 *
 * 在操作程序过程中，保存程序的临时数据，以及标记
 */


#endif /* StorageKeyMacro_h */
