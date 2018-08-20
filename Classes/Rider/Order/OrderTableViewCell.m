//
//  OrderTableViewCell.m
//  RiderIOS
//
//  Created by Han on 2018/6/7.
//  Copyright © 2018年 Han. All rights reserved.
//

#import "OrderTableViewCell.h"

@interface OrderTableViewCell()
{
}
@property(nonatomic,weak)IBOutlet UILabel *timeLbl;
@property(nonatomic,weak)IBOutlet UILabel *stadusLbl;
@property(nonatomic,weak)IBOutlet UILabel *takeLbl;
@property(nonatomic,weak)IBOutlet UILabel *take1Lbl;
@property(nonatomic,weak)IBOutlet UILabel *giveLbl;
@property(nonatomic,weak)IBOutlet UILabel *give1Lbl;
@property(nonatomic,weak)IBOutlet UILabel *ydLbl;
@end

@implementation OrderTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setIndex:(NSInteger)indexRow withData:(DistributionMode *)mode
{
    self.takeLbl.textColor = [UIColor blackColor];
    self.take1Lbl.textColor = [UIColor blackColor];
    self.giveLbl.textColor = [UIColor blackColor];
    self.give1Lbl.textColor = [UIColor blackColor];
    self.timeLbl.textColor = [UIColor blackColor];
    self.stadusLbl.textColor = [UIColor blackColor];
    self.take1Lbl.text = mode.shop_name;
    self.give1Lbl.text = mode.addrmerch;
    self.ydLbl.text = @"运单号:111111111";
    if (indexRow == 0) {
        self.stadusLbl.text = @"结算中12.80元";
    }
    else if (indexRow == 1) {
        self.stadusLbl.text = @"已发放12.80元";
    }
    else if (indexRow == 2) {
        self.stadusLbl.text = @"审核中";
    }
    else if (indexRow == 3) {
        self.stadusLbl.text = @"已审核";
    }
    else
    {
        self.takeLbl.textColor = [UIColor lightGrayColor];
        self.take1Lbl.textColor = [UIColor lightGrayColor];
        self.giveLbl.textColor = [UIColor lightGrayColor];
        self.give1Lbl.textColor = [UIColor lightGrayColor];
        self.timeLbl.textColor = [UIColor lightGrayColor];
        self.stadusLbl.textColor = [UIColor lightGrayColor];
        self.stadusLbl.text = @"已取消";
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
