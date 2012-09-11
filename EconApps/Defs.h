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
    kPUBLIC_GOODS_MODULE = 0,
    kPIT_MARKET_MODULE = 1,
} MODULES;

typedef enum LOGIN_VIEW_CODES {
    kVALID_LOGIN = 0,
    KINVALID_USERNAME = 1,
    KINVALID_PASSWORD = 2,
} LOGIN_VIEW_CODES;

#define kDATABASE_NAME @"econapps_db"
#define kDATABASE_USER @"econuser"
#define kDATABASE_PASS @"Q!W@E#R$T%"

#define kSERVER_URL @"http://linus.highpoint.edu/~tlangford/econApps/test.php"

#endif
