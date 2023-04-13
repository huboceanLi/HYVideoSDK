//
//  HYAFRequestWorking.m
//  HYVideoSDK
//
//  Created by oceanMAC on 2023/4/11.
//

#import "HYAFRequestWorking.h"
#import "HYAPIString.h"

@implementation HYAFRequestWorking

+ (id)getMovieListWithPage:(NSInteger)page completionHandle:(void(^)(NSArray *model, BOOL success))completed
{
    //https://pcw-api.iqiyi.com/search/recommend/list?channel_id=1&data_type=1&mode=11&page_id=1&ret_num=48&session=ee4d98ebb4e8e44c8d4b14fa90615fb7
    
    NSDictionary *dic = @{@"ret_num":@(48),@"channel_id":@(1), @"data_type":@(1),@"mode":@(11),@"session":@"ee4d98ebb4e8e44c8d4b14fa90615fb7",@"page_id":@(page)};
    return [self GET:API_Movie_List parameters:dic complationHandle:^(id  _Nonnull responseObject, NSError * _Nonnull error) {
        if (!error) {
            HYMovieListModel *model = [HYMovieListModel modelWithDictionary:responseObject];
            if (model.data.list.count > 0) {
                completed(model.data.list, YES);
            }else {
                completed(nil, NO);
            }
        }else {
            completed(nil, NO);
        }
    }];
}


@end
