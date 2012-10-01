//
//  Defs.h
//  EconApps
//
//  Created by Thomas Langford on 9/7/12.
//  Copyright (c) 2012 High Point Univeristy. All rights reserved.
//

#ifndef EconApps_Defs_h
#define EconApps_Defs_h

typedef enum  MODULES {
    kPUBLIC_GOODS_MODULE = 1,
    kPIT_MARKET_MODULE = 2,
} MODULES;

typedef enum LOGIN_VIEW_CODES {
    kVALID_LOGIN = 0,
    KINVALID_USERNAME = 1,
    KINVALID_PASSWORD = 2,
} LOGIN_VIEW_CODES;

typedef enum TABLE_STYLE {
    kUNIFORM = 0,
    kNON_UNIFORM = 1,
} TABLE_STYLE;

#pragma mark - Database Info

#define kDATABASE_NAME @"econapps_db"
#define kDATABASE_USER @"econuser"
#define kDATABASE_PASS @"Q!W@E#R$T%"

#pragma mark - Server URL's

#define kSERVER_URL @"http://10.2.96.19/"

#define kLOGIN_VIEW_URL kSERVER_URL@"login.php"
#define kWAITING_VIEW_URL @"http://linus.highpoint.edu/~tlangford/econApps/waiting_test.php"
#define kSEND_TOKENS_URL @"http://linus.highpoint.edu/~tlangford/econApps/tokenSend_test.php"

#pragma mark - Polling Intervals

#define kWAITING_POLLING_INTERVAL 3 //Every x seconds
#define kPUBLIC_GOODS_POLLING_INTERVAL 1

#endif
