//
//  HYVideoConfigHeader.h
//  HYVideoSDK
//
//  Created by oceanMAC on 2023/3/31.
//  Copyright © 2023 admin@buzzmsg.com. All rights reserved.
//

#ifndef HYVideoConfigHeader_h
#define HYVideoConfigHeader_h

#define IS_iPhoneX \
({BOOL isPhoneX = NO;\
if (@available(iOS 11.0, *)) {\
isPhoneX = [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom > 0.0;\
}\
(isPhoneX);})

#endif /* HYVideoConfigHeader_h */
