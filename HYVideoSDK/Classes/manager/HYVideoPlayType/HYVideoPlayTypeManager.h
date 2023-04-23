//
//  HYVideoPlayTypeManager.h
//  AFNetworking
//
//  Created by oceanMAC on 2023/4/23.
//

#import <Foundation/Foundation.h>
#import "HYVideoHeader.h"

NS_ASSUME_NONNULL_BEGIN

@interface HYVideoPlayTypeManager : NSObject

+ (instancetype)shareInstance;

@property(strong,nonatomic)NSArray *playTypeArray;

- (NSArray *)getPlayTypeLisy;

@end

NS_ASSUME_NONNULL_END
