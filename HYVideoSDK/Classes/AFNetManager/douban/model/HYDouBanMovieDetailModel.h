//
//  HYDouBanMovieDetailModel.h
//  HYVideoSDK
//
//  Created by oceanMAC on 2023/4/25.
//

#import <Foundation/Foundation.h>
#import "HYVideoHeader.h"

NS_ASSUME_NONNULL_BEGIN

@class HYDouBanMovieDetailActorsModel, HYDouBanMovieDetailVendorsModel;

@interface HYDouBanMovieDetailModel : NSObject

@property (nonatomic, strong) HYDouBanMovieItemRateModel *rating;
@property (nonatomic, strong) NSArray *pubdate;
@property (nonatomic, strong) NSString *pubdateString;
@property (nonatomic, strong) HYDouBanMovieItemPicModel *pic;
@property (nonatomic, strong) NSString *year;
@property (nonatomic, strong) NSString *card_subtitle;
@property (nonatomic, strong) NSArray *languages;
@property (nonatomic, strong) NSString *languageString;
@property (nonatomic, strong) NSArray *genres;
@property (nonatomic, strong) NSString *genreString;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *intro;
@property (nonatomic, strong) NSString *type; //"type": "tv","type": "movie",
@property (nonatomic, strong) NSArray *durations;
@property (nonatomic, strong) NSString *durationString;
@property (nonatomic, strong) NSArray <HYDouBanMovieDetailActorsModel *>*directors;
@property (nonatomic, strong) NSString *directorString;
@property (nonatomic, strong) NSArray <HYDouBanMovieDetailActorsModel *>*actors;
@property (nonatomic, strong) NSString *actorString;
@property (nonatomic, strong) NSArray <HYDouBanMovieDetailVendorsModel *>*vendors;
@property (nonatomic, assign) NSInteger episodes_count;
@property (nonatomic, assign) BOOL isMovie;

@end

@interface HYDouBanMovieDetailVendorsModel : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *url;

@end

@interface HYDouBanMovieDetailActorsModel : NSObject

@property (nonatomic, strong) NSString *name;

@end
NS_ASSUME_NONNULL_END
