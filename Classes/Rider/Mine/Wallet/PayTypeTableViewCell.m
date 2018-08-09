//
//  PayTypeTableViewCell.m
//  RiderIOS
//
//  Created by Han on 2018/6/15.
//  Copyright © 2018年 Han. All rights reserved.
//

#import "PayTypeTableViewCell.h"

@interface PayTypeTableViewCell()
{
    NSInteger index;
}
@property(nonatomic,weak)IBOutlet UILabel *titleLbl;
@property(nonatomic,weak)IBOutlet UIImageView *selectImage;
@property(nonatomic,weak)IBOutlet UIImageView *iconImage;
@end

@implementation PayTypeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setTitle:(NSString *)title image:(NSString *)imageName withIndex:(NSInteger)row
{
    self.titleLbl.text = title;
    self.iconImage.image = [UIImage imageNamed:imageName];
    self.selectImage.image = [UIImage imageNamed:@"unSelect"];
    
    if (index == row)
    {
        self.selectImage.image = [UIImage imageNamed:@"selected"];
    }
    else
    {
        self.selectImage.image = [UIImage imageNamed:@"unSelect"];
    }
}

- (void)selectType:(NSInteger)indexRow
{
    
    index = indexRow;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
