//
//  HYMovieTempWebView.m
//  HYVideoSDK
//
//  Created by oceanMAC on 2023/4/26.
//

#import "HYMovieTempWebView.h"
#import <WebKit/WebKit.h>

#import "TFHpple.h"
#import "TFHppleElement.h"
#import "XPathQuery.h"

@interface HYMovieTempWebView()<WKUIDelegate,WKNavigationDelegate>

@property(nonatomic, strong) WKWebView * webView;

@end

@implementation HYMovieTempWebView

- (void)initSubviews {
    [super initSubviews];
    
    WKWebViewConfiguration * config = [[WKWebViewConfiguration alloc] init];
    config.allowsInlineMediaPlayback = YES;

    _webView = [[WKWebView alloc] initWithFrame:CGRectZero configuration:config];
    _webView.UIDelegate = self;
    _webView.scrollView.backgroundColor = UIColor.blackColor;
    _webView.navigationDelegate = self;
//    _webView.scrollView.scrollEnabled = NO;
    _webView.backgroundColor = UIColor.blackColor;
    [self addSubview:_webView];

    [_webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.top.equalTo(self);
    }];
}

- (void)getVideoUrl:(NSString *)url
{
    NSURL * urlStr = [NSURL URLWithString:url];
    if (urlStr) {
        NSURLRequestCachePolicy policy = NSURLRequestReturnCacheDataElseLoad;
        NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:urlStr cachePolicy:policy timeoutInterval:60];
        [self.webView loadRequest:request];
    }
}

#pragma mark-- <WKNavigationDelegate>
//页面开始加载
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {

}

//页面加载失败
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {

}

//当内容开始返回
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
}

//页面加载完成
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {

    [self.webView evaluateJavaScript:@"document.body.innerHTML" completionHandler:^(id _Nullable result, NSError * _Nullable error) {
        NSLog(@"网页抓取结果:%@", result);
        
        NSData *htmlData =[result dataUsingEncoding:NSUTF8StringEncoding];
        TFHpple *xpathParser = [[TFHpple alloc]initWithHTMLData:htmlData];

        NSArray *itemArray = [xpathParser searchWithXPathQuery:@"//div[@class='item-root']"];
        
        NSMutableArray *array = [NSMutableArray array];
        for (TFHppleElement *hppleElement in itemArray) {
//            NSArray *childrens = hppleElement.children;
//
            NSString *raw = hppleElement.raw;
            if ((raw.length > 0 || raw != nil) && [raw containsString:@"可播放"]) {
                [array addObject:raw];
            }
        }
        NSMutableArray *searchData = [NSMutableArray array];
        
        for (NSString *item in array) {
            HYDouBanSearchModel *model = [HYDouBanSearchModel new];
            
            NSData *htmlData1 =[item dataUsingEncoding:NSUTF8StringEncoding];
            TFHpple *xpathParser1 = [[TFHpple alloc]initWithHTMLData:htmlData1];

            //中国大陆 / 剧情 / 犯罪 / Punch Out / The Knockout / 45分钟
            NSArray *itemArray1 = [xpathParser1 searchWithXPathQuery:@"//div[@class='meta abstract']"];
            if (itemArray1.count > 0) {
                TFHppleElement *hppleElement = itemArray1.firstObject;
                NSLog(@"简介: %@",hppleElement.content);
                model.brief = hppleElement.content;
            }
            
            
            NSArray *itemArray2 = [xpathParser1 searchWithXPathQuery:@"//div[@class='meta abstract_2']"];
            if (itemArray2.count > 0) {
                TFHppleElement *hppleElement = itemArray2.firstObject;
                NSLog(@"主演: %@",hppleElement.content);
                model.actors = hppleElement.content;

            }
            
            NSArray *itemArray3 = [xpathParser1 searchWithXPathQuery:@"//span[@class='rating_nums']"];
            if (itemArray3.count > 0) {
                TFHppleElement *hppleElement = itemArray3.firstObject;
                NSLog(@"评分: %@",hppleElement.content);
                model.rate = hppleElement.content;
            }
            
            NSArray *itemArray5 = [xpathParser1 searchWithXPathQuery:@"//a[@class='title-text']"];
            if (itemArray5.count > 0) {
                TFHppleElement *hppleElement = itemArray5.firstObject;
                NSLog(@"标题: %@",hppleElement.content);
                model.name = hppleElement.content;
            }
            
            NSArray *itemArray4 = [xpathParser1 searchWithXPathQuery:@"//img[@src]"];
            if (itemArray4.count > 0) {
                TFHppleElement *hppleElement = itemArray4.firstObject;
                
                NSDictionary *dic = hppleElement.attributes;
                if ([dic.allKeys containsObject:@"src"]) {
                    NSLog(@"展示图: %@",dic[@"src"]);
                    model.pic = dic[@"src"];
                }
            }
            
            NSArray *itemArray6 = [xpathParser1 searchWithXPathQuery:@"//a[@href]"];
            if (itemArray6.count > 0) {
                TFHppleElement *hppleElement = itemArray6.firstObject;
                NSDictionary *dic = hppleElement.attributes;
                if ([dic.allKeys containsObject:@"data-moreurl"]) {
                    NSString *inputString = dic[@"data-moreurl"];
                    NSString *pattern = @"subject_id:'(\\d+)'"; // 匹配 subject_id 参数的值
                    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:0 error:nil];
                    NSTextCheckingResult *match = [regex firstMatchInString:inputString options:0 range:NSMakeRange(0, inputString.length)];

                    if (match) {
                        NSRange matchRange = [match rangeAtIndex:1];
                        NSString *mapValue = [inputString substringWithRange:matchRange];
//                        NSLog(@"mapValue: %@", mapValue); // 输出: "35465232"
                        NSLog(@"ID: %@",mapValue);
                        if (mapValue == nil || mapValue.length == 0) {
                            continue;
                        }
                        model.ID = mapValue;

                    } else {
                        NSLog(@"No match found.");
                    }
                    
                }
            }
            [searchData addObject:model];
        }
        
        if ([self.delegate respondsToSelector:@selector(customView:event:)]) {
            [self.delegate customView:self event:searchData];
        }
    }];
    NSLog(@"didFinishNavigation");
}

