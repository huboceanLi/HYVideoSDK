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

- (NSString *)categorieString {
    NSString *s = @"";
    for (int i = 0; i < self.categories.count; i++) {
        if ([self isFilter:self.categories[i]]) {
            s = [NSString stringWithFormat:@"%@%@,",s,self.categories[i]];
        }
    }
    if (s.length > 1) {
        return [s substringToIndex:s.length - 1];
    }
    return s;
}

- (BOOL)isFilter:(NSString *)str {
    NSArray *arr = @[@"喜剧",@"爱情",@"动作",@"枪战",@"犯罪",@"惊悚",@"恐怖",@"悬疑",@"动画",@"家庭",@"奇幻",@"魔幻",@"科幻",@"战争",@"青春"];
    if ([arr containsObject:str]) {
        return YES;
    }
    return NO;
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

