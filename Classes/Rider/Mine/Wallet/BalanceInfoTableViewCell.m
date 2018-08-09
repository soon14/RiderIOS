//
//  BalanceInfoTableViewCell.m
//  RiderDemo
//
//  Created by mac on 2018/1/19.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "BalanceInfoTableViewCell.h"


@interface BalanceInfoTableViewCell()
{
    IBOutlet UILabel *titleLbl;
    IBOutlet UILabel *timeLbl;
    IBOutlet UILabel *moneyLbl;
}

@end

@implementation BalanceInfoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
}

- (void)setData:(BalanceInfMoodel *)mode withType:(NSString *)type
{
    if ([type isEqualToString:@"SZ"]) {
        titleLbl.text = mode.description1;
        if ([mode.type isEqualToString:@"0"]) {
            moneyLbl.text = [NSString stringWithFormat:@"+¥%@",mode.money];
        }
       else
       {
            moneyLbl.text = [NSString stringWithFormat:@"-¥%@",mode.money];
       }
    }
    else
    {
        titleLbl.text = [NSString stringWithFormat:@"¥%@",mode.money];
        moneyLbl.text = mode.description1;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
