#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "UIColor+PublicUse.h"
#import "UIImage+sdk_bundleImage.h"
#import "HYVideoBaseViewController.h"
#import "HYVideoTabBarViewController.h"
#import "HYVideoConfigHeader.h"
#import "HYVideoHeader.h"
#import "HYVideoCenterViewController.h"
#import "HYVideoHomeViewController.h"
#import "HYVideoDetailViewController.h"
#import "HYVideoRankViewController.h"

FOUNDATION_EXPORT double HYVideoSDKVersionNumber;
FOUNDATION_EXPORT const unsigned char HYVideoSDKVersionString[];

