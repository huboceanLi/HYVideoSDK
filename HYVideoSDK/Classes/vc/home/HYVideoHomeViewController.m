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
#import "HYVideoHomeListCell.h"
#import "HYVideoHeader.h"

#import "HYWebVideoViewController.h"

@interface HYVideoHomeViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *dataArray;

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
    self.navTitleLabel.text = @"爱奇艺最近热播";

    self.dataArray = [NSMutableArray array];
    
    [[HYVideoPlayTypeManager shareInstance] getPlayTypeLisy];
    
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
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flow];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor =  [UIColor clearColor];
    //    _collectionView.scrollEnabled = YES;
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.pagingEnabled = NO;
    [_collectionView registerClass:[HYVideoHomeListCell class] forCellWithReuseIdentifier:@"cell"];

//    [_collectionView registerNib:[UINib nibWithNibName:@"HYVideoHomeListCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
    if (@available (iOS 11.0, *)) {
        [self.collectionView setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
    }else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    [self.view addSubview:_collectionView];
    
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.navBar.mas_bottom).offset(0);
        make.bottom.equalTo(self.view.mas_bottom).offset(- (IS_iPhoneX ? 80 : 50));
    }];
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [MBProgressHUD showActivityMessageInWindow:@"" timer:30];
        __weak typeof(self) weakSelf = self;
        [HYAFRequestWorking getMovieListWithPage:1 completionHandle:^(NSArray * _Nonnull model, BOOL success) {
            [MBProgressHUD hideHUD];
            if (success) {
                [weakSelf.dataArray addObjectsFromArray:model];
                [weakSelf.collectionView reloadData];
            }
        }];
    });
    

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
    cell.data = self.dataArray[indexPath.row];
    [cell loadContent];

    
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    HYWebVideoViewController *vc = [HYWebVideoViewController new];
    vc.movieModel = self.dataArray[indexPath.row];
    vc.list = self.dataArray;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
