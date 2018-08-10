//
//  PutForwardTableViewCell.m
//  RiderIOS
//
//  Created by Han on 2018/6/29.
//  Copyright © 2018年 Han. All rights reserved.
//

#import "PutForwardTableViewCell.h"

@interface PutForwardTableViewCell()
{
    
}
@property(nonatomic,weak)IBOutlet UILabel *titleLbl;
@property(nonatomic,weak)IBOutlet UIImageView *arrowImage;
@property(nonatomic,weak)IBOutlet UITextField *moneyField;
@property(nonatomic,weak)IBOutlet UILabel *moneyLbl;
@property(nonatomic,weak)IBOutlet UIButton *txBtn;
@property(nonatomic,weak)IBOutlet UIImageView *lineImaeg;
@property(nonatomic,weak)IBOutlet UILabel *bankNameLbl;

@end

@implementation PutForwardTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setData:(NSString *)title bankName:(NSString *)name withIndex:(NSInteger)indexRow
{
    self.titleLbl.text = title;
    self.moneyField.keyboardType = UIKeyboardTypeDecimalPad;
    self.lineImaeg.hidden = NO;
    self.bankNameLbl.hidden = YES;
    
    if (indexRow == 0) {
        self.arrowImage.hidden = NO;
        self.moneyLbl.hidden = YES;
        self.txBtn.hidden = YES;
        self.moneyField.hidden = YES;
        
        if ([name isEqualToString:@""]) {
            self.bankNameLbl.hidden = YES;
        }
        else
        {
            self.bankNameLbl.hidden = NO;
            self.bankNameLbl.text = name;
        }
        
    }
    else if (indexRow == 1)
    {
         self.moneyField.hidden = NO;
        self.arrowImage.hidden = YES;
        self.moneyLbl.hidden = YES;
        self.txBtn.hidden = YES;
    }
    else
    {
        self.moneyField.hidden = YES;
        self.arrowImage.hidden = YES;
         self.moneyLbl.hidden = NO;
         self.txBtn.hidden = NO;
        self.lineImaeg.hidden = YES;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
