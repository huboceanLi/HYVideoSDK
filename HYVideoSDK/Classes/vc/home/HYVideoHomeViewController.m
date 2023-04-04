//
//  HYVideoHomeViewController.m
//  HYVideoSDK_Example
//
//  Created by oceanMAC on 2023/3/31.
//  Copyright © 2023 admin@buzzmsg.com. All rights reserved.
//

#import "HYVideoHomeViewController.h"
#import "HYVideoDetailViewController.h"

@interface HYVideoHomeViewController ()

@end

@implementation HYVideoHomeViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.hidesBottomBarWhenPushed = NO;
    self.tabBarController.tabBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"播放视频" forState:0];
    [btn setTitleColor:UIColor.whiteColor forState:0];
    btn.backgroundColor = UIColor.redColor;
    btn.frame = CGRectMake(100, 200, 100, 40);
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)buttonClick {
    HYVideoDetailViewController *vc = [HYVideoDetailViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
