//
//  HYTestViewController.m
//  CocoaAsyncSocket
//
//  Created by oceanMAC on 2023/4/10.
//

#import "HYTestViewController.h"
#import "HYVideoDetailViewController.h"
#import "HYVideoUpgradeViewController.h"
#import "TFHpple.h"
#import "TFHppleElement.h"
#import "XPathQuery.h"

@interface HYTestViewController ()

@end

@implementation HYTestViewController

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
//    NSURL *url = [NSURL URLWithString:@"https://search.douban.com/movie/subject_search?search_text=%E7%8B%82%E9%A3%99&cat=1002"];


    NSData *htmlData = [[NSData alloc]initWithContentsOfURL:url];
    TFHpple *xpathParser = [[TFHpple alloc]initWithHTMLData:htmlData];

//    NSArray *itemArray = [xpathParser searchWithXPathQuery:@"//div[@class='qy-mod-link-wrap']//img"];
//    NSArray *itemArray = [xpathParser searchWithXPathQuery:@"//img[@class='qy-mod-cover']"];
    NSArray *itemArray = [xpathParser searchWithXPathQuery:@"//div[@class='title-wrap ']"];
//    NSArray *itemArray = [xpathParser searchWithXPathQuery:@"//img[@class='qy-mod-cover fadeOutIn-enter-active']"];
//    NSArray *itemArray = [xpathParser searchWithXPathQuery:@"//div[@id='root']"];

    
    NSMutableArray *content = [NSMutableArray array];
    for (TFHppleElement *hppleElement in itemArray) {
        NSArray *childrens = hppleElement.children;
        
        NSString *raw = hppleElement.raw;
        
        NSString *u = [self removeSpaceAndNewline1:raw];
//        if (childrens.count >= 5) {
//            NSDictionary *dic = childrens[3];
//            NSArray *a = dic[@"nodeChildArray"];
//            NSLog(@"");
//        }
        
//        NSString *raw = hppleElement.raw;
//        if (raw.length > 0) {
//            NSArray *itemArray1 = [xpathParser searchWithXPathQuery:@"//div[@class='qy-mod-link-wrap']"];

//            [content addObject:raw];
//        }
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        for (int i = 0; i < childrens.count; i++) {
            TFHppleElement *currentItem = childrens[i];

            

            

            NSString *str = [self removeSpaceAndNewline:currentItem.content];
            if (str.length > 0) {
                NSString *str1 = [str substringToIndex:3];
                if ([str1 doubleValue] > 0.0) {
                    NSLog(@"currentItem*** = %@",str1);
                    [dic setObject:str1 forKey:@"score"];
                    
                    [dic setObject:[str substringFromIndex:3] forKey:@"name"];

                }else {
                    if ([str containsString:@"主演"]) {
                        [dic setObject:str forKey:@"star"];
                    }
                }
                NSLog(@"currentItem = %@",str);
            }

        }
        if ([dic allKeys].count > 0) {
            [content addObject:dic];
        }

    }
    
//    if (content.count > 0) {
//        [self getContent:content];
//        return;
//    }
    
    
    NSLog(@"没有数据");
}

- (NSString *)removeSpaceAndNewline:(NSString *)str

{

NSString *temp = [str stringByReplacingOccurrencesOfString:@" " withString:@""];

temp = [temp stringByReplacingOccurrencesOfString:@"\r" withString:@""];

temp = [temp stringByReplacingOccurrencesOfString:@"\n" withString:@""];

return temp;

}

- (NSString *)removeSpaceAndNewline1:(NSString *)yourString

{

    NSString *pattern = @"((?:http|https)(?::\\/{2}[\\w]+)(?:[\\/|\\.]?)(?:[^\\s""]*))";
    NSRange range = [yourString rangeOfString:pattern options:NSRegularExpressionSearch];
    //credits for the simpler solution go to @Zaph
    return [yourString substringWithRange:range];
}

- (void)getContent:(NSArray *)raws {
    
    NSData *htmlData = [[NSData alloc]initWithBase64EncodedString:raws[0] options:nil];
    TFHpple *xpathParser = [[TFHpple alloc]initWithHTMLData:htmlData];

//    NSArray *itemArray = [xpathParser searchWithXPathQuery:@"//div[@class='qy-mod-link-wrap']//img"];
//    NSArray *itemArray = [xpathParser searchWithXPathQuery:@"//img[@class='qy-mod-cover']"];
    NSArray *itemArray = [xpathParser searchWithXPathQuery:@"//div[@class='qy-mod-link-wrap']"];
}


@end
