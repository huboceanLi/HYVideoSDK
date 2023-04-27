//
//  HYHomeVideoHeadView.h
//  HYVideoSDK
//
//  Created by oceanMAC on 2023/4/24.
//

#import <UIKit/UIKit.h>
#import <HYBaseTool/HYBaseTool.h>
#import "HYVideoHeader.h"

NS_ASSUME_NONNULL_BEGIN

@interface HYHomeVideoHeadView : HYBaseView

@property (copy, nonatomic) void (^headHeightBlock)(CGFloat headHeight);

@property (copy, nonatomic) void (^movieListBlock)(NSArray *list);

@end

NS_ASSUME_NONNULL_END
