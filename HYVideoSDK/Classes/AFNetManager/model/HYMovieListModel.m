//
//  HYMovieListModel.m
//  HYVideoSDK
//
//  Created by oceanMAC on 2023/4/13.
//

#import "HYMovieListModel.h"

@implementation HYMovieListModel

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"data" : [HYMovieListDataModel class]};
}

@end

@implementation HYMovieListDataModel

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"list" : [HYMovieListItemModel class]};
}

@end


@implementation HYMovieListItemModel

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"people" : [HYMovieListPeopleModel class]};
}

+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"des":@"description"};
}

@end


@implementation HYMovieListPeopleModel

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"main_charactor" : [HYMovieListPeopleItemModel class]};
}

@end


@implementation HYMovieListPeopleItemModel

+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"ID":@"id"};
}

@end

