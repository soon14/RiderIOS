//
//  CustomerTableViewCell.m
//  RiderIOS
//
//  Created by Han on 2018/6/12.
//  Copyright © 2018年 Han. All rights reserved.
//

#import "CustomerTableViewCell.h"

@interface CustomerTableViewCell()
{
    
}

@property(nonatomic,weak)IBOutlet UILabel *typeLbl;
@property(nonatomic,weak)IBOutlet UILabel *contentLbl;
@property(nonatomic,weak)IBOutlet UILabel *timeLbl;
@end

@implementation CustomerTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setData:(CustomerModel *)model
{
    if ([model.yes_no isEqualToString:@"1"]) {
        self.typeLbl.text =  @"满意";
    }
    else
    {
        self.typeLbl.text =  @"不满意";
    }
    
    self.contentLbl.text = model.reason;
    self.timeLbl.text = model.create_time;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
