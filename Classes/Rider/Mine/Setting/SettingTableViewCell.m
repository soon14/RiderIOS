//
//  SettingTableViewCell.m
//  RiderIOS
//
//  Created by Han on 2018/6/13.
//  Copyright © 2018年 Han. All rights reserved.
//

#import "SettingTableViewCell.h"

@interface SettingTableViewCell()
{
    
}
@property(nonatomic,weak)IBOutlet UILabel *nameLbl;
@end

@implementation SettingTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setData:(NSString *)name
{
    self.nameLbl.text = name;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
