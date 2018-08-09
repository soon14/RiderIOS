//
//  AppealListTableViewCell.m
//  RiderIOS
//
//  Created by Han on 2018/6/12.
//  Copyright © 2018年 Han. All rights reserved.
//

#import "AppealListTableViewCell.h"

@interface AppealListTableViewCell()
{
    
}
@property(nonatomic,weak)IBOutlet UILabel *shopLbl;
@property(nonatomic,weak)IBOutlet UILabel *addrLbl;
@property(nonatomic,weak)IBOutlet UILabel *timeLbl;
@property(nonatomic,weak)IBOutlet UILabel *idNum;
@end

@implementation AppealListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code

}

- (void)setData:(AppealModel *)mode
{
    self.shopLbl.text = mode.shop_name;
    self.addrLbl.text = mode.addr;
    self.timeLbl.text = mode.create_time;
    self.idNum.text = [NSString stringWithFormat:@"运单号：%@",mode.type_order_id];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
