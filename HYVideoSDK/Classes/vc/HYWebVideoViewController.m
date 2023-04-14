//
//  HYWebVideoViewController.m
//  HYVideoSDK
//
//  Created by oceanMAC on 2023/4/13.
//

#import "HYWebVideoViewController.h"

#import "HYVideoPlayView.h"
#import "HYVideoWebPlayView.h"
#import "HYVideoDetailBriefView.h"
#import "HYVideoDetailToolView.h"
#import "HYVideoDetailSelectWorkView.h"
#import "HYVideoRecommendView.h"

#import "HYVideoBriefDetailView.h"

static CGFloat briefViewHeoght = 60.0;

@interface HYWebVideoViewController ()<HYBaseViewDelegate>

@property(nonatomic, assign) CGFloat playViewHeight;

@property(nonatomic, strong) UIScrollView * scrollView;
@property(nonatomic, strong) HYVideoPlayView * playView;
//@property(nonatomic, strong) HYVideoWebPlayView * playView;
@property(nonatomic, strong) HYVideoDetailBriefView * briefView;
@property(nonatomic, strong) HYVideoDetailToolView * toolView;
@property(nonatomic, strong) HYVideoDetailSelectWorkView * selectWorkView;
@property(nonatomic, strong) HYVideoRecommendView * recommendView;

@property(nonatomic, strong) HYVideoBriefDetailView * briefDetailView;

@property(nonatomic, strong) NSMutableArray *recommendArray;

@end

@implementation HYWebVideoViewController

- (void)dealloc {
    NSLog(@"HYWebVideoViewController 灰飞烟灭！");
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSMutableArray *vcs = [self.navigationController.viewControllers mutableCopy];
    
    for (int i = 0; i < vcs.count; i++) {
        if (i != vcs.count - 1) {
            UIViewController *v = vcs[i];
            if ([v isKindOfClass:[HYWebVideoViewController class]]) {
                [vcs removeObject:v];
                break;
            }
        }
    }
    self.navigationController.viewControllers = [vcs mutableCopy];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navBar.backgroundColor = UIColor.clearColor;
//    self.navTitleLabel.text = @"播放";
    [self.navBackButton setTitle:@"" forState:0];
    
    self.recommendArray = [NSMutableArray array];
    
//    self.playViewHeight = SCREEN_WIDTH * 0.5 + (IS_iPhoneX ? 44 : 24);
    self.playViewHeight = 220 * SCREEN_WIDTH / 390 + (IS_iPhoneX ? 44 : 24);

    
    self.playView = [HYVideoPlayView new];
    [self.view addSubview:self.playView];
    
    self.playView.data = self.movieModel;
    [self.playView loadContent];
    
    [self.playView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        make.height.mas_offset(self.playViewHeight);
    }];
    
    [self.view bringSubviewToFront:self.navBar];

    
    self.scrollView = [UIScrollView new];
    self.scrollView.showsVerticalScrollIndicator = NO;
//    self.scrollView.delegate = self;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:self.scrollView];
    if (@available(iOS 11.0, *)) {
        [self.scrollView setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
    }
    
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.playView.mas_bottom).offset(0);
        make.left.right.bottom.equalTo(self.view);
    }];
    
    self.briefView = [HYVideoDetailBriefView new];
    self.briefView.delegate = self;
    [self.scrollView addSubview:self.briefView];
    self.briefView.data = self.movieModel;
    [self.briefView loadContent];
    
    [self.briefView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.scrollView.mas_top).offset(0);
        make.left.equalTo(self.scrollView);
        make.width.mas_offset(SCREEN_WIDTH);
        make.height.mas_offset(briefViewHeoght);
    }];
    
    self.toolView = [HYVideoDetailToolView new];
    [self.scrollView addSubview:self.toolView];
    
    [self.toolView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.briefView.mas_bottom).offset(0);
        make.left.equalTo(self.scrollView);
        make.width.mas_offset(SCREEN_WIDTH);
        make.height.mas_offset(70);
    }];

    self.selectWorkView = [HYVideoDetailSelectWorkView new];
    [self.scrollView addSubview:self.selectWorkView];
    
    if (self.movieModel.videoCount > 1) {
        [self.selectWorkView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.toolView.mas_bottom).offset(0);
            make.left.equalTo(self.scrollView);
            make.width.mas_offset(SCREEN_WIDTH);
            make.height.mas_offset(briefViewHeoght);
        }];
    }else {
        [self.selectWorkView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.toolView.mas_bottom).offset(0);
            make.left.equalTo(self.scrollView);
            make.width.mas_offset(SCREEN_WIDTH);
            make.height.mas_offset(0);
        }];
    }

    self.recommendView = [HYVideoRecommendView new];
    self.recommendView.delegate = self;
    [self.scrollView addSubview:self.recommendView];

    [self.view addSubview:self.briefDetailView];
    
    self.briefDetailView.data = self.movieModel;
    [self.briefDetailView loadContent];

    self.briefDetailView.hidden = YES;
    
    for (HYMovieListItemModel *item in self.list) {
        if (self.recommendArray.count >= 5) {
            break;
        }
        for (NSString *str in item.categories) {
            if ([self.movieModel.categorieString containsString:str] && ![self.movieModel.name isEqualToString:item.name]) {
                [self.recommendArray addObject:item];
                break;
            }
        }

    }
    if (self.recommendArray.count <= 0) {
        [self.recommendView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.selectWorkView.mas_bottom).offset(0);
            make.left.equalTo(self.scrollView);
            make.width.mas_offset(SCREEN_WIDTH);
            make.height.mas_offset(0);
            make.bottom.equalTo(self.scrollView).offset(-(IS_iPhoneX ? 34 : 20));
        }];
    }else {
        [self.recommendView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.selectWorkView.mas_bottom).offset(0);
            make.left.equalTo(self.scrollView);
            make.width.mas_offset(SCREEN_WIDTH);
            make.height.mas_offset(90 * self.recommendArray.count + 50);
            make.bottom.equalTo(self.scrollView).offset(-(IS_iPhoneX ? 34 : 20));
        }];
    }
    self.recommendView.data = self.recommendArray;
    [self.recommendView loadContent];
}


- (void)customView:(HYBaseView *)view event:(id)event
{
    if ([view isKindOfClass:[HYVideoDetailBriefView class]]) {
        self.briefDetailView.hidden = NO;
        self.briefDetailView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - self.playViewHeight);
        [UIView animateWithDuration:0.2 animations:^{
            self.briefDetailView.frame = CGRectMake(0, self.playViewHeight, SCREEN_WIDTH, SCREEN_HEIGHT - self.playViewHeight);
        }];
        return;
    }
    
    if ([view isKindOfClass:[HYVideoBriefDetailView class]]) {
        [UIView animateWithDuration:0.2 animations:^{
            self.briefDetailView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - self.playViewHeight);
        } completion:^(BOOL finished) {
            self.briefDetailView.hidden = YES;
        }];
        return;
    }
    
    if ([view isKindOfClass:[HYVideoRecommendView class]]) {
        HYMovieListItemModel *model = event;

        HYWebVideoViewController *vc = [HYWebVideoViewController new];
        vc.movieModel = model;
        vc.list = self.list;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (HYVideoBriefDetailView *)briefDetailView {
    if (!_briefDetailView) {
        _briefDetailView = [HYVideoBriefDetailView new];
        _briefDetailView.delegate = self;
    }
    return _briefDetailView;
}

@end
