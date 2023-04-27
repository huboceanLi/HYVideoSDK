//
//  HYDouBanMovieListModel.m
//  HYVideoSDK
//
//  Created by oceanMAC on 2023/4/25.
//

#import "HYDouBanMovieListModel.h"

@implementation HYDouBanMovieListModel

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"recommend_categories" : [HYDouBanMovieCategoriesListModel class], @"items" : [HYDouBanMovieItemModel class]};
}

@end

@implementation HYDouBanMovieCategoriesListModel

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"data" : [HYDouBanMovieCategoriesItemModel class]};
}

@end

@implementation HYDouBanMovieCategoriesItemModel



@end

@implementation HYDouBanMovieItemModel

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"rating" : [HYDouBanMovieItemRateModel class], @"pic" : [HYDouBanMovieItemPicModel class], @"tags" : [HYDouBanMovieItemTagsModel class]};
}

+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"ID":@"id"};
}

@end

@implementation HYDouBanMovieItemRateModel

@end

@implementation HYDouBanMovieItemPicModel

@end

@implementation HYDouBanMovieItemTagsModel

@end

