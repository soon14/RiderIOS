//
//  BankCardTableViewCell.m
//  RiderIOS
//
//  Created by Han on 2018/7/3.
//  Copyright © 2018年 Han. All rights reserved.
//

#import "BankCardTableViewCell.h"

@interface BankCardTableViewCell()
{
    
}
@property(nonatomic,weak)IBOutlet UIImageView *bcgImage;
@property(nonatomic,weak)IBOutlet UILabel *numberLbl;
@end

@implementation BankCardTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setData:(NSString *)number withName:(NSString *)imageName
{
    self.bcgImage.image = [UIImage imageNamed:imageName];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
