//
//  HYVideoTabBarViewController.m
//  HYVideoSDK_Example
//
//  Created by oceanMAC on 2023/3/31.
//  Copyright © 2023 admin@buzzmsg.com. All rights reserved.
//

#import "HYVideoTabBarViewController.h"
#import "HYVideoHomeViewController.h"
#import "HYVideoRankViewController.h"
#import "HYVideoCenterViewController.h"
#import "HYVideoHeader.h"
#import "UIImage+sdk_bundleImage.h"
#import "HYHomeMovieViewController.h"

#import "HYTestViewController.h"

@interface HYVideoTabBarViewController ()

@end

@implementation HYVideoTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[UITabBar appearance]setTintColor:[UIColor mainColor]];
    
    [[UITabBar appearance] setTranslucent:YES];
    
    HYHomeMovieViewController *VC1 = [[HYHomeMovieViewController alloc] init];
    [VC1.tabBarItem setImage:[[UIImage sdk_bundleImage:@"ai2351"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [VC1.tabBarItem setSelectedImage:[[UIImage sdk_bundleImage:@"ai235"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    VC1.tabBarItem.title = @"视频";

    HYVideoRankViewController *VC2 = [[HYVideoRankViewController alloc] init];
    [VC2.tabBarItem setImage:[[UIImage sdk_bundleImage:@"wodefill1"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [VC2.tabBarItem setSelectedImage:[[UIImage sdk_bundleImage:@"wodefill"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    VC2.tabBarItem.title = @"排行";
    
    HYVideoCenterViewController *VC3 = [[HYVideoCenterViewController alloc] init];
    [VC3.tabBarItem setImage:[[UIImage sdk_bundleImage:@"wodefill1"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [VC3.tabBarItem setSelectedImage:[[UIImage sdk_bundleImage:@"wodefill"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    VC3.tabBarItem.title = @"我的";
    
    HYTestViewController *VC4 = [[HYTestViewController alloc] init];
    [VC4.tabBarItem setImage:[[UIImage sdk_bundleImage:@"wodefill1"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [VC4.tabBarItem setSelectedImage:[[UIImage sdk_bundleImage:@"wodefill"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    VC4.tabBarItem.title = @"测试";
    
    self.viewControllers = @[VC1, VC2, VC3, VC4];
        
    if (@available(iOS 15.0, *)) {
        self.tabBar.scrollEdgeAppearance = self.tabBar.standardAppearance;
    }
    [self setTabbarBackGround];
}

- (void)setTabbarBackGround{
    if (@available(iOS 13.0, *)) {
        UITabBarAppearance *appearance = [self.tabBar.standardAppearance copy];
        appearance.backgroundImage = [self createImageWithColor:[UIColor clearColor]];
        appearance.shadowImage = [self createImageWithColor:[UIColor clearColor]];

        //下面这行代码最关键
        [appearance configureWithTransparentBackground];
        self.tabBar.standardAppearance = appearance;
    
    } else {
        [self.tabBar setBackgroundImage:[self createImageWithColor:[UIColor clearColor]]];
        [self.tabBar setShadowImage:[self createImageWithColor:[UIColor clearColor]]];
    }
}

-(UIImage*) createImageWithColor:(UIColor*) color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
