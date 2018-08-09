//
//  WalletTableViewCell.m
//  RiderIOS
//
//  Created by Han on 2018/6/11.
//  Copyright © 2018年 Han. All rights reserved.
//

#import "WalletTableViewCell.h"

@interface WalletTableViewCell()
{
    
}
@property(nonatomic,weak)IBOutlet UILabel *titleLbl;
@property(nonatomic,weak)IBOutlet UIImageView *iconImage;
@end

@implementation WalletTableViewCell


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setData:(NSString *)title imageName:(NSString *)imageName money:(NSString *)money withIndex:(NSInteger )indexRow
{
//    self.moneyLbl.hidden = YES;
    self.titleLbl.text = title;
    self.iconImage.image = [UIImage imageNamed:imageName];
    
//    if (indexRow == 2) {
//        self.moneyLbl.hidden = NO;
//        if ([money isEqualToString:@""]) {
//            self.moneyLbl.text = @"请充值";
//        }
//        else
//        {
//             self.moneyLbl.text = money;
//        }
//    }
   
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
