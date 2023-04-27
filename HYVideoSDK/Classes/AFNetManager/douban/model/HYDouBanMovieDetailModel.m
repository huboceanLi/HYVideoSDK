//
//  HYDouBanMovieDetailModel.m
//  HYVideoSDK
//
//  Created by oceanMAC on 2023/4/25.
//

#import "HYDouBanMovieDetailModel.h"

@implementation HYDouBanMovieDetailModel

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"rating" : [HYDouBanMovieItemRateModel class], @"pic" : [HYDouBanMovieItemPicModel class], @"actors" : [HYDouBanMovieDetailActorsModel class], @"vendors" : [HYDouBanMovieDetailVendorsModel class], @"directors" : [HYDouBanMovieDetailActorsModel class]};
}

- (NSString *)pubdateString {
    NSString *s = @"";
    if (self.pubdate.count > 0) {
        for (int i = 0; i < self.pubdate.count; i++) {
            s = [NSString stringWithFormat:@"%@%@/",s,self.pubdate[i]];
        }
    }
    if (s.length > 1) {
        return [s substringToIndex:s.length - 1];
    }
    return s;
}
- (NSString *)languageString {
    NSString *s = @"";
    if (self.languages.count > 0) {
        for (int i = 0; i < self.languages.count; i++) {
            s = [NSString stringWithFormat:@"%@%@/",s,self.languages[i]];
        }
    }
    if (s.length > 1) {
        return [s substringToIndex:s.length - 1];
    }
    return s;
}

- (NSString *)genreString {
    NSString *s = @"";
    if (self.genres.count > 0) {
        for (int i = 0; i < self.genres.count; i++) {
            s = [NSString stringWithFormat:@"%@%@ /",s,self.genres[i]];
        }
    }
    if (s.length > 1) {
        return [s substringToIndex:s.length - 1];
    }
    return s;
}

- (NSString *)durationString {
    if (self.durations.count > 0) {
        return self.durations.firstObject;
    }
    return @"";
}

- (NSString *)directorString {
    NSString *s = @"";
    if (self.directors.count > 0) {
        for (int i = 0; i < self.directors.count; i++) {
            s = [NSString stringWithFormat:@"%@%@/",s,self.directors[i].name];
        }
    }
    if (s.length > 1) {
        return [s substringToIndex:s.length - 1];
    }
    return s;
}

- (NSString *)actorString {
    NSString *s = @"";
    if (self.actors.count > 0) {
        for (int i = 0; i < self.actors.count; i++) {
            if (i <= 7) {
                s = [NSString stringWithFormat:@"%@%@ /",s,self.actors[i].name];
            }else {
                s = [s substringToIndex:s.length - 1];
                s = [NSString stringWithFormat:@"%@.../",s];
                break;
            }
        }
    }
    if (s.length > 1) {
        return [s substringToIndex:s.length - 1];
    }
    return s;
}

- (BOOL)isMovie {
    if (self.episodes_count > 0) {
        return false;
    }
    return YES;
}
@end

@implementation HYDouBanMovieDetailActorsModel

@end

@implementation HYDouBanMovieDetailVendorsModel

@end
