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

- (void)setData:(NSString *)number withName:(BankModel *)mode
{
   
    if ([mode.bank isEqualToString:@"ICBC"] || [mode.bank isEqualToString:@"CCB"]|| [mode.bank isEqualToString:@"BOC"]|| [mode.bank isEqualToString:@"ABC"]|| [mode.bank isEqualToString:@"CMB"]|| [mode.bank isEqualToString:@"COMM"]|| [mode.bank isEqualToString:@"JSBANK"]|| [mode.bank isEqualToString:@"JSRCU"]) {
         self.bcgImage.image = [UIImage imageNamed:mode.bank];
    }
    else
    {
         self.bcgImage.image = [UIImage imageNamed:@"OTHER"];
    }
    self.numberLbl.text = mode.cardID;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
