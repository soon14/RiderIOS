//
//  OrderInfoTableViewCell.m
//  RiderIOS
//
//  Created by Han on 2018/6/6.
//  Copyright © 2018年 Han. All rights reserved.
//

#import "OrderInfoTableViewCell.h"

@interface OrderInfoTableViewCell()
{
    
}
@property(nonatomic,weak)IBOutlet UILabel *titleLbl;
@property(nonatomic,weak)IBOutlet UILabel *contentLbl;
@end

@implementation OrderInfoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setTitle:(NSString *)title withData:(NSString *)data
{
    self.titleLbl.text = title;
    self.contentLbl.text = data;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
