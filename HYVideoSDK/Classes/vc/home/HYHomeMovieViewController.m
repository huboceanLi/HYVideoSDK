//
//  HYHomeMovieViewController.m
//  HYVideoSDK
//
//  Created by oceanMAC on 2023/4/24.
//

#import "HYHomeMovieViewController.h"
#import "HYHomeVideoHeadView.h"
#import "HYVideoHomeListCell.h"

@interface HYHomeMovieViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation HYHomeMovieViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navTitleLabel.text = @"爱奇艺最近热播";

    self.dataArray = [NSMutableArray array];
    
//    [[HYVideoPlayTypeManager shareInstance] getPlayTypeLisy];
    
    CGFloat leftSpace = 15;
    CGFloat space = 8;
    NSInteger count = 3;
    CGFloat w = ceil((SCREEN_WIDTH - leftSpace * 2 - space * 2) / count) - 1;
    CGFloat h = 160 * w / 120 + 6 + 20;
    
    UICollectionViewFlowLayout * flow = [[UICollectionViewFlowLayout alloc] init];
    flow.sectionInset = UIEdgeInsetsMake(leftSpace, leftSpace, leftSpace, leftSpace);
    flow.itemSize = CGSizeMake(w, h);
    flow.scrollDirection = UICollectionViewScrollDirectionVertical;
    flow.minimumLineSpacing = space;
    flow.minimumInteritemSpacing = space;
    flow.headerReferenceSize = CGSizeMake(SCREEN_WIDTH, 100);
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flow];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor =  [UIColor clearColor];
    //    _collectionView.scrollEnabled = YES;
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.pagingEnabled = NO;
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
    
    
    [HYDouBanAFRequestWorking getMovieListWithStart:0 type:@"全部" area:@"全部" years:@"全部" tags:@"全部" completionHandle:^(NSArray * _Nonnull model, BOOL success) {
            
    }];
}

#pragma mark  --- UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 11;

//    return self.dataArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    HYVideoHomeListCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
//    cell.delegate = self;
//
//    cell.data = self.dataArray[indexPath.row];
//    [cell loadContent];

    
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if (kind == UICollectionElementKindSectionHeader) {
        
        UICollectionReusableView *headView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerView" forIndexPath:indexPath];
        headView.backgroundColor = UIColor.greenColor;
        [headView.subviews makeObjectsPerformSelector: @selector(removeFromSuperview)];

        HYHomeVideoHeadView *head = [[HYHomeVideoHeadView alloc] initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, 160)];
        [headView addSubview:head];

        return headView;
    }
    return nil;
}

@end
