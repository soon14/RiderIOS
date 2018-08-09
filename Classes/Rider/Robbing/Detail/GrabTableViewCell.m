//
//  GrabTableViewCell.m
//  RiderDemo
//
//  Created by mac on 2018/1/17.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "GrabTableViewCell.h"

@interface GrabTableViewCell()
{
    IBOutlet UILabel *nameLbl;
    IBOutlet UILabel *numLnl;
}
@end

@implementation GrabTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
