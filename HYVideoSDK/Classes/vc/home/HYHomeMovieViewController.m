//
//  HYHomeMovieViewController.m
//  HYVideoSDK
//
//  Created by oceanMAC on 2023/4/24.
//

#import "HYHomeMovieViewController.h"
#import "HYHomeVideoHeadView.h"
#import "HYVideoHomeListCell.h"
#import "HYVideoDetailViewController.h"
#import "HYMovieSearchViewController.h"

@interface HYHomeMovieViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) HYHomeVideoHeadView *videoHeadView;
@property (nonatomic, assign) CGFloat headHeight;
@property (nonatomic, strong) UIButton *searchBtn;


@end

@implementation HYHomeMovieViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.hidesBottomBarWhenPushed = NO;
    self.tabBarController.tabBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navTitleLabel.text = @"爱奇艺最近热播";
    [[HYVideoPlayTypeManager shareInstance] getPlayTypeLisy];

    [self.navBar addSubview:self.searchBtn];
    [self.searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.navBar.mas_right).offset(-6);
        make.bottom.equalTo(self.navBar.mas_bottom).offset(0);
        make.width.height.mas_equalTo(40);
    }];
    
    __weak typeof(self) weakSelf = self;
    [self.searchBtn blockEvent:^(UIButton *button) {
        HYMovieSearchViewController *vc = [HYMovieSearchViewController new];
        [weakSelf.navigationController pushViewController:vc animated:YES];
    }];
    
    self.dataArray = [NSMutableArray array];
    
//    [[HYVideoPlayTypeManager shareInstance] getPlayTypeLisy];
    
    CGFloat leftSpace = 15;
    CGFloat space = 8;
    NSInteger count = 3;
    CGFloat w = ceil((SCREEN_WIDTH - leftSpace * 2 - space * 2) / count) - 1;
    CGFloat h = 160 * w / 120 + 6 + 20;
    
    self.headHeight = 140.0;
    
    UICollectionViewFlowLayout * flow = [[UICollectionViewFlowLayout alloc] init];
    flow.sectionInset = UIEdgeInsetsMake(leftSpace, leftSpace, leftSpace, leftSpace);
    flow.itemSize = CGSizeMake(w, h);
    flow.scrollDirection = UICollectionViewScrollDirectionVertical;
    flow.minimumLineSpacing = space;
    flow.minimumInteritemSpacing = space;
//    flow.headerReferenceSize = CGSizeMake(SCREEN_WIDTH, 100);
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flow];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor =  [UIColor clearColor];
    //    _collectionView.scrollEnabled = YES;
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.pagingEnabled = NO;
    [_collectionView setContentInset:UIEdgeInsetsMake(0, 0, (IS_iPhoneX ? 34 : 0), 0)];
    [_collectionView registerClass:[HYVideoHomeListCell class] forCellWithReuseIdentifier:@"cell"];
    [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerView"];
    //    [_collectionView registerNib:[UINib nibWithNibName:@"HYVideoHomeListCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
    if (@available (iOS 11.0, *)) {
        [self.collectionView setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
    }
    [self.view addSubview:_collectionView];
    
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.navBar.mas_bottom).offset(0);
        make.bottom.equalTo(self.view.mas_bottom).offset(- (IS_iPhoneX ? 80 : 50));
    }];
}

#pragma mark  --- UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
//    return 11;

    return self.dataArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    HYVideoHomeListCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
//    cell.delegate = self;
//
//    cell.data =
//    [cell loadContent];

    HYDouBanMovieItemModel *model = self.dataArray[indexPath.row];
    
    [cell.headImageView setImageWithURL:[NSURL URLWithString:model.pic.large] placeholder:nil];
    cell.name.text = model.title;
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    HYVideoDetailViewController *vc = [HYVideoDetailViewController new];
    vc.movieModel = self.dataArray[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(SCREEN_WIDTH, self.headHeight);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if (kind == UICollectionElementKindSectionHeader) {
        
        UICollectionReusableView *headView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerView" forIndexPath:indexPath];
        headView.backgroundColor = UIColor.whiteColor;
//        [headView.subviews makeObjectsPerformSelector: @selector(removeFromSuperview)];

        if (!self.videoHeadView) {
            self.videoHeadView = [[HYHomeVideoHeadView alloc] initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, self.headHeight - 20.0)];
            [headView addSubview:self.videoHeadView];
            
            __weak typeof(self) _self = self;
            
            [self.videoHeadView setHeadHeightBlock:^(CGFloat headHeight) {
                _self.headHeight = headHeight + 20;
                [_self.collectionView reloadData];
            }];

            [self.videoHeadView setMovieListBlock:^(NSArray * _Nonnull list) {
                [_self.dataArray addObjectsFromArray:list];
                [_self.collectionView reloadData];
            }];
        }


        return headView;
    }
    return nil;
}

- (UIButton *)searchBtn {
    if (!_searchBtn) {
        _searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_searchBtn setImage:[UIImage sdk_bundleImage:@"sousuo"] forState:0];
    }
    return _searchBtn;
}

@end
