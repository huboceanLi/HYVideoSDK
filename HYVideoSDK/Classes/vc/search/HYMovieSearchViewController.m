//
//  HYMovieSearchViewController.m
//  AFNetworking
//
//  Created by oceanMAC on 2023/4/26.
//

#import "HYMovieSearchViewController.h"
#import "HYMovieSearchHeadView.h"
#import "HYMovieTempWebView.h"
#import "HYAPIString.h"

@interface HYMovieSearchViewController ()<HYBaseViewDelegate>

@property (nonatomic, strong) HYMovieSearchHeadView *searchHeadView;
@property (nonatomic, strong) HYMovieTempWebView *tempWebView;

@end

@implementation HYMovieSearchViewController

-(UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.searchHeadView.textField becomeFirstResponder];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navBar.backgroundColor = UIColor.whiteColor;
    self.navBar.qmui_borderPosition = QMUIViewBorderPositionBottom;
    self.navBar.qmui_borderColor = [UIColor.lightGrayColor colorWithAlphaComponent:0.3];
    [self.navBackButton setImage:[UIImage sdk_bundleImage:@"31fanhui1"] forState:0];
    
    [self.navBar addSubview:self.searchHeadView];
    [self.searchHeadView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.navBackButton.mas_right).offset(0);
        make.bottom.equalTo(self.navBar.mas_bottom).offset(0);
        make.right.equalTo(self.navBar.mas_right).offset(0);
        make.height.mas_equalTo(40);
    }];
    
}

- (HYMovieSearchHeadView *)searchHeadView {
    if (!_searchHeadView) {
        _searchHeadView = [HYMovieSearchHeadView new];
        _searchHeadView.delegate = self;
    }
    return _searchHeadView;
}

- (HYMovieTempWebView *)tempWebView {
    if (!_tempWebView) {
        _tempWebView = [HYMovieTempWebView new];
        _tempWebView.delegate = self;
    }
    return _tempWebView;
}

- (void)customView:(HYBaseView *)view event:(id)event
{
    if ([view isKindOfClass:[HYMovieSearchHeadView class]]) {
        NSDictionary *dic = event;
        if ([dic[@"isBack"] integerValue] == 1) {
            [self.navigationController popViewControllerAnimated:YES];
        }else {
            NSString *url = [NSString stringWithFormat:@"%@?search_text=%@&cat=1002",API_DouBan_Search_List,dic[@"key"]];
            NSString *encodedString = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            [self.tempWebView getVideoUrl:encodedString];
        }
        return;
    }
    
    if ([view isKindOfClass:[HYMovieTempWebView class]]) {
        NSArray *arr = event;
        if (arr.count != 0) {
        
            NSLog(@"");
            
            return;
        }
        
    }
}
@end
