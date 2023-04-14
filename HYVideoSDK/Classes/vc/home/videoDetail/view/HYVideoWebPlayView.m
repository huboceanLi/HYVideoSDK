//
//  HYVideoWebPlayView.m
//  AFNetworking
//
//  Created by oceanMAC on 2023/4/13.
//

#import "HYVideoWebPlayView.h"
#import <WebKit/WebKit.h>

static NSString *headUrl = @"https://jx.playerjy.com/?url=";

@interface HYVideoWebPlayView()<WKUIDelegate,WKNavigationDelegate>

@property(nonatomic, strong) WKWebView * webView;

@end

@implementation HYVideoWebPlayView

- (void)initSubviews {
    [super initSubviews];
    
    self.backgroundColor = UIColor.blackColor;
    
    WKWebViewConfiguration * config = [[WKWebViewConfiguration alloc] init];
    config.allowsInlineMediaPlayback = YES;

    _webView = [[WKWebView alloc] initWithFrame:CGRectZero configuration:config];
    _webView.UIDelegate = self;
    _webView.scrollView.backgroundColor = UIColor.blackColor;
    _webView.navigationDelegate = self;
    _webView.backgroundColor = UIColor.blackColor;
    [self addSubview:_webView];

    [_webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.top.equalTo(self.mas_top).offset(IS_iPhoneX ? 44 : 24);
    }];
}

- (void)loadContent
{
    HYMovieListItemModel *model = self.data;
    
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",headUrl,model.playUrl]];
    if (url) {
        NSURLRequestCachePolicy policy = NSURLRequestReturnCacheDataElseLoad;
        NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:url cachePolicy:policy timeoutInterval:60];
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
    }];

    NSString *titleSrcString = [NSString stringWithFormat:@"document.getElementsByClassName('weibo-text')[0].getElementsByTagName('a')[0].href"];
    [self.webView evaluateJavaScript:titleSrcString completionHandler:^(id _Nullable result, NSError * _Nullable error) {
        // 超话链接
        NSLog(@"标题链接抓取结果:%@", result);
    }];

    NSString *titleString = [NSString stringWithFormat:@"document.getElementsByClassName('weibo-text')[0].textContent"];
    [self.webView evaluateJavaScript:titleString completionHandler:^(id _Nullable result, NSError * _Nullable error) {
        // 标题
        NSLog(@"标题抓取结果:%@", result);
    }];

    NSString *imageSrcString = [NSString stringWithFormat:@"document.getElementsByClassName('m-img-box')[0].getElementsByTagName('img')[0].src"];
    [self.webView evaluateJavaScript:imageSrcString completionHandler:^(id _Nullable result, NSError * _Nullable error) {
        // 取一个头像地址
        NSLog(@"头像抓取结果:%@", result);
    }];

    NSString *authorString = [NSString stringWithFormat:@"document.getElementsByClassName('m-text-cut')[0].textContent"];
    [self.webView evaluateJavaScript:authorString completionHandler:^(id _Nullable result, NSError * _Nullable error) {
        // 自媒体名称
        NSLog(@"自媒体名称抓取结果:%@", result);
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
    NSLog(@"didReceiveServerRedirectForProvisionalNavigation");
}

//根据WebView对于即将跳转的HTTP请求头信息和相关信息来决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    NSLog(@"decidePolicyForNavigationAction");

    decisionHandler(WKNavigationActionPolicyAllow);
}

//根据客户端收到的服务器响应头以及response相关信息来决定是否可以跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler {
    NSLog(@"decidePolicyForNavigationResponse%@",navigationResponse.response);

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
