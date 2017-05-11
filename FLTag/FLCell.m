//
//  FLCell.m
//  FLTag
//
//  Created by Felix on 2017/5/10.
//  Copyright © 2017年 FREEDOM. All rights reserved.
//

#import "FLCell.h"
#define AYRGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define AYRGB(r,g,b) AYRGBA(r,g,b,1.0f)
@implementation FLCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.backView.layer.cornerRadius = 18;
    self.backView.layer.borderWidth = 1;
    self.backView.layer.borderColor = AYRGB(240, 240, 240).CGColor;
    self.image.hidden = NO;
    self.image.image = [UIImage imageNamed:@"button"];
}

- (void)setMod:(FLModel *)mod{
    self.label.text = mod.title;
    self.label.textColor = mod.isSelected ? AYRGB(255, 253, 253) : AYRGB(102, 102, 102) ;
    self.image.hidden = !mod.isSelected;
}
@end
