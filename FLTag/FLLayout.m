//
//  FLLayout.m
//  FLTag
//
//  Created by Felix on 2017/5/11.
//  Copyright © 2017年 FREEDOM. All rights reserved.
//

#import "FLLayout.h"

@interface FLLayout ()
{
    CGFloat _contentHeight;
}
@property (nonatomic, assign) CGFloat columnSpace;
@property (nonatomic, assign) CGFloat rowSpace;
@property (nonatomic, assign) CGFloat itemHeight;
@property (nonatomic, assign) CGFloat textInset;        //字距离边界的距离
@property (nonatomic, assign) CGFloat minItemWidth;

@property (nonatomic, assign) UIEdgeInsets insets;
@property (nonatomic, strong) NSMutableDictionary *dic;
@property (nonatomic, strong) NSMutableArray *array;
@property (nonatomic, strong) NSMutableDictionary *attributeDic;

@property (nonatomic, assign) CGPoint point;            //记录每一个item的origin


@end

@implementation FLLayout
- (instancetype)init{
    if (self = [super init]) {
        _columnSpace = 8;
        _rowSpace = 16;
        _textInset = 23;
        _minItemWidth = 102;
        _insets = UIEdgeInsetsMake(16, 27, 16, 26);
        _itemHeight = 36;
        _point = CGPointMake(_insets.left, _insets.top);
        _array = [NSMutableArray array];
        _dic = [NSMutableDictionary dictionary];
        _attributeDic = [NSMutableDictionary dictionary];
    }
    return self;
}
- (CGSize)collectionViewContentSize{
    return CGSizeMake(kWidth, _contentHeight);
}
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    NSMutableArray * array = [NSMutableArray array];
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    for (int i = 0; i < count; i++) {
        UICollectionViewLayoutAttributes * attrs = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
        [array addObject:attrs];
    }
    
    [_dic enumerateKeysAndObjectsUsingBlock:^(NSString *y, NSArray *arr, BOOL * _Nonnull stop) {
        CGFloat width = 0;
        CGFloat originX = 0;
        for (int i=0; i<arr.count; i++) {
            UICollectionViewLayoutAttributes *att = arr[i];
            width += att.frame.size.width;
            if (i == 0) originX = att.frame.origin.x;
        }
        width += (arr.count-1)*_columnSpace;
        CGFloat startX = (kWidth-width)/2.;
        CGFloat cha = startX - originX;
        for (int i=0; i<arr.count; i++) {
            UICollectionViewLayoutAttributes *att = arr[i];
            att.frame = CGRectMake(att.frame.origin.x+cha, att.frame.origin.y, att.frame.size.width, att.frame.size.height);
            [_attributeDic setObject:att forKey:att.indexPath];
        }
    }];
    
    [_dic removeAllObjects];
    [_array removeAllObjects];
    return  array;
}

- (nullable UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    if ([_attributeDic objectForKey:indexPath]) {
        UICollectionViewLayoutAttributes *att = [_attributeDic objectForKey:indexPath];
        return att;
    }
    NSString *text = [self.dataSource collectionView:self.collectionView textForItemAtIndexPath:indexPath];
    NSString *nextText;
    if (indexPath.item != [self.collectionView numberOfItemsInSection:0]-1) {
        nextText = [self.dataSource collectionView:self.collectionView textForItemAtIndexPath:[NSIndexPath indexPathForRow:indexPath.item+1 inSection:0]];
    }else{
        nextText = nil;
    }
    
    CGFloat x = _point.x;
    CGFloat y = _point.y;
    CGFloat width;
    if (text.length <= 4) {
        width = _minItemWidth;
    }else{
        width = [self getWidthByString:text withFont:[UIFont systemFontOfSize:14]] + 46;
    }
    CGFloat nextWidth;
    if(!nextText){
        nextWidth = 0;
    }else{
        if (nextText.length <= 4) {
            nextWidth = _minItemWidth;
        }else{
            nextWidth = [self getWidthByString:nextText withFont:[UIFont systemFontOfSize:14]] + 46;
        }
    }
    
    UICollectionViewLayoutAttributes * attribute = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    attribute.frame = CGRectMake(x, y, width, _itemHeight);
    
    
    if (_point.x > kWidth-width-_columnSpace-nextWidth-_insets.right) {
        //下一个item需要换行了
        [_array addObject:attribute];
        [_dic setObject:[_array copy] forKey:[NSString stringWithFormat:@"%.f",_point.y]];
        [_array removeAllObjects];
        
        _point = CGPointMake(_insets.left, _point.y+_itemHeight+_rowSpace);
    }else{
        [_array addObject:attribute];
        _point = CGPointMake(_point.x+width+_columnSpace, _point.y);
    }
    
    if (indexPath.item == [self.collectionView numberOfItemsInSection:0]-1) {
        [_dic setObject:[_array copy] forKey:[NSString stringWithFormat:@"%.f",_point.y]];
        
        _contentHeight = _point.y+_itemHeight+_insets.bottom;
        _point = CGPointMake(_insets.left, _insets.top);
        
    }
    return attribute;
}
-(CGFloat)getWidthByString:(NSString*)string withFont:(UIFont*)font
{
    CGSize size = [string boundingRectWithSize:CGSizeMake(LONG_MAX, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
    return size.width ;
}
@end
