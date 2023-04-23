//
//  HYVideoPlayTypeManager.m
//  AFNetworking
//
//  Created by oceanMAC on 2023/4/23.
//

#import "HYVideoPlayTypeManager.h"

static HYVideoPlayTypeManager *manager = nil;

@implementation HYVideoPlayTypeManager

+ (instancetype)shareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [HYVideoPlayTypeManager new];
    });
    return manager;
}

- (NSArray *)getPlayTypeLisy
{
    if (self.playTypeArray.count != 0) {
        return self.playTypeArray;
    }
    

    NSURL *url = [[NSBundle mainBundle] URLForResource:@"playType" withExtension:@"plist"];

    NSArray *arr = [NSArray arrayWithContentsOfURL:url error:nil];
    
    NSMutableArray *lastArray = [NSMutableArray array];
    for (NSDictionary *dic in arr) {
        HYVideoTypeListModel *model = [HYVideoTypeListModel modelWithDictionary:dic];
        [lastArray addObject:model];
    }
    if (lastArray.count > 0) {
        self.playTypeArray = [lastArray mutableCopy];
    }
    return lastArray;
}
@end