//提交发生错误
- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    if(error.code==NSURLErrorCancelled) {
        [self webView:webView didFinishNavigation:navigation];
    } else {
//        [SVProgressHUD showErrorWithStatus:@"打开失败"];

    }
}

//接收到服务器跳转请求即服务重定向
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation {
//    NSLog(@"didReceiveServerRedirectForProvisionalNavigation");
}

//根据WebView对于即将跳转的HTTP请求头信息和相关信息来决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
//    NSLog(@"decidePolicyForNavigationAction");

    decisionHandler(WKNavigationActionPolicyAllow);
}

//根据客户端收到的服务器响应头以及response相关信息来决定是否可以跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler {
//    NSLog(@"decidePolicyForNavigationResponse%@",navigationResponse.response);

    decisionHandler(WKNavigationResponsePolicyAllow);
}

/*

//需要响应身份验证时调用 同样在block中需要传入用户身份凭证
- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential * _Nullable))completionHandler {
    //用户身份信息
    NSURLCredential * newCred = [[NSURLCredential alloc] initWithUser:@"user123" password:@"123" persistence:NSURLCredentialPersistenceNone];
    //为 challenge 的发送方提供 credential
    [challenge.sender useCredential:newCred forAuthenticationChallenge:challenge];
    completionHandler(NSURLSessionAuthChallengeUseCredential,newCred);
}

*/

//进程被终止时调用
- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView {}

#pragma mark-- <WKUIDelegate>
/**
     *  web界面中有弹出警告框时调用
     *
     *  @param webView           实现该代理的webview
     *  @param message           警告框中的内容
     *  @param completionHandler 警告框消失调用
     */
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler {
//    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"HTML的弹出框" message:message?:@"" preferredStyle:UIAlertControllerStyleAlert];
//    [alertController addAction:([UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        completionHandler();
//    }])];
//    [self presentViewController:alertController animated:YES completion:nil];
}
    // 确认框
    //JavaScript调用confirm方法后回调的方法 confirm是js中的确定框，需要在block中把用户选择的情况传递进去
- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL))completionHandler{
//    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:message?:@"" preferredStyle:UIAlertControllerStyleAlert];
//    [alertController addAction:([UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//        completionHandler(NO);
//    }])];
//    [alertController addAction:([UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        completionHandler(YES);
//    }])];
//    [self presentViewController:alertController animated:YES completion:nil];
}
    // 输入框
    //JavaScript调用prompt方法后回调的方法 prompt是js中的输入框 需要在block中把用户输入的信息传入
- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * _Nullable))completionHandler{
//    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:prompt message:@"" preferredStyle:UIAlertControllerStyleAlert];
//    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
//        textField.text = defaultText;
//    }];
//    [alertController addAction:([UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        completionHandler(alertController.textFields[0].text?:@"");
//    }])];
//    [self presentViewController:alertController animated:YES completion:nil];
}
    // 页面是弹出窗口 _blank 处理
- (WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures {
    if (!navigationAction.targetFrame.isMainFrame) {
        [webView loadRequest:navigationAction.request];
    }
    return nil;
}
@end
