//
//  HYMovieListModel.h
//  HYVideoSDK
//
//  Created by oceanMAC on 2023/4/13.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class HYMovieListDataModel,HYMovieListItemModel,HYMovieListPeopleModel,HYMovieListPeopleItemModel;

@interface HYMovieListModel : NSObject

@property (nonatomic, strong) NSString *code;
@property (nonatomic, strong) HYMovieListDataModel *data;

@end

@interface HYMovieListDataModel : NSObject

@property (nonatomic, strong) NSArray <HYMovieListItemModel *>*list;

@end

@interface HYMovieListItemModel : NSObject

@property (nonatomic, assign) NSInteger tvId;
@property (nonatomic, assign) NSInteger albumId;
@property (nonatomic, strong) NSString *des;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *playUrl;
@property (nonatomic, strong) NSString *payMarkUrl;
@property (nonatomic, strong) NSString *imageUrl;
@property (nonatomic, strong) NSString *duration;
@property (nonatomic, assign) NSInteger videoCount;
@property (nonatomic, strong) NSString *period;
@property (nonatomic, strong) NSString *focus;
@property (nonatomic, assign) double score;
@property (nonatomic, strong) HYMovieListPeopleModel *people;

@end

@interface HYMovieListPeopleModel : NSObject


@property (nonatomic, strong) NSArray <HYMovieListPeopleItemModel *>*main_charactor;


@end

@interface HYMovieListPeopleItemModel : NSObject


@property (nonatomic, assign) NSInteger ID;
@property (nonatomic, strong) NSString *name;


@end

NS_ASSUME_NONNULL_END
