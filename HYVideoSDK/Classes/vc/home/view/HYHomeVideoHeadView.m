//
//  HYHomeVideoHeadView.m
//  HYVideoSDK
//
//  Created by oceanMAC on 2023/4/24.
//

#import "HYHomeVideoHeadView.h"
#import "HYHomeCategeryView.h"

@interface HYHomeVideoHeadView()

@property (nonatomic, strong) HYHomeCategeryView *typeView;
@property (nonatomic, strong) HYHomeCategeryView *areaView;
@property (nonatomic, strong) HYHomeCategeryView *yearsView;

@property (nonatomic, strong) NSArray *yearsArray;
@property (nonatomic, strong) NSArray *typeArray;
@property (nonatomic, strong) NSArray *areaArray;

@property (copy, nonatomic) void (^headHeightCompletion)(CGFloat headHeight);
@property (copy, nonatomic) void (^movieListCompletion)(NSArray *list);

@end

@implementation HYHomeVideoHeadView

- (void)initSubviews {
    [super initSubviews];
    
    self.backgroundColor = UIColor.redColor;
    
    self.typeView = [HYHomeCategeryView new];
    [self addSubview:self.typeView];
    
    [self.typeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self);
        make.height.mas_equalTo(40);
    }];

    self.areaView = [HYHomeCategeryView new];
    [self addSubview:self.areaView];
    
    [self.areaView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.height.mas_equalTo(40);
        make.top.equalTo(self.typeView.mas_bottom).offset(0);
    }];
    
    self.yearsView = [HYHomeCategeryView new];
    [self addSubview:self.yearsView];
    
    [self.yearsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.height.mas_equalTo(40);
        make.top.equalTo(self.areaView.mas_bottom).offset(0);
    }];
    
    [self getFillterList];
}

- (void) getMovieList {
    __weak typeof(self) _self = self;
    [HYDouBanAFRequestWorking getMovieListWithStart:0 type:@"全部" area:@"全部" years:@"全部" tags:@"全部" completionHandle:^(HYDouBanMovieListModel * _Nonnull model, BOOL success) {
        if (success) {
            _self.movieListBlock(model.items);
//            self.movieListCompletion(model.items);
            
            if (model.recommend_categories.count > 0) {
                HYDouBanMovieCategoriesListModel *typeModel = model.recommend_categories.firstObject;
                if (typeModel.data.count > 0) {
                    NSMutableArray *array = [NSMutableArray array];
                    for (HYDouBanMovieCategoriesItemModel *item in typeModel.data) {
                        [array addObject:item.text];
                    }
                    _self.typeArray = [array mutableCopy];
                }else {
                    _self.typeArray = @[];
                }
                
                if (model.recommend_categories.count >= 2) {
                    HYDouBanMovieCategoriesListModel *areaModel = model.recommend_categories[1];
                    if (areaModel.data.count > 0) {

                        NSMutableArray *array = [NSMutableArray array];
                        
                        for (HYDouBanMovieCategoriesItemModel *item in areaModel.data) {
                            [array addObject:item.text];
                        }
                        _self.areaArray = [array mutableCopy];

                    }
                }else {
                    _self.areaArray = @[];
                }
                [_self addYears];
                [_self addType];
                [_self addArea];

            }else {
                [_self addYears];
                _self.areaView.hidden = YES;
                [_self.areaView mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.height.mas_equalTo(0);
                }];
                
                _self.typeView.hidden = YES;
                [_self.typeView mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.height.mas_equalTo(0);
                }];
            }
        }
    }];
}

- (void)getFillterList {
    
    __weak typeof(self) _self = self;
    [HYDouBanAFRequestWorking getFillterListCompletionHandle:^(NSArray * _Nonnull tags, BOOL success) {
        if (success) {
            if (tags.count >= 1) {
                HYDouBanYearsItemModel *typeModel = tags.firstObject;
                
                _self.yearsArray = typeModel.tags;
                [_self getMovieList];
            }
        }
    }];
}

- (void)addYears {
    if (self.yearsArray.count > 0) {
        self.yearsView.hidden = NO;
        [self.yearsView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(40);
        }];
        self.yearsView.data = self.yearsArray;
        [self.yearsView loadContent];
    }else {
        self.yearsView.hidden = YES;
        [self.yearsView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0);
        }];
    }
    [self getHeight];
}

- (void)addType {
    if (self.typeArray.count > 0) {
        self.typeView.hidden = NO;
        [self.typeView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(40);
        }];
        self.typeView.data = self.typeArray;
        [self.typeView loadContent];
        
    }else {
        self.typeView.hidden = YES;
        [self.typeView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0);
        }];
    }
    [self getHeight];
}

- (void)addArea {
    if (self.areaArray.count > 0) {
        self.areaView.hidden = NO;
        [self.areaView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(40);
        }];
        self.areaView.data = self.areaArray;
        [self.areaView loadContent];
    }else {
        self.areaView.hidden = YES;
        [self.areaView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0);
        }];
    }
    [self getHeight];
}

- (void)getHeight {
    CGFloat h = 0.0;
    
    if (self.typeArray.count > 0) {
        h = 40.0;
    }
    
    if (self.areaArray.count > 0) {
        h = 40.0 + h;
    }
    
    if (self.yearsArray.count > 0) {
        h = 40.0 + h;
    }
    self.headHeightBlock(h);
}

@end
