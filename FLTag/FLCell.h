//
//  FLCell.h
//  FLTag
//
//  Created by Felix on 2017/5/10.
//  Copyright © 2017年 FREEDOM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FLModel.h"
@interface FLCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UIImageView *image;

@property (nonatomic, strong) FLModel *mod;

@end
