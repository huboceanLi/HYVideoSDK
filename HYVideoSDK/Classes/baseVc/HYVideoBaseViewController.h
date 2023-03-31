//
//  HYVideoBaseViewController.h
//  HYVideoSDK_Example
//
//  Created by oceanMAC on 2023/3/31.
//  Copyright © 2023 admin@buzzmsg.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HYVideoHeader.h"

NS_ASSUME_NONNULL_BEGIN

@interface HYVideoBaseViewController : UIViewController

@property(strong,nonatomic)UIView *navBar;
@property(strong,nonatomic) UIButton *navBackButton;
@property(strong,nonatomic) UILabel *navTitleLabel;

- (void)clickedBackButton:(UIButton *)sender;

@end

NS_ASSUME_NONNULL_END
