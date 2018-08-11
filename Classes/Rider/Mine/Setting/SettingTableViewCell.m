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
@property(nonatomic,weak)IBOutlet UILabel *cacheLbl;
@end

@implementation SettingTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setData:(NSString *)name indexRow:(NSInteger)row withCache:(unsigned long long)size
{
    self.nameLbl.text = name;
    self.cacheLbl.hidden = YES;
    
    if (row == 0) {
        self.cacheLbl.hidden = NO;
        if (size >= pow(10, 9)) {
            self.cacheLbl.text = [NSString stringWithFormat:@"%.2fGB", size / pow(10, 9)];
        }else if (size >= pow(10, 6)) {
            self.cacheLbl.text = [NSString stringWithFormat:@"%.2fMB", size / pow(10, 6)];
        }else if (size >= pow(10, 3)) {
            self.cacheLbl.text = [NSString stringWithFormat:@"%.2fKB", size / pow(10, 3)];
        }else {
            self.cacheLbl.text = [NSString stringWithFormat:@"%lluB", size];
        }
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
