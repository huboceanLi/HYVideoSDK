//
//  HYHomeCategeryView.m
//  HYVideoSDK
//
//  Created by oceanMAC on 2023/4/24.
//

#import "HYHomeCategeryView.h"
#import "HYHomeCategeryCell.h"

@interface HYHomeCategeryView()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation HYHomeCategeryView

- (void)initSubviews {
    [super initSubviews];
    
    CGFloat leftSpace = 15;
    CGFloat space = 8;
//    NSInteger count = 3;
//    CGFloat w = ceil((SCREEN_WIDTH - leftSpace * 2 - space * 2) / count) - 1;
//    CGFloat h = 160 * w / 120 + 6 + 20;
    
    UICollectionViewFlowLayout * flow = [[UICollectionViewFlowLayout alloc] init];
    flow.sectionInset = UIEdgeInsetsMake(0, leftSpace, 0, leftSpace);
//    flow.itemSize = CGSizeMake(w, h);
    flow.scrollDirection = UICollectionViewScrollDirectionHorizontal;
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
    [_collectionView registerClass:[HYHomeCategeryCell class] forCellWithReuseIdentifier:@"cell"];

    //    [_collectionView registerNib:[UINib nibWithNibName:@"HYVideoHomeListCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
    if (@available (iOS 11.0, *)) {
        [self.collectionView setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
    }
    [self addSubview:_collectionView];
    
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.centerY.equalTo(self);
        make.height.mas_equalTo(30);
    }];
}

#pragma mark  --- UICollectionViewDataSource
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    HYDouBanCategeryTempModel *m = self.dataArray[indexPath.row];
    return CGSizeMake(m.cellWidth, 30);
}
//- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section;
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section;
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section;
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section;
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section;
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
    
    HYHomeCategeryCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
//    cell.delegate = self;

    cell.data = self.dataArray[indexPath.row];
    [cell loadContent];

    if (indexPath.row == 0) {
        cell.backgroundColor = [UIColor.lightGrayColor colorWithAlphaComponent:0.3];
    }else {
        cell.backgroundColor = UIColor.clearColor;
    }
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (void)loadContent {
    
    NSMutableArray *temArray = [NSMutableArray array];
    
    NSArray *a = self.data;

    for (int i = 0; i < a.count; i++) {
        NSString *item = a[i];
        HYDouBanCategeryTempModel *m = [HYDouBanCategeryTempModel new];

        if (i == 0) {
            if ([item containsString:@"全部"]) {
                m.name = @"全部";
            }
        }
//        else if ([item containsString:@"年代"]) {
//            m.name = [NSString stringWithFormat:@"%@年",[item substringToIndex:item.length - 2]];
//        }
        else {
            m.name = item;
        }
        CGFloat w = [m.name widthForFont:[UIFont systemFontOfSize:13]];
        
        m.cellWidth = ceil(w) + 20;
        
        [temArray addObject:m];
    }

    self.dataArray = [temArray mutableCopy];

    [self.collectionView reloadData];
}

@end
