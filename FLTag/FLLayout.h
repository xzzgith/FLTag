//
//  FLLayout.h
//  FLTag
//
//  Created by Felix on 2017/5/11.
//  Copyright © 2017年 FREEDOM. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kWidth [UIScreen mainScreen].bounds.size.width
@protocol FLLayoutDatasource;


@interface FLLayout : UICollectionViewLayout
@property (nonatomic, weak) id<FLLayoutDatasource> dataSource;
@end


@protocol FLLayoutDatasource<NSObject>
@required
- (NSString *)collectionView:(UICollectionView *)collectionView textForItemAtIndexPath:(NSIndexPath*)indexPath;
@end

