//
//  HYDouBanYearsModel.m
//  AFNetworking
//
//  Created by oceanMAC on 2023/4/24.
//

#import "HYDouBanYearsModel.h"

@implementation HYDouBanYearsModel

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"tags" : [HYDouBanYearsItemModel class]};
}

@end

@implementation HYDouBanYearsItemModel

@end
