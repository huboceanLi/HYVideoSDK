//
//  HYDouBanAFRequestWorking.h
//  HYVideoSDK
//
//  Created by oceanMAC on 2023/4/24.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "HYDouBanAFNetBaseRequset.h"
#import "HYVideoHeader.h"

NS_ASSUME_NONNULL_BEGIN

@interface HYDouBanAFRequestWorking : HYDouBanAFNetBaseRequset

//douban
+ (id)getFillterListCompletionHandle:(void(^)(NSArray *tags, BOOL success))completed;

+ (id)getMovieListWithStart:(NSInteger)start type:(NSString *)type area:(NSString *)area years:(NSString *)years tags:(NSString *)tags completionHandle:(void(^)(NSArray *model, BOOL success))completed;

@end

NS_ASSUME_NONNULL_END
