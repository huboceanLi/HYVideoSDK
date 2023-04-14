//
//  HYWebVideoViewController.h
//  HYVideoSDK
//
//  Created by oceanMAC on 2023/4/13.
//

#import <HYBaseTool/HYBaseTool.h>
#import "HYVideoBaseViewController.h"
#import "HYVideoHeader.h"

NS_ASSUME_NONNULL_BEGIN

@interface HYWebVideoViewController : HYVideoBaseViewController

@property (nonatomic, strong) HYMovieListItemModel *movieModel;

@property (nonatomic, strong) NSArray *list;

@end

NS_ASSUME_NONNULL_END
