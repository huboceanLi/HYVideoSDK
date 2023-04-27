//
//  HYDouBanMovieListModel.h
//  HYVideoSDK
//
//  Created by oceanMAC on 2023/4/25.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class HYDouBanMovieCategoriesListModel, HYDouBanMovieCategoriesItemModel, HYDouBanMovieItemModel, HYDouBanMovieItemRateModel, HYDouBanMovieItemPicModel, HYDouBanMovieItemTagsModel;

@interface HYDouBanMovieListModel : NSObject

@property (nonatomic, assign) NSInteger count;
@property (nonatomic, strong) NSArray <HYDouBanMovieCategoriesListModel *>*recommend_categories;
@property (nonatomic, strong) NSArray <HYDouBanMovieItemModel *>*items;

@end

//recommend_categories
@interface HYDouBanMovieCategoriesListModel : NSObject

@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSArray <HYDouBanMovieCategoriesItemModel *>*data;

@end

@interface HYDouBanMovieCategoriesItemModel : NSObject

@property (nonatomic, strong) NSString *text;

@end


@interface HYDouBanMovieItemModel : NSObject

@property (nonatomic, strong) HYDouBanMovieItemRateModel *rating;
@property (nonatomic, strong) HYDouBanMovieItemPicModel *pic;
@property (nonatomic, strong) NSString *year;
@property (nonatomic, strong) NSString *card_subtitle;
@property (nonatomic, strong) NSString *ID;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSArray <HYDouBanMovieItemTagsModel *>*tags;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *uri;

@end

@interface HYDouBanMovieItemRateModel : NSObject

@property (nonatomic, assign) CGFloat value;
@property (nonatomic, assign) NSInteger count;

@end

@interface HYDouBanMovieItemPicModel : NSObject

@property (nonatomic, strong) NSString *large;
@property (nonatomic, strong) NSString *normal;

@end

@interface HYDouBanMovieItemTagsModel : NSObject

@property (nonatomic, strong) NSString *name;

@end

NS_ASSUME_NONNULL_END
