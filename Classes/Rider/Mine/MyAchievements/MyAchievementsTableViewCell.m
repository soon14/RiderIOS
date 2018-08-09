//
//  MyAchievementsTableViewCell.m
//  RiderIOS
//
//  Created by Han on 2018/6/28.
//  Copyright © 2018年 Han. All rights reserved.
//

#import "MyAchievementsTableViewCell.h"

@interface MyAchievementsTableViewCell()
{
    
}
@property(nonatomic,weak)IBOutlet UILabel *titleLbl;
@property(nonatomic,weak)IBOutlet UIImageView *iconImage;
@property(nonatomic,weak)IBOutlet UILabel *countLbl;
@property(nonatomic,weak)IBOutlet UILabel *distanceLbl;

@end

@implementation MyAchievementsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setData:(NSString *)title image:(NSString *)imageName withData:(AchievementMode *)mode
{
    self.titleLbl.text =title;
    self.iconImage.image = [UIImage imageNamed:imageName];
    
    self.countLbl.text = [NSString stringWithFormat:@"%@单",mode.count];
    self.distanceLbl.text = [NSString stringWithFormat:@"%@km",mode.distance];;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
