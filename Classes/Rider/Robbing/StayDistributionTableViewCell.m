//
//  StayDistributionTableViewCell.m
//  RiderIOS
//
//  Created by Han on 2018/6/4.
//  Copyright © 2018年 Han. All rights reserved.
//

#import "StayDistributionTableViewCell.h"

@interface StayDistributionTableViewCell ()
@property(nonatomic,weak)IBOutlet UIButton *contactBtn;
@property(nonatomic,weak)IBOutlet UIButton *statusBtn;
@property(nonatomic,weak)IBOutlet UILabel *timeLbl;
@property(nonatomic,weak)IBOutlet UILabel *businessAddr;
@property(nonatomic,weak)IBOutlet UILabel *receiptAddr;
@property(nonatomic,assign)NSInteger index;
@end

@implementation StayDistributionTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setType:(NSString *)type indexPath:(NSIndexPath *)pathRow  withData:(DistributionMode *)mode
{
    self.businessAddr.text = mode.shop_name;
    self.receiptAddr.text = mode.addrmerch;

    self.index = pathRow.row+101;
    if ([type isEqualToString:@"Stay"]) {
        [self.contactBtn setTitle:@"联系商家" forState:UIControlStateNormal];
        [self.statusBtn setTitle:@"我已取货" forState:UIControlStateNormal];
    }
    else
    {
        [self.contactBtn setTitle:@"联系顾客" forState:UIControlStateNormal];
        [self.statusBtn setTitle:@"我已送达" forState:UIControlStateNormal];
    }
}

- (IBAction)contactPress
{
    if (self.didContactButton) {
        self.didContactButton(self.index-101);
    }
}

- (IBAction)statusPress
{
    if (self.didStatusButton) {
        self.didStatusButton(self.index-101);
    }
}

@end
