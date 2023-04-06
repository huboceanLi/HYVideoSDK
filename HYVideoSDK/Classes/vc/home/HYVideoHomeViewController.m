//
//  HYVideoHomeViewController.m
//  HYVideoSDK_Example
//
//  Created by oceanMAC on 2023/3/31.
//  Copyright © 2023 admin@buzzmsg.com. All rights reserved.
//

#import "HYVideoHomeViewController.h"
#import "HYVideoDetailViewController.h"
#import "HYVideoUpgradeViewController.h"

#import "TFHpple.h"
#import "TFHppleElement.h"
#import "XPathQuery.h"

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
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn1 setTitle:@"升级弹框" forState:0];
    [btn1 setTitleColor:UIColor.whiteColor forState:0];
    btn1.backgroundColor = UIColor.redColor;
    btn1.frame = CGRectMake(100, 280, 100, 40);
    [self.view addSubview:btn1];
    [btn1 addTarget:self action:@selector(upgradebuttonClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn2 setTitle:@"数据解析" forState:0];
    [btn2 setTitleColor:UIColor.whiteColor forState:0];
    btn2.backgroundColor = UIColor.redColor;
    btn2.frame = CGRectMake(100, 360, 100, 40);
    [self.view addSubview:btn2];
    [btn2 addTarget:self action:@selector(htmlbuttonClick) forControlEvents:UIControlEventTouchUpInside];
}

- (void)buttonClick {
    HYVideoDetailViewController *vc = [HYVideoDetailViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)upgradebuttonClick {
    
    HYVideoUpgradeViewController *vc = [HYVideoUpgradeViewController new];
    [vc showWithAnimated:YES completion:nil];
}

- (void)htmlbuttonClick {
    NSURL *url = [NSURL URLWithString:@"https://list.iqiyi.com/www/1/-------------11-1-1-iqiyi--.html"];
    NSData *htmlData = [[NSData alloc]initWithContentsOfURL:url];
    TFHpple *xpathParser = [[TFHpple alloc]initWithHTMLData:htmlData];

//    NSArray *itemArray = [xpathParser searchWithXPathQuery:@"//div[@class='qy-mod-link-wrap']//img"];
//    NSArray *itemArray = [xpathParser searchWithXPathQuery:@"//img[@class='qy-mod-cover']"];
    NSArray *itemArray = [xpathParser searchWithXPathQuery:@"//li[@class='qy-mod-li']"];
//    NSArray *itemArray = [xpathParser searchWithXPathQuery:@"//img[@class='qy-mod-cover fadeOutIn-enter-active']"];

    
    NSMutableArray *content = [NSMutableArray array];
    for (TFHppleElement *hppleElement in itemArray) {
//        NSArray *childrens = hppleElement.children;
        NSString *raw = hppleElement.raw;
        if (raw.length > 0) {
//            NSArray *itemArray1 = [xpathParser searchWithXPathQuery:@"//div[@class='qy-mod-link-wrap']"];

            [content addObject:raw];
        }

//        for (int i = 0; i < childrens.count; i++) {
//            TFHppleElement *currentItem = childrens[i];
//            NSString *nodeName = currentItem.tagName;
//
//            NSLog(@"currentItem = %@",currentItem.content);
//        }
    }
    
    if (content.count > 0) {
        [self getContent:content];
        return;
    }
    
    
    NSLog(@"没有数据");
}

- (void)getContent:(NSArray *)raws {
    
    NSData *htmlData = [[NSData alloc]initWithBase64EncodedString:raws[0] options:nil];
    TFHpple *xpathParser = [[TFHpple alloc]initWithHTMLData:htmlData];

//    NSArray *itemArray = [xpathParser searchWithXPathQuery:@"//div[@class='qy-mod-link-wrap']//img"];
//    NSArray *itemArray = [xpathParser searchWithXPathQuery:@"//img[@class='qy-mod-cover']"];
    NSArray *itemArray = [xpathParser searchWithXPathQuery:@"//div[@class='qy-mod-link-wrap']"];
}

@end
