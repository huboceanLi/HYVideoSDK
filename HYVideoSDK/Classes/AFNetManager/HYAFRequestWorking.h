//
//  HYAFRequestWorking.h
//  HYVideoSDK
//
//  Created by oceanMAC on 2023/4/11.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "HYAFNetBaseRequset.h"

NS_ASSUME_NONNULL_BEGIN

@interface HYAFRequestWorking : HYAFNetBaseRequset

+ (id)getMovieListWithPage:(NSInteger)page completionHandle:(void(^)(NSArray *model, BOOL success))completed;

@end

NS_ASSUME_NONNULL_END
