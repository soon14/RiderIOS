//
//  HelpTableViewCell.m
//  RiderIOS
//
//  Created by Han on 2018/6/12.
//  Copyright © 2018年 Han. All rights reserved.
//

#import "HelpTableViewCell.h"


@interface HelpTableViewCell()
{
    
}
@property(nonatomic,weak)IBOutlet UILabel *titleLbl;
@end

@implementation HelpTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setData:(HelpModel *)mode
{
    self.titleLbl.text = mode.catename;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
