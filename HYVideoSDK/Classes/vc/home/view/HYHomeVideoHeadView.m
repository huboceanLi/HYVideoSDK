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
@property (nonatomic, strong) HYHomeCategeryView *tagsView;
@property (nonatomic, strong) HYHomeCategeryView *areaView;
@property (nonatomic, strong) HYHomeCategeryView *yearsView;

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
    
    self.tagsView = [HYHomeCategeryView new];
    [self addSubview:self.tagsView];
    
    [self.tagsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.height.mas_equalTo(40);
        make.top.equalTo(self.typeView.mas_bottom).offset(0);
    }];
    
    self.areaView = [HYHomeCategeryView new];
    [self addSubview:self.areaView];
    
    [self.areaView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.height.mas_equalTo(40);
        make.top.equalTo(self.tagsView.mas_bottom).offset(0);
    }];
    
    self.yearsView = [HYHomeCategeryView new];
    [self addSubview:self.yearsView];
    
    [self.yearsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.height.mas_equalTo(40);
        make.top.equalTo(self.areaView.mas_bottom).offset(0);
    }];
    
    __weak typeof(self) _self = self;
    [HYDouBanAFRequestWorking getFillterListCompletionHandle:^(NSArray * _Nonnull tags, BOOL success) {
        if (success) {
            if (tags.count == 1) {
                _self.tagsView.hidden = YES;
                [_self.tagsView mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.height.mas_equalTo(0);
                }];
                HYDouBanYearsItemModel *model = tags.firstObject;
                if (model.tags.count > 0) {
                    _self.typeView.hidden = NO;
                    [_self.typeView mas_updateConstraints:^(MASConstraintMaker *make) {
                        make.height.mas_equalTo(40);
                    }];

                    _self.typeView.data = model.tags;
                    [_self.typeView loadContent];
                }else {
                    _self.typeView.hidden = YES;
                    [_self.typeView mas_updateConstraints:^(MASConstraintMaker *make) {
                        make.height.mas_equalTo(0);
                    }];
                }
            }else if (tags.count >= 2) {
                HYDouBanYearsItemModel *typeModel = tags.firstObject;
                if (typeModel.tags.count > 0) {
                    _self.typeView.hidden = NO;
                    [_self.typeView mas_updateConstraints:^(MASConstraintMaker *make) {
                        make.height.mas_equalTo(40);
                    }];
                    _self.typeView.data = typeModel.tags;
                    [_self.typeView loadContent];
                }else {
                    _self.typeView.hidden = YES;
                    [_self.typeView mas_updateConstraints:^(MASConstraintMaker *make) {
                        make.height.mas_equalTo(0);
                    }];
                }
                
                HYDouBanYearsItemModel *tagsModel = tags[1];
                if (tagsModel.tags.count > 0) {
                    _self.tagsView.hidden = NO;
                    [_self.tagsView mas_updateConstraints:^(MASConstraintMaker *make) {
                        make.height.mas_equalTo(40);
                    }];
                    
                    
                    NSMutableArray *a = [tagsModel.tags mutableCopy];
                    
                    if (![a containsObject:@"全部"]) {
                        [a insertObject:@"全部" atIndex:0];
                    }
                    
                    _self.tagsView.data = a;
                    [_self.tagsView loadContent];
                }else {
                    _self.tagsView.hidden = YES;
                    [_self.tagsView mas_updateConstraints:^(MASConstraintMaker *make) {
                        make.height.mas_equalTo(0);
                    }];
                }
            }
        }
    }];
}

//- (BOOL)
@end
