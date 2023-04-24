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


+ (id)getMovieListWithStart:(NSInteger)start type:(NSString *)type area:(NSString *)area years:(NSString *)years tags:(NSString *)tags completionHandle:(void(^)(NSArray *model, BOOL success))completed
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
    //https://m.douban.com/rexxar/api/v2/movie/recommend?refresh=0&start=0&count=20&selected_categories=%7B%22类型%22:%22喜剧%22,%22地区%22:%22日本%22%7D&uncollect=false&tags=喜剧,日本,2020年代,科幻&sort=S
    NSDictionary *paramet = @{@"refresh":@"0",@"start":@(start),@"count":@(20),@"selected_categories":categories,@"uncollect":@(NO),@"tags":tagString,@"playable":@(YES),@"sort":@"S"};
    
    return [self GET:API_DouBan_Movie_List parameters:paramet complationHandle:^(id  _Nonnull responseObject, NSError * _Nonnull error) {
        if (!error) {
            
            NSString *josnString = [HYDouBanAFRequestWorking convertToJsonData:responseObject];
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

+(NSString *)convertToJsonData:(NSDictionary *)dict

{

    NSError*error;

    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];

    NSString*jsonString;

    if(!jsonData) {

        NSLog(@"%@",error);

    }else{

        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];

    }

    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];

//    NSRange range = {0,jsonString.length};

//

//    //去掉字符串中的空格

//

//    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];

    NSRange range2 = {0,mutStr.length};

    //去掉字符串中的换行符

    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];

    return mutStr;

}

@end
