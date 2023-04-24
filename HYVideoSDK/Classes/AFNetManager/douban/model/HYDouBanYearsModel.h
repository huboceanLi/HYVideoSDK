//
//  HYDouBanYearsModel.h
//  AFNetworking
//
//  Created by oceanMAC on 2023/4/24.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class HYDouBanYearsItemModel;

@interface HYDouBanYearsModel : NSObject

@property (nonatomic, strong) NSArray <HYDouBanYearsItemModel *>*tags;

@end

@interface HYDouBanYearsItemModel : NSObject

@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSArray *tags;

@end


NS_ASSUME_NONNULL_END
