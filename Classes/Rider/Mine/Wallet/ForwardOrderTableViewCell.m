//
//  ForwardOrderTableViewCell.m
//  RiderIOS
//
//  Created by Han on 2018/6/11.
//  Copyright © 2018年 Han. All rights reserved.
//

#import "ForwardOrderTableViewCell.h"

@interface ForwardOrderTableViewCell()
{
    
}
@property(nonatomic,weak)IBOutlet UILabel *titleLbl;
@property(nonatomic,weak)IBOutlet UILabel *keyLbl;
@end

@implementation ForwardOrderTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setData:(NSString *)title key:(NSString *)key
{
    self.titleLbl.text = title;
    self.keyLbl.text = key;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
