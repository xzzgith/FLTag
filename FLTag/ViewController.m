//
//  ViewController.m
//  FLTag
//
//  Created by Felix on 2017/5/11.
//  Copyright © 2017年 FREEDOM. All rights reserved.
//

#import "ViewController.h"
#import "FLCell.h"
#import "FLLayout.h"
#import "FLModel.h"
@interface ViewController ()<FLLayoutDatasource,UICollectionViewDelegate,UICollectionViewDataSource>
{
    NSMutableArray *_dataArray;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self setupData];
    
    FLLayout *layout = [[FLLayout alloc]init];
    layout.dataSource = self;
    UICollectionView *collection = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, kWidth, 300) collectionViewLayout:layout];
    collection.center = self.view.center;
    collection.delegate = self;
    collection.dataSource = self;
    collection.backgroundColor = [UIColor whiteColor];
    [collection registerNib:[UINib nibWithNibName:@"FLCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
    [self.view addSubview:collection];
    
}

- (NSString *)collectionView:(UICollectionView *)collectionView textForItemAtIndexPath:(NSIndexPath *)indexPath{
    FLModel *mod = _dataArray[indexPath.item];
    return mod.title;
}
#pragma mark - CollectionView Datasource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _dataArray.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    FLCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    FLModel *mod = _dataArray[indexPath.item];
    cell.mod = mod;
    return cell;
}
#pragma mark - CollectionView Delegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    FLModel *mod = _dataArray[indexPath.item];
    mod.isSelected = !mod.isSelected;
    [collectionView reloadItemsAtIndexPaths:@[indexPath]];
}
- (void)setupData{
    _dataArray = [NSMutableArray array];
    NSArray *arr = @[@"旅游观光",@"观点分享",@"日常生活",@"五个字标签",@"六个字的标签",@"休闲娱乐",@"个人经历",@"生活环境",@"健康",@"地理文化",@"沟通技巧",@"日常办公",@"订单物流",@"六个字的标签",@"休闲娱乐"];
    [arr enumerateObjectsUsingBlock:^(NSString *title, NSUInteger idx, BOOL * _Nonnull stop) {
        FLModel *mod = [FLModel new];
        mod.title = title;
        mod.isSelected = NO;
        [_dataArray addObject:mod];
    }];
}

@end
