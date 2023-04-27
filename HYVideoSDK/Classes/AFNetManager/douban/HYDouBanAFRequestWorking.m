//
//  HYDouBanAFRequestWorking.m
//  HYVideoSDK
//
//  Created by oceanMAC on 2023/4/24.
//

#import "HYDouBanAFRequestWorking.h"
#import "HYAPIString.h"

@implementation HYDouBanAFRequestWorking

//douban
+ (id)getFillterListCompletionHandle:(void(^)(NSArray *tags, BOOL success))completed
{
    return [self GET:API_Fillter_List parameters:@{} complationHandle:^(id  _Nonnull responseObject, NSError * _Nonnull error) {
        if (!error) {
            HYDouBanYearsModel *model = [HYDouBanYearsModel modelWithDictionary:responseObject];
            if (model.tags.count > 0) {
                completed(model.tags, YES);
            }else {
                completed(nil, NO);
            }
        }else {
            completed(nil, NO);
        }
    }];
}


+ (id)getMovieListWithStart:(NSInteger)start type:(NSString *)type area:(NSString *)area years:(NSString *)years tags:(NSString *)tags completionHandle:(void(^)(HYDouBanMovieListModel *model, BOOL success))completed
{
    NSMutableArray *tagList = [NSMutableArray array];
    NSMutableDictionary *categories = [NSMutableDictionary dictionary];
    if (![type isEqualToString:@"全部"]) {
        [categories setObject:type forKey:@"类型"];
        [tagList addObject:type];
    }
    if (![area isEqualToString:@"全部"]) {
        [categories setObject:area forKey:@"地区"];
        [tagList addObject:area];
    }
    if (![years isEqualToString:@"全部"]) {
        [tagList addObject:years];
    }
    
    if (![tags isEqualToString:@"全部"]) {
        [tagList addObject:tags];
    }
    
    NSString *tagString = @"";
    
    for (int i = 0; i < tagList.count; i++) {
        if (i == 0) {
            tagString = tagList[i];
        }else {
            tagString = [NSString stringWithFormat:@"%@,%@",tagString,tagList[i]];
        }
    }
    NSDictionary *paramet = @{@"refresh":@"0",@"start":@(start),@"count":@(20),@"selected_categories":categories,@"uncollect":@(NO),@"tags":tagString,@"playable":@(YES),@"sort":@"S"};
    
    return [self GET:API_DouBan_Movie_List parameters:paramet complationHandle:^(id  _Nonnull responseObject, NSError * _Nonnull error) {
        if (!error) {
            HYDouBanMovieListModel *model = [HYDouBanMovieListModel modelWithDictionary:responseObject];
            completed(model, YES);
        }else {
            completed(nil, NO);
        }
    }];
}

+ (id)getMovieDetailWithId:(NSString *)ID completionHandle:(void(^)(HYDouBanMovieDetailModel *model, BOOL success))completed
{
    NSString *url = [NSString stringWithFormat:@"%@%@",API_DouBan_Movie_Detail,ID];
    return [self GET:url parameters:@{} complationHandle:^(id  _Nonnull responseObject, NSError * _Nonnull error) {
        if (!error) {
            HYDouBanMovieDetailModel *model = [HYDouBanMovieDetailModel modelWithDictionary:responseObject];
            completed(model, YES);
        }else {
            completed(nil, NO);
        }
    }];
}


@end
